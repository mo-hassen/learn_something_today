# Learn Something Today — Amharic Wikipedia Reader

A Flutter app that surfaces a daily featured article and "On This Day" fact from Amharic Wikipedia (with an English fallback), lets you read offline, and syncs saved favourites across devices via Firebase.

> **Course:** Mobile Application Development · Group project (30 %)
> **Group repo:** one repository shared by all four members

---

## Team

| Name | Student ID | GitHub |
|---|---|---|
| Mohammed Hassen | UGR/2340/16 | [@mo-hassen](https://github.com/mo-hassen) |
| Sead Bushra | UGR/6932/16 | [@Sead44](https://github.com/Sead44) |
| Nahom Solomon | UGR/3155/16 | [@nahoom-sh](https://github.com/nahoom-sh) |
| Melkamu Gatew | UGR/1687/15 | [@mgmelk](https://github.com/mgmelk) |

---

## Features

- **Daily featured article** — fetched from the Amharic Wikipedia REST API every morning
- **"On This Day"** — historical events for today's date
- **Language toggle** — switch any article between Amharic and English
- **Offline reading** — full article text saved locally with `drift`
- **Synced favourites** — Firebase Auth + Firestore keeps your saved articles across devices
- **Text-to-speech** — hear the article read aloud in Amharic or English
- **Share** — send an article to any app via the system share sheet
- **AI tools** *(planned)* — simplify an article or generate a 3-question quiz with Google Gemini

---

## Tech stack

| Concern | Package / service |
|---|---|
| State management | [Riverpod](https://riverpod.dev) |
| Navigation | [go_router](https://pub.dev/packages/go_router) |
| Immutable models | [freezed](https://pub.dev/packages/freezed) |
| Local database | [drift](https://drift.simonbinder.eu) |
| REST data source | [Wikimedia REST API](https://www.mediawiki.org/wiki/API:REST_API) (free, no key) |
| Auth & sync | Firebase Auth + Cloud Firestore |
| TTS | [flutter_tts](https://pub.dev/packages/flutter_tts) |
| Share | [share_plus](https://pub.dev/packages/share_plus) |
| AI | Google Gemini API |

---

## Setup

> Full setup instructions will be added at Milestone 1.

```bash
# 1. Clone the repo
git clone https://github.com/<your-org>/learn_something_today.git
cd learn_something_today

# 2. Install dependencies
flutter pub get

# 3. Run (development flavour, uses emulators)
flutter run --flavor development --target lib/main_development.dart
```

---

## Architecture

Feature-first folder structure under `lib/`:

```
lib/
  features/
    daily_feed/       # home screen, featured article, on-this-day
    article_reader/   # reader screen, TTS, share
    saved_articles/   # favourites list, offline cache
    ai_tools/         # simplify & quiz features
    auth/             # sign-in, account screen
    settings/         # preferences
  core/
    repositories/     # abstract interfaces + implementations
    models/           # Freezed data classes
    providers/        # top-level Riverpod providers
```

---

## Project status

| Milestone | Due | Status |
|---|---|---|
| Group registration | End of week 2 | ✅ Done |
| Proposal | Sunday 8 Nov 2026 | ✅ Submitted |
| Milestone 1 — screens, navigation, state | End of week 6 | 🔲 Upcoming |
| Milestone 2 — data, backend, tests | End of week 10 | 🔲 Upcoming |
| Final submission | End of week 14 | 🔲 Upcoming |

---

## Repository layout

```
.
├── project.yaml          # group registration (read by course tooling)
├── PROPOSAL.md           # project proposal (tagged: proposal)
├── DECISIONS.md          # log of group decisions
├── AI_USAGE.md           # AI disclosure (updated each milestone)
├── PRIVACY.md            # data-safety table
├── USER_TEST.md          # user-test report
├── lib/                  # Flutter source
├── test/                 # unit, widget and integration tests
├── labs/                 # individual lab work (labs/<name>/weekNN/)
└── docs/
    └── sketches/         # screen sketches for the proposal
```
