/// All site copy lives here. Every figure is backed by commits, PRs or the
/// Play Store listing; keep it that way when editing.
library;

class Profile {
  static const name = 'Janakiraman Velayutham';
  static const shortName = 'Janakiraman V';
  static const role = 'Flutter Developer';
  static const location = 'Chennai, India';
  static const availability =
      'Open to Flutter roles in Chennai, Bangalore, Dubai and Ireland · 30-day notice · Freelance projects welcome';

  static const email = 'vjanakiraman03@gmail.com';
  static const phone = '+91 74010 33915';
  static const githubUrl = 'https://github.com/NeverReallyOver';
  static const linkedinUrl =
      'https://www.linkedin.com/in/janakiraman-velayutham-6507bb208';
  static const resumePath = 'Janakiraman_Velayutham_Resume.pdf';

  static const myntPlayUrl =
      'https://play.google.com/store/apps/details?id=com.mynt.trading_app_zebu';
  static const myntWebUrl = 'https://myntweb.web.app/';
}

class HeroCopy {
  static const eyebrow = 'Flutter developer · Chennai, India';
  static const headline = 'I build real-time trading apps in Flutter.';
  static const intro =
      'For almost two years I\'ve worked on Mynt, a stock, F&O and mutual fund trading app for '
      'Android, iOS and the web with 10,000+ downloads. Live prices over WebSockets, order flows '
      'that have to be right the first time, and keeping all of it smooth on low-end phones.';
}

class Stat {
  const Stat(this.value, this.caption);
  final String value;
  final String caption;
}

const stats = [
  Stat('10K+', 'Play Store downloads for Mynt, the trading app I work on'),
  Stat('93', 'merged pull requests, the most on a 10-person team'),
  Stat('13', 'consecutive releases I shipped to Google Play and the App Store'),
  Stat('−96%',
      'frame stutters after my performance work, measured on a low-end phone'),
];

class Measure {
  const Measure(
      this.label, this.before, this.after, this.beforeText, this.afterText);
  final String label;
  final double before;
  final double after;
  final String beforeText;
  final String afterText;
}

class Mynt {
  static const title = 'Mynt: a real-time trading app';
  static const summary =
      'Zebu\'s trading app for stocks, F&O, commodities, mutual funds, IPOs and bonds. '
      'A ~428K-line Flutter codebase shared by a 10-person team, running on Android, iOS and the web.';

  static const meta = {
    'Role': 'Flutter Developer',
    'When': 'Jun 2025 – present',
    'Platforms': 'Android, iOS, Web',
    'Stack': 'Flutter, Riverpod, WebSockets, Firebase, GetIt',
  };

  static const built = [
    'Order placement and modification, GTT/OCO and basket orders',
    'Option chain with basket-mode trading, and a strategy builder with ready-made straddles and strangles',
    'Moved charts to a self-hosted charting library with owner-based WebSocket subscriptions',
    'Mutual fund SIPs and baskets, IPO applications over UPI, P&L reports with a calendar heatmap',
    'Profile Re-KYC (eSign, DigiLocker, nominee) and in-app support tickets with attachments',
    'Desktop web trading layout in Flutter Web: positions, holdings, order book, funds',
  ];

  static const perfTitle = 'Making it smooth on a low-end phone';
  static const perfBody =
      'I profiled the app on a Galaxy A04e with a scripted 24-step session, then fixed what '
      'showed up: heavy parsing moved to background isolates, live price ticks batched every '
      '150 ms, a holdings total that recalculated on every tick, and 400+ call sites that '
      'rebuilt widgets for no reason.';
  static const perfNote =
      'Profile builds on a Galaxy A04e, median of two runs, same 24-step session.';

  static const perf = [
    Measure('Frame stutters (> 50 ms)', 1378, 59, '1,378', '59'),
    Measure('Median screen load', 1.19, 0.41, '1.19 s', '0.41 s'),
    Measure('Holdings screen load', 4.8, 1.5, '4.8 s', '1.5 s'),
    Measure('Peak memory', 535, 477, '535 MB', '477 MB'),
  ];

