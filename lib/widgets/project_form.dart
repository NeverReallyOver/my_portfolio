import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/theme.dart';
import 'package:my_portfolio/widgets/common.dart';

/// Formspree form that forwards submissions to my inbox.
const _formEndpoint = 'https://formspree.io/f/xbdrrqbr';

Future<void> showProjectForm(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierColor: Palette.ink.withValues(alpha: 0.45),
    builder: (_) => const _ProjectFormDialog(),
  );
}

enum _Status { editing, sending, sent, failed }

class _ProjectFormDialog extends StatefulWidget {
  const _ProjectFormDialog();

  @override
  State<_ProjectFormDialog> createState() => _ProjectFormDialogState();
}

class _ProjectFormDialogState extends State<_ProjectFormDialog> {
  static const _needs = [
    'A new app',
    'Real-time or fintech',
    'Speed up an app',
    'Something else'
  ];

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _company = TextEditingController();
  final _budget = TextEditingController();
  final _details = TextEditingController();
  String _need = _needs.first;
  _Status _status = _Status.editing;

  @override
  void dispose() {
    for (final c in [_name, _email, _company, _budget, _details]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _status = _Status.sending);
    try {
      final response = await http.post(
        Uri.parse(_formEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          '_subject':
              'Freelance project: ${_need.toLowerCase()} (${_name.text.trim()})',
          'name': _name.text.trim(),
          'email': _email.text.trim(),
          'company': _company.text.trim(),
          'need': _need,
          'budget_and_timeline': _budget.text.trim(),
          'message': _details.text.trim(),
        }),
      );
      if (!mounted) return;
      setState(() =>
          _status = response.statusCode == 200 ? _Status.sent : _Status.failed);
    } catch (_) {
      if (mounted) setState(() => _status = _Status.failed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mobile = screenSizeOf(context) == ScreenSize.mobile;
    return Dialog(
      backgroundColor: Palette.paper,
      surfaceTintColor: Colors.transparent,
      insetPadding:
          EdgeInsets.symmetric(horizontal: mobile ? 12 : 40, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(mobile ? 22 : 32),
          child: _status == _Status.sent ? _sent() : _form(mobile),
        ),
      ),
    );
  }

  Widget _header(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(title, style: Fonts.title(26))),
        IconButton(
          tooltip: 'Close',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Palette.inkSoft),
        ),
      ],
    );
  }

  Widget _form(bool mobile) {
    final sending = _status == _Status.sending;
    final twoUp = !mobile;
    final name = _Field(
        controller: _name,
        label: 'Your name',
        validator: _required('Please add your name'));
    final email = _Field(
      controller: _email,
      label: 'Email',
      keyboardType: TextInputType.emailAddress,
      validator: (v) {
        final value = v?.trim() ?? '';
        if (value.isEmpty) return 'Please add your email';
        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
          return 'That email doesn\'t look right';
        }
        return null;
      },
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _header('Tell me about your project'),
          const SizedBox(height: 6),
          Text('A few lines is enough. I\'ll reply by email.',
              style: Fonts.body(size: 15)),
          const SizedBox(height: 24),
          if (twoUp)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: name),
                const SizedBox(width: 16),
                Expanded(child: email)
              ],
            )
          else ...[name, const SizedBox(height: 16), email],
          const SizedBox(height: 16),
          _Field(controller: _company, label: 'Company (optional)'),
          const SizedBox(height: 20),
          Text('WHAT DO YOU NEED?', style: Fonts.label(size: 11)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final n in _needs)
                ChoiceChip(
                  label: Text(n),
                  selected: _need == n,
                  onSelected: sending ? null : (_) => setState(() => _need = n),
                  showCheckmark: false,
                  labelStyle: Fonts.body(
                    size: 14,
                    color: _need == n ? Colors.white : Palette.ink,
                    weight: FontWeight.w500,
                  ),
                  selectedColor: Palette.ink,
                  backgroundColor: Palette.paperRaised,
                  side: BorderSide(
                      color: _need == n ? Palette.ink : Palette.hairline),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
            ],
          ),
          const SizedBox(height: 20),
          _Field(
            controller: _details,
            label: 'What are you building?',
            hint:
                'The app, who it\'s for, and anything that already exists (designs, an API, an old app).',
            maxLines: 5,
            validator: (v) => (v?.trim().length ?? 0) < 20
                ? 'Please add a little more detail'
                : null,
          ),
          const SizedBox(height: 16),
          _Field(
              controller: _budget,
              label: 'Budget and timeline (optional)',
              hint: 'For example: ₹1–2 lakh, launch in 3 months'),
          const SizedBox(height: 24),
          if (_status == _Status.failed) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Palette.downSoft,
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'That didn\'t send. Please try again, or email me directly.',
                      style: Fonts.body(size: 14, color: Palette.ink)),
                  const SizedBox(height: 6),
                  const TextLink(
                      label: Profile.email,
                      url: 'mailto:${Profile.email}',
                      arrow: false),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              sending
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Palette.ink))
                  : PrimaryButton(
                      label: 'Send', icon: Icons.arrow_forward, onTap: _submit),
              if (sending) ...[
                const SizedBox(width: 12),
                Text('Sending…',
                    style: Fonts.body(size: 14, color: Palette.muted)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _sent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _header('Thanks, ${_name.text.trim().split(' ').first}.'),
        const SizedBox(height: 10),
        Text(
          'Your message is in my inbox. I\'ll reply to ${_email.text.trim()}.',
          style: Fonts.body(size: 16),
        ),
        const SizedBox(height: 28),
        SecondaryButton(
            label: 'Close', onTap: () => Navigator.of(context).pop()),
      ],
    );
  }

  FormFieldValidator<String> _required(String message) =>
      (v) => (v?.trim().isEmpty ?? true) ? message : null;
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: color, width: width),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: Fonts.label(size: 11)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: Fonts.body(size: 15, color: Palette.ink),
          cursorColor: Palette.accent,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Fonts.body(size: 14, color: Palette.muted),
            hintMaxLines: 3,
            filled: true,
            fillColor: Palette.paperRaised,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            enabledBorder: border(Palette.hairline),
            focusedBorder: border(Palette.accent, 1.5),
            errorBorder: border(Palette.down),
            focusedErrorBorder: border(Palette.down, 1.5),
            errorStyle: Fonts.body(size: 12.5, color: Palette.down),
          ),
        ),
      ],
    );
  }
}
