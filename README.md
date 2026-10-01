# Janakiraman V — Developer Portfolio

My personal portfolio website, built entirely with **Flutter Web** and hosted on
**Firebase Hosting**.

**Live site:** https://janakiraman-portfolio.web.app

## Sections

- **Hero:** name, role and availability
- **About:** summary of my work and how I approach building apps
- **Skills:** technologies and tools I work with
- **Experience:** timeline of roles
- **Projects:** selected work with links
- **Education:** degree and courses
- **Contact:** email, LinkedIn, GitHub and résumé links

Sections animate in on scroll, and the layout adapts from mobile to desktop
widths.

## Tech stack

Flutter (Web) · Dart · `google_fonts` · `url_launcher` ·
Firebase Hosting

## Project structure

```text
lib/
├── main.dart
├── home_screen.dart          # single-page layout + section navigation
├── constants.dart            # colors, breakpoints, spacing
├── data/portfolio_data.dart  # all content (text, links, skills, projects)
└── widgets/                  # one widget per section + nav bar + scroll animation
```

All content lives in `lib/data/portfolio_data.dart`, so updating the site
means editing data, not widgets.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Deploy

```bash
flutter build web --release
firebase deploy --only hosting
```
