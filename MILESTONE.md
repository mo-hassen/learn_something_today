# Milestone 1 — screens, navigation, state

**Tag:** `m1` · **Due:** Friday 27 November 2026

## What is done

**All seven screens from the proposal**, each reachable through `go_router`:

| Screen | Route | How to reach it |
|---|---|---|
| Home / daily feed | `/home` | bottom navigation, tab 1 |
| Search | `/search` | bottom navigation, tab 2 |
| Favourites | `/favourites` | bottom navigation, tab 3 |
| Settings | `/settings` | bottom navigation, tab 4 |
| Article reader | `/article/:id?lang=am` | tap an article on Home, Search or Favourites, or an "On this day" event |
| AI tools | `/article/:id/ai?lang=am` | "Simplify or take a quiz" button in the reader |
| Sign-in | `/sign-in` | "Sign in" in Settings or Favourites |

- **Navigation.** A `StatefulShellRoute` holds the four tabs. Each tab keeps its own stack, so the search text survives a switch of tab. Detail routes take parameters: the article id is a path parameter and the language a query parameter. The AI route is nested under the article route, and unknown addresses show a not-found page.
- **Feature-first structure.** The code lives in `lib/core` and `lib/features/<feature>/{domain,data,presentation}`. The features are `articles`, `favourites`, `auth`, `ai` and `settings`.
- **State in Riverpod.** Every piece of app state is in a provider: settings, signed-in user, favourites, search query, AI consent, quiz results and read-aloud state. Widgets keep only ephemeral UI state such as text controllers and the options picked in an unfinished quiz.
- **Immutable models.** `Article`, `OnThisDayFact`, `Favourite`, `AppUser`, `AppSettings`, `Quiz`, `QuizQuestion` and `QuizResult` are `freezed` classes. The fields and relationships were designed by the team from the proposal data model; the freezed boilerplate was generated.
- **Repositories behind interfaces.** `ArticlesRepository`, `FavouritesRepository`, `AuthRepository`, `SettingsRepository` and `AiRepository` each have an in-memory implementation, and the screens see only the interface. Tests swap in fakes, including failing ones. Each member wrote their own repository interface and logic.
- **User stories 1, 4 and 5** (from the proposal's Milestone 1 plan) work on in-memory data:
  - a featured article every day;
  - "On This Day" on the home screen;
  - Amharic/English toggle with an automatic English fallback, plus a notice when the article exists only in English.
- **Loading, error and empty states** appear on every screen that loads data. The error view has a Retry button, except for "not found", where retrying cannot help.
- **Tests.** 164 tests: 79 unit tests and 85 widget tests. Each member wrote the tests for their own feature. See the output below.

## What each member built

| Member | Feature owned | What they wrote | AI assistance level |
|---|---|---|---|
| Mohammed Hassen | Core domain & data layer, Articles (domain + data) | `ArticleLanguage` enum, `AppException` hierarchy, clock provider, `Article` and `OnThisDayFact` models, `ArticlesRepository` with fallback logic, sample content, 28 unit tests | Level 0–2: core domain written by hand; freezed boilerplate and some test skeletons generated |
| Sead Bushra | Core UI, navigation, Articles (presentation) | Theme, shared state views, route paths, `go_router` configuration, `AppShell`, Home / Search / Reader screens, article card, language toggle, fallback notice, 27 widget tests + 12 router/layout tests | Level 0–2: routes and theme written by hand; screen layouts started from suggestions then adjusted; layout tests partly generated |
| Nahom Solomon | Auth, Favourites | `AppUser`, `CredentialsValidator`, `AuthRepository`, auth notifier, Sign-in screen, `Favourite` model, favourites repository + notifier + screen, 26 unit tests + 15 widget tests | Level 0–2: domain models and validation written by hand; widget-test boilerplate generated, assertions written by Nahom |
| Melkamu Gatew | Settings, AI tools, test helpers | `AppSettings`, settings repository + notifier + screen, `Quiz` / `QuizResult` models, `AiRepository` interface, `StubAiRepository`, AI notifiers, AI tools screen with consent flow, `test/helpers.dart`, 23 unit tests + 18 widget tests | Level 0–2: test helpers and domain models written by hand; stub quiz logic and screen layouts assisted |

## What is not done

These are planned for Milestone 2 and the final submission, as in the proposal:

- **Persistence and backends.** Nothing is saved, so data is lost when the app closes. The Wikipedia REST API, drift for offline reading, Firebase Auth and Firestore sync are Milestone 2.
- **Sample content.** The articles are six sample articles in `sample_articles.dart`, one of them without an Amharic version.
- **Placeholders for device features.** Read aloud only switches a "Reading aloud" banner; real text-to-speech comes later. Share shows a "coming in the next version" message.
- **Google sign-in** is a demo button that signs in a fixed demo user.
- **AI tools.** These run on `StubAiRepository`, which builds the summary and the quiz from the article text and calls no AI model. The screen says so in its consent notice and in the label on every answer.
- **Not stored yet.** AI consent and quiz results last for the session only.
- **Daily reminder.** The switch exists in Settings and is stored in state, but no notification is sent (final version).
- **Screen sketches** are not yet in `docs/sketches/`.

## Pull requests

Each step was its own feature branch and pull request into `main`, merged with a merge commit (no squash). The table lists the merged pull requests by author and by the member who reviewed and merged them.

| Member | Pull requests authored | Pull requests reviewed and merged |
|---|---|---|
| Mohammed Hassen | #3, #4, #9, #13, #14, #24, #25, #26, #27, #28, #33, and this one (docs) | #6, #11, #16, #19, #22, #30, #37 |
| Sead Bushra | #6, #10, #19, #23, #29, #31, #35, #38 | #9, #12, #17, #20, #24, #25, #26, #27, #28, #32, #34 |
| Nahom Solomon | #7, #12, #16, #21, #22, #34, #36 | #3, #4, #8, #13, #15, #18, #23, #35, #38 |
| Melkamu Gatew | #8, #11, #15, #17, #18, #20, #30, #32, #37 | #10, #14, #21, #33, #36 |

**#24–#28, a step we undid.** To save time near the deadline, Mohammed pushed steps 21–31 as one stack of branches, and #24–#27 were merged. We then decided that each member should author their own steps. #28 reverts #24–#27, and the same steps were redone by their planned authors in #29–#38.

**Self-merges.** #7, #29 and #31 were merged by their own authors. Before Milestone 2 we will turn on branch protection, so a pull request needs an approval from another member before it can be merged.

## Self-score

Written before tagging `m1`. The individual oral check is scored by the TA.

| Criterion | Points | Self-score | Evidence |
|---|---|---|---|
| All proposed screens present and navigable | 3 | 3 | All seven proposal screens are routes in `lib/core/router/router.dart`, and `test/core/router_test.dart` opens each one through the tabs, a tap or a deep link. |
| Feature-first structure; state in providers, not widgets | 2 | 2 | Every feature has `domain`, `data` and `presentation` folders, and widgets only `ref.watch` providers and call notifier methods; no widget creates a repository. |
| Tests present; analyser and tests clean in the pasted output | 1 | 1 | 164 tests pass and `flutter analyze --fatal-infos` reports no issues (output below). |
| Repository hygiene: branches, pull requests, readable history | 1 | 1 | 36 feature-branch pull requests merged with merge commits, each member authoring at least 7 and reviewing at least 5, with descriptive commit messages; the one undone stack (#24–#27) is reverted openly in #28. |
| Individual oral check (recorded per member) | 3 | — | Scored by the TA. |

## One thing we will change before Milestone 2

We will start the pull requests in the first week of the milestone rather than the last day. We will also protect `main` so that every pull request needs another member's approval before it can be merged.

## Analyzer output

Run on the tagged commit:

```
$ flutter analyze --fatal-infos
Analyzing learn_something_today...
No issues found! (ran in 3.7s)
```

## Test output

Run on the tagged commit (last lines; the full run lists every test):

```
$ flutter test
00:08 +162: .../test/features/settings/settings_screen_test.dart: a guest sees a sign-in button that opens the form
00:09 +163: .../test/features/settings/settings_screen_test.dart: a signed-in reader sees the account and can sign out
00:09 +164: All tests passed!
```

| Test file | Unit | Widget |
|---|---|---|
| `test/core/router_test.dart` | 2 | 10 |
| `test/core/layout_test.dart` (no overflow at 360 px and 900 px, normal and largest text) | — | 15 |
| `test/features/articles/article_test.dart` | 10 | — |
| `test/features/articles/articles_repository_test.dart` | 18 | — |
| `test/features/articles/home_screen_test.dart` | — | 10 |
| `test/features/articles/article_reader_test.dart` | — | 10 |
| `test/features/articles/search_screen_test.dart` | — | 7 |
| `test/features/favourites/favourites_notifier_test.dart` | 7 | — |
| `test/features/favourites/favourites_screen_test.dart` | — | 7 |
| `test/features/auth/credentials_validator_test.dart` | 6 | — |
| `test/features/auth/auth_test.dart` | 13 | — |
| `test/features/auth/sign_in_screen_test.dart` | — | 8 |
| `test/features/settings/settings_notifier_test.dart` | 5 | — |
| `test/features/settings/settings_screen_test.dart` | — | 7 |
| `test/features/ai/ai_test.dart` | 18 | — |
| `test/features/ai/ai_tools_screen_test.dart` | — | 11 |
| **Total** | **79** | **85** |

## Notes for the reviewer

- **Generated code.** The `*.g.dart` and `*.freezed.dart` files are committed. After changing an annotated file, run `dart run build_runner build`.
- **Hidden tabs stay active.** `StatefulShellRoute.indexedStack` turns off the tickers of hidden tabs, and Riverpod 3 then pauses their providers. With Riverpod 3.2.1, a paused provider that is invalidated fails an internal assertion, for example when the language changes in Settings while Home is hidden. The router therefore uses a plain `IndexedStack`, which keeps hidden tabs active, as Riverpod 2 did. Two regression tests cover this case.
- **Quiz annotation.** `Quiz` and `QuizQuestion` use `@Freezed(makeCollectionsUnmodifiable: false)`. With freezed 3.2.5, the default generates a constructor that the Dart 3.13 compiler rejects. The repository builds the lists with `List.unmodifiable` instead.
