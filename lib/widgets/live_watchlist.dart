import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_portfolio/theme.dart';

class _Quote {
  _Quote(this.symbol, this.exchange, this.close) : price = close;

  final String symbol;
  final String exchange;
  final double close;
  double price;
  int direction = 0; // +1 up, -1 down, 0 unchanged in the last batch

  double get changePct => (price - close) / close * 100;
}

/// A phone-framed watchlist fed by a simulated socket. Ticks arrive every
/// 50 ms but the UI only rebuilds every 150 ms, the same batching Mynt uses
/// for live prices.
class LiveWatchlist extends StatefulWidget {
  const LiveWatchlist({super.key, this.width = 300});

  final double width;

  @override
  State<LiveWatchlist> createState() => _LiveWatchlistState();
}

class _LiveWatchlistState extends State<LiveWatchlist> {
  static const _tickInterval = Duration(milliseconds: 50);
  static const _flushInterval = Duration(milliseconds: 150);

  final _random = Random(7);
  final _pending = <int, double>{};
  final _quotes = [
    _Quote('NIFTY 50', 'INDEX', 24850.40),
    _Quote('BANKNIFTY', 'INDEX', 52310.15),
    _Quote('SENSEX', 'INDEX', 81420.90),
    _Quote('RELIANCE', 'NSE', 2948.30),
    _Quote('TCS', 'NSE', 4102.75),
    _Quote('INFY', 'NSE', 1851.20),
    _Quote('HDFCBANK', 'NSE', 1702.60),
    _Quote('ITC', 'NSE', 471.85),
  ];

  late final Timer _ticker;
  late final Timer _flusher;
  int _ticksSinceFlush = 0;
  int _lastBatchSize = 0;

  final _price = NumberFormat('#,##0.00', 'en_IN');

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(_tickInterval, (_) => _onTick());
    _flusher = Timer.periodic(_flushInterval, (_) => _flush());
  }

  @override
  void dispose() {
    _ticker.cancel();
    _flusher.cancel();
    super.dispose();
  }

  // Simulated socket message: one symbol moves by a few basis points.
  void _onTick() {
    final index = _random.nextInt(_quotes.length);
    final current = _pending[index] ?? _quotes[index].price;
    final drift = (_random.nextDouble() - 0.5) * 0.0012;
    _pending[index] = current * (1 + drift);
    _ticksSinceFlush++;
  }

  void _flush() {
    if (!mounted) return;
    setState(() {
      for (var i = 0; i < _quotes.length; i++) {
        final next = _pending[i];
        if (next == null) {
          _quotes[i].direction = 0;
          continue;
        }
        _quotes[i].direction =
            next > _quotes[i].price ? 1 : (next < _quotes[i].price ? -1 : 0);
        _quotes[i].price = next;
      }
      _lastBatchSize = _ticksSinceFlush;
      _ticksSinceFlush = 0;
      _pending.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width;
    return Container(
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Palette.ink,
        borderRadius: BorderRadius.circular(38),
        boxShadow: [
          BoxShadow(
              color: Palette.ink.withValues(alpha: 0.18),
              blurRadius: 40,
              offset: const Offset(0, 24)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ColoredBox(
          color: Palette.paperRaised,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _statusBar(),
              _header(),
              for (final q in _quotes) _row(q),
              _footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 4),
      child: Row(
        children: [
          Text('9:41',
              style: Fonts.label(
                  size: 11, color: Palette.ink, weight: FontWeight.w600)),
          const Spacer(),
          Container(
              width: 56,
              height: 16,
              decoration: BoxDecoration(
                  color: Palette.ink, borderRadius: BorderRadius.circular(10))),
          const Spacer(),
          const Icon(Icons.signal_cellular_alt, size: 13, color: Palette.ink),
          const SizedBox(width: 4),
          const Icon(Icons.battery_full, size: 14, color: Palette.ink),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Watchlist',
                    overflow: TextOverflow.ellipsis,
                    style: Fonts.body(
                        size: 17, color: Palette.ink, weight: FontWeight.w600)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                    color: Palette.upSoft,
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: Palette.up, shape: BoxShape.circle)),
                    const SizedBox(width: 5),
                    Text('LIVE',
                        style: Fonts.label(
                            size: 10,
                            color: Palette.up,
                            weight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 16,
            children: [
              _tab('Markets', selected: true),
              _tab('Holdings'),
              _tab('F&O')
            ],
          ),
        ],
      ),
    );
  }

  Widget _tab(String text, {bool selected = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: Fonts.body(
                size: 12.5,
                color: selected ? Palette.ink : Palette.muted,
                weight: selected ? FontWeight.w600 : FontWeight.w400)),
        const SizedBox(height: 5),
        Container(
            width: 18,
            height: 2,
            color: selected ? Palette.accent : Colors.transparent),
      ],
    );
  }

  Widget _row(_Quote q) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final up = q.changePct >= 0;
    final flash = switch (q.direction) {
      1 => Palette.upSoft,
      -1 => Palette.downSoft,
      _ => Palette.paperRaised,
    };
    return AnimatedContainer(
      duration:
          reduceMotion ? Duration.zero : const Duration(milliseconds: 450),
      curve: Curves.easeOut,
      color: flash,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(q.symbol,
                    style: Fonts.body(
                        size: 13, color: Palette.ink, weight: FontWeight.w600)),
                Text(q.exchange, style: Fonts.label(size: 9.5)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_price.format(q.price),
                  style: Fonts.number(13, color: Palette.ink)),
              const SizedBox(height: 2),
              Text(
                '${up ? '+' : ''}${q.changePct.toStringAsFixed(2)}%',
                style: Fonts.number(11, color: up ? Palette.up : Palette.down),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 16),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Palette.hairline))),
      child: Text(
        '$_lastBatchSize ticks → 1 rebuild / 150 ms',
        style: Fonts.label(size: 10.5),
      ),
    );
  }
}