  static const securityTitle = 'Hardening security';
  static const security = [
    'Session and API tokens moved into Android Keystore and iOS Keychain, with a one-time migration',
    'SHA-256 certificate pinning, secrets redacted from logs, logging off in release builds',
    'Double-submit guards on about 20 order and payment actions',
  ];

  static const releaseTitle = 'Shipping it';
  static const release =
      'I prepare and submit Mynt\'s releases: 13 in a row from v1.0.64 to v1.0.89, '
      'including the Android 16 KB page-size update.';
}

class Project {
  const Project({
    required this.title,
    required this.kind,
    required this.body,
    required this.facts,
    required this.stack,
    this.url,
    this.urlLabel,
  });

  final String title;
  final String kind;
  final String body;
  final List<String> facts;
  final List<String> stack;
  final String? url;
  final String? urlLabel;
}

const workProjects = [
  Project(
    title: 'Helpdesk app',
    kind: 'Internal app at Zebu · sole developer',
    body:
        'A Flutter app for the support team: tickets, tasks, SLA plans, knowledge base, '
        'reports and exports, with push notifications and automatic token refresh.',
    facts: [
      '~42K lines of Dart',
      '380+ automated tests',
      'Shorebird code push and in-app update prompts'
    ],
    stack: ['Flutter', 'Riverpod', 'Dio', 'go_router', 'FCM', 'Shorebird'],
  ),
  Project(
    title: 'Call Tracker',
    kind: 'Internal Android app at Zebu',
    body:
        'Logs business calls and matches each one to its recording on the device, then syncs '
        'in the background, even after the app is killed or the phone restarts.',
    facts: [
      'Native Kotlin foreground service and call-state monitoring',
      'WorkManager sync with an offline queue in Drift',
      '35 of 35 test calls matched to the right recording on Android 16',
    ],
    stack: ['Flutter', 'Kotlin', 'WorkManager', 'Drift', 'Riverpod'],
  ),
  Project(
    title: 'eKYC account opening',
    kind: 'Onboarding app at Zebu · Feb–Apr 2025',
    body: 'Screens that take a new customer from sign-up to a trading account: '
        'mobile and email OTP, PAN, nominee validation, trading preferences and '
        'UPI bank verification on iOS.',
    facts: [],
    stack: ['Flutter', 'Riverpod', 'GetIt'],
  ),
];

const sideProjects = [
  Project(
    title: 'Drone services booking app',
    kind: 'Freelance',
    body:
        'Book drone services and buy drones, with phone OTP login, location-based booking, '
        'Razorpay payments and push notifications.',
    facts: [],
    stack: ['Flutter', 'Riverpod', 'Google Maps', 'Razorpay', 'Firebase'],
  ),
  Project(
    title: 'Business Software Factory',
    kind: 'Personal',
    body:
        'A reusable SaaS starter: authentication, roles, user invites, audit logging and '
        'row-level security on Postgres.',
    facts: [],
    stack: ['Next.js', 'TypeScript', 'Supabase', 'Vitest'],
    url: 'https://github.com/NeverReallyOver/business-software-factory',
    urlLabel: 'Code',
  ),
  Project(
    title: 'Trading Assistant',
    kind: 'Personal · private repository',
    body:
        'A modular Dart workspace for Indian index options: a signal engine, backtester, '
        'options strategy toolkit and paper trading, covered by 700+ automated tests.',
    facts: [],
    stack: ['Dart', 'Flutter', 'WebSockets'],
  ),
  Project(
    title: 'Flutter App Starter',
    kind: 'Personal · open source',
    body:
        'A starter template with Firebase email sign-in, Riverpod auth state, Google AdMob '
        'and a Material 3 light and dark theme.',
    facts: [],
    stack: ['Flutter', 'Firebase Auth', 'Riverpod', 'AdMob'],
    url: 'https://github.com/NeverReallyOver/flutter_app_starter',
    urlLabel: 'Code',
  ),
  Project(
    title: 'Crypto Research',
    kind: 'Personal',
    body:
        'Market data app with charts, a watchlist and stats, backed by a caching Node.js API '
        'that keeps the CoinGecko key off the device.',
    facts: [],
    stack: ['Flutter', 'Riverpod', 'Node.js', 'TypeScript'],
    url: 'https://github.com/NeverReallyOver/crypto-research',
    urlLabel: 'Code',
  ),
  Project(
    title: 'This site',
    kind: 'Personal',
    body:
        'Built in Flutter Web. The watchlist at the top is a live widget with a simulated '
        'price feed, batched the same way Mynt batches real ticks.',
    facts: [],
    stack: ['Flutter Web', 'Firebase Hosting'],
    url: 'https://github.com/NeverReallyOver/my_portfolio',
    urlLabel: 'Code',
  ),
];

