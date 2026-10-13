# Janakiraman V — Developer Portfolio

My portfolio site, built with **Flutter Web** and hosted on **Firebase Hosting**.

**Live site:** https://janakiraman-portfolio.web.app

## What's on it

- **Hero** with a live watchlist widget: simulated ticks arrive every 50 ms and
  the UI rebuilds once per 150 ms batch, the same pattern I use for real-time
  prices in production
- **Proof strip:** four numbers from my work on the Mynt trading app
- **Selected work:** a Mynt case study with measured before/after performance
  results, plus internal apps, freelance and side projects
- **Experience**, **About and skills**, **Freelance** and **Contact**

## Design

Editorial and restrained: warm paper background, ink text, one navy accent.
Fraunces for headings, IBM Plex Sans for reading and IBM Plex Mono for labels and
numbers. Layout adapts across phone, tablet and desktop breakpoints.

## Project structure

```text
lib/
├── main.dart
├── home_screen.dart           # page layout, sticky top bar, section scrolling
├── theme.dart                 # colour and type tokens
├── data/portfolio_data.dart   # all copy, figures and links
└── widgets/
    ├── common.dart            # layout width, buttons, links, tags, section header
    ├── top_bar.dart
    ├── hero_section.dart
    ├── live_watchlist.dart    # batched real-time widget
    ├── proof_strip.dart
    ├── work_section.dart      # Mynt case study, project cards, side projects
    └── profile_sections.dart  # experience, about/skills, freelance, contact
test/widget_test.dart          # renders the page at 375, 820 and 1440 px; fails on overflow
```

All content lives in `lib/data/portfolio_data.dart`, so updating the site means
editing data, not widgets.

## Run locally

```bash
flutter pub get
flutter run -d chrome
flutter test
```

## Deploy

Built with WebAssembly. Browsers with WasmGC (Chrome, Edge, Firefox) load the
Wasm build; others fall back to JavaScript automatically. `firebase.json` sets
COOP/COEP headers so the Wasm renderer can run multi-threaded.

```bash
flutter build web --wasm --release
firebase deploy --only hosting
```