class TimelineEntry {
  const TimelineEntry(this.when, this.title, this.place, this.note);
  final String when;
  final String title;
  final String place;
  final String note;
}

const timeline = [
  TimelineEntry(
      'Feb 2025 – now',
      'Flutter Developer',
      'Zebu Share and Wealth Managements',
      'Mynt trading app on mobile and web, the Helpdesk and Call Tracker apps, eKYC onboarding screens.'),
  TimelineEntry('Aug 2024 – Jan 2025', 'Full-time Flutter and Dart study',
      'Self-directed', 'Switched from IT support to app development.'),
  TimelineEntry('Jul 2024', 'Java Full Stack Development course',
      'Pumo Technovation, Chennai', ''),
  TimelineEntry(
      'Aug 2023 – Jul 2024',
      'Admin Executive, IT and Network',
      'Capricorn Food Products India',
      'Systems, LAN and Windows Server administration.'),
  TimelineEntry('2022', 'B.E. Computer Science and Engineering',
      'ARM College of Engineering and Technology', 'Aggregate 73.5%.'),
];

class SkillGroup {
  const SkillGroup(this.title, this.items);
  final String title;
  final List<String> items;
}

const skillGroups = [
  SkillGroup('Flutter', [
    'Dart',
    'Riverpod',
    'Provider',
    'GetIt',
    'go_router',
    'Isolates',
    'Flutter Web'
  ]),
  SkillGroup('Platforms', [
    'Android',
    'iOS',
    'Kotlin services',
    'WorkManager',
    'Play Console',
    'App Store Connect',
    'Shorebird'
  ]),
  SkillGroup('Data and services', [
    'REST APIs',
    'WebSockets',
    'Dio',
    'Firebase FCM, Crashlytics, Analytics',
    'Secure storage',
    'Drift (SQLite)'
  ]),
  SkillGroup('Also',
      ['TypeScript', 'Next.js', 'Supabase', 'Node.js', 'Git and GitHub']),
];

class About {
  static const paragraphs = [
    'I moved into app development from IT support in 2024. Since then I\'ve spent every working day '
        'on a production trading app: shipping features, chasing jank on cheap phones and doing the releases.',
    'Real-time data, money flows, background work on Android, and the last 10% of polish that '
        'makes an app feel fast: that\'s the work I enjoy most.',
  ];
}

class Offer {
  const Offer(this.title, this.body, this.proof);
  final String title;
  final String body;
  final String proof;
}

class Freelance {
  static const title = 'Need a Flutter app built or fixed?';
  static const intro =
      'Alongside my full-time work I take on a small number of freelance projects. '
      'One codebase, shipped to Android, iOS and the web.';

  static const offers = [
    Offer(
      'A new app',
      'Booking, payments, maps, logins and push notifications, built and released to the stores.',
      'Built a drone-services booking app with Razorpay and Google Maps for a client.',
    ),
    Offer(
      'Real-time and fintech',
      'Live prices over WebSockets, watchlists, order flows and dashboards that stay correct under load.',
      'Work daily on Mynt, a trading app with 10K+ downloads.',
    ),
    Offer(
      'Make a slow app fast',
      'Profiling on real low-end phones, then fixing jank, slow screens, startup time and memory.',
      'Cut frame stutters by 96% on a low-end phone in a 428K-line app.',
    ),
  ];
}
