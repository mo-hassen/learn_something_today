# AI usage disclosure

Milestone 1. Updated for every milestone and for the final submission.

## Tools used

| Tool | Version / model | Used for |
|---|---|---|
| Kiro (AI coding agent in the Kiro IDE) | Auto model selection | Generating boilerplate such as freezed data classes and Riverpod provider stubs after we decided the structure, suggesting widget layouts when we described the screen, explaining error messages from the analyser and failed tests, and drafting parts of this file and `MILESTONE.md` |

## How the assistant was used

Each member wrote their own feature code, designed the logic, and wrote most of the tests for their feature. The assistant was used selectively:

- **Boilerplate generation:** freezed model classes, `.g.dart` provider stubs, and repetitive widget scaffolding were generated after we defined the fields and the structure ourselves.
- **Suggestions and explanations:** when a member ran into an analyser warning or a failing test, the assistant helped explain the error and sometimes suggested a fix that the member then reviewed, adapted and applied.
- **Test skeletons:** some test files were started from skeletons suggested by the assistant; we then added our own test cases, adjusted expectations, and wrote the edge-case tests ourselves.

We made all design decisions ourselves:

- the screens, the data model and the data sources from our proposal;
- the feature-first structure from the course guide;
- who builds which feature;
- the repository-interface pattern so that screens never touch data sources directly.

## What was generated and where

The AI-use levels used below:

- **Level 0** — written entirely by the member, no AI tool involved.
- **Level 1** — the member wrote the code; the AI tool was used only to understand an error or look up an API.
- **Level 2** — the member wrote most of the code; the AI tool suggested parts (e.g. a widget layout or a test skeleton) that the member reviewed and edited.
- **Level 3** — the AI tool drafted the code; the member reviewed, tested and adapted it.

On the final `main`, `flutter analyze --fatal-infos` reports no issues and all 164 tests pass.

| File / function | Member | AI-use level | What the member did | What the tool produced | How we verified it |
|---|---|---|---|---|---|
| `pubspec.yaml`, `analysis_options.yaml` | Mohammed (author), Nahom (review) | 1 | Chose the dependencies and their versions from the Flutter and pub.dev docs; set up the course lint rules from the course guide | Helped find the compatible version constraints for Riverpod 3 + freezed 3 | PRs #3, #4: reviewed and merged by Nahom |
| `lib/core/domain` (`ArticleLanguage`), `lib/core/network` (`AppException`), `lib/core/time` | Mohammed (author), Nahom (review) | 0 | Wrote the enum, the exception hierarchy and the clock provider by hand following the course examples | Nothing | PRs #3, #4: reviewed and merged by Nahom |
| `lib/core/theme` | Sead (author), Mohammed (review) | 1 | Defined the colour scheme, text styles and component themes; used the Material 3 migration guide | Explained how `ColorScheme.fromSeed` works and how to set `useMaterial3` | PR #6: reviewed and merged by Mohammed |
| `lib/core/presentation/state_views.dart` | Sead (author), Melkamu (review) | 2 | Wrote the `LoadingView` and `EmptyView`; described the layout for `ErrorView` and `AsyncBody` | Suggested the `AsyncBody` helper that maps `AsyncValue` to the three views; Sead reviewed and adjusted the retry callback | PR #10: reviewed and merged by Melkamu |
| `lib/core/router/routes.dart`, `navigation.dart` | Sead (author), Mohammed (review) | 0 | Defined all route path constants and the `popOrGoHome` extension by hand | Nothing | PR #6: reviewed and merged by Mohammed |
| `lib/core/router/router.dart`, `app_shell.dart`, `lib/app.dart`, `lib/main.dart` | Sead (author), Mohammed (review) | 2 | Designed the tab structure and the route hierarchy; wrote `main.dart` and `app.dart` | Suggested the initial `StatefulShellRoute` configuration; Sead then replaced it with a plain `IndexedStack` after finding the Riverpod assertion crash | PR #31: merged; `flutter analyze --fatal-infos` clean on the final `main` |
| `lib/features/articles/domain` (`Article`, `OnThisDayFact`) | Mohammed (author), Sead and Nahom (review) | 2 | Defined the fields and the relationships from the proposal data model; wrote `firstSentence` and `paragraphs` getters | Generated the freezed boilerplate and the `copyWith` annotation after Mohammed listed the fields | PRs #9, #13: reviewed and merged by Sead and Nahom |
| `lib/features/articles/data` (`ArticlesRepository`, sample content, providers) | Mohammed (author), Melkamu and Nahom (review) | 2 | Wrote the repository interface, the English-fallback logic and the filtering; defined the six sample articles | Generated the in-memory implementation skeleton and the Riverpod provider stubs | PRs #13, #14: reviewed and merged by Melkamu and Nahom |
| `lib/features/articles/presentation` (Home, Search, Reader screens, article card, language toggle, fallback notice) | Sead (author), Mohammed and Nahom (review) | 2 | Designed the screen layouts on paper, wrote the article card and the language toggle; described the reader toolbar | Suggested the `ListView` structure for Home and the `SearchDelegate`-style layout for Search; Sead adjusted the padding and the empty-state text | PRs #19, #23, #29: reviewed and merged |
| `lib/features/auth/domain` (`AppUser`, `CredentialsValidator`) | Nahom (author), Melkamu (review) | 0 | Wrote the user model and the validation rules (email regex, password length) by hand following the course examples | Nothing | PR #7: reviewed and merged by Melkamu |
| `lib/features/auth/data` (`AuthRepository`, notifier) | Nahom (author), Sead and Mohammed (review) | 1 | Wrote the in-memory auth repository and the notifier; used the Riverpod docs for the `AsyncNotifier` pattern | Explained the difference between `Notifier` and `AsyncNotifier` | PRs #12, #21: reviewed and merged by Sead and Mohammed |
| `lib/features/auth/presentation` (`SignInScreen`) | Nahom (author), Sead (review) | 2 | Wrote the form layout, the validation feedback and the demo-login button; described the loading state | Suggested the `Form` / `TextFormField` wiring and the `AutovalidateMode` switch | PR #21: reviewed and merged by Sead |
| `lib/features/favourites` (domain, data, presentation) | Nahom (author), Mohammed (review) | 1 | Wrote the `Favourite` model, the repository, the notifier and the screen by hand; followed the same pattern as the articles feature | Helped debug a `StateNotifier` vs `Notifier` migration issue | PRs #16, #22: reviewed and merged by Mohammed |
| `lib/features/settings` (domain, data, presentation) | Melkamu (author), Nahom, Mohammed and Sead (review) | 2 | Defined the `AppSettings` fields and wrote the settings screen layout; wrote the notifier logic for toggling language and text size | Generated the freezed class after Melkamu listed the fields; suggested the `Slider` widget for text size that Melkamu then adjusted to multiply (not replace) the system scale | PRs #8, #11, #20: reviewed and merged |
| `lib/features/ai/domain` (`Quiz`, `QuizQuestion`, `QuizResult`) | Melkamu (author), Sead (review) | 2 | Defined the quiz data model and wrote the `score` method by hand | Generated the freezed annotations and constructors from the field list | PRs #17, #18: reviewed and merged by Sead |
| `lib/features/ai/data` (`AiRepository`, `StubAiRepository`, notifiers) | Melkamu (author), Nahom and Mohammed (review) | 2 | Designed the repository interface (what methods, what the consent flow needs); wrote the notifier logic for consent, simplify and quiz generation | Suggested the stub implementation that builds quiz questions from article metadata; Melkamu reviewed and fixed the correct-answer positioning | PRs #17, #18, #30: reviewed and merged |
| `lib/features/ai/presentation` (`AiToolsScreen`) | Melkamu (author), Sead and Mohammed (review) | 2 | Wrote the consent card text, the disclosure label and the quiz-checking logic; designed the screen flow (consent → actions → results) | Suggested the `RadioGroup` layout for quiz options and the `OverflowBar` for the consent buttons | PR #30: reviewed and merged |
| `test/helpers.dart` | Melkamu (author), Nahom (review) | 0 | Wrote the shared `testArticle()` factory and the `FailingAiRepository` fake by hand | Nothing | PR #15: reviewed and merged by Nahom |
| `test/features/articles/article_test.dart` (10 unit) | Mohammed | 0 | Wrote all 10 tests for the `Article` model (first sentence, paragraphs, language) by hand | Nothing | PR #33: `flutter test` passed with 70 tests at that point |
| `test/features/articles/articles_repository_test.dart` (18 unit) | Mohammed | 2 | Wrote the core tests for filtering, fallback and sample content; described the edge cases | Generated 5 of the 18 test cases as skeletons (empty query, missing language, date filtering); Mohammed added the assertions | PR #33: `flutter test` passed |
| `test/features/auth/credentials_validator_test.dart` (6 unit) | Nahom | 0 | Wrote all 6 validation tests (empty, short password, bad email, valid) by hand | Nothing | PR #7: reviewed and merged by Melkamu |
| `test/features/auth/auth_test.dart` (13 unit) | Nahom | 1 | Wrote all 13 tests for sign-in, sign-out, demo login and error states | Helped understand `AsyncNotifier` test setup with `ProviderContainer.test` | PR #12: reviewed and merged by Sead |
| `test/features/favourites/favourites_notifier_test.dart` (7 unit) | Nahom | 0 | Wrote all 7 tests by hand following the same pattern as auth tests | Nothing | PR #34: reviewed and merged |
| `test/features/settings/settings_notifier_test.dart` (5 unit) | Melkamu | 0 | Wrote all 5 tests for settings state changes by hand | Nothing | PR #32: reviewed and merged |
| `test/features/ai/ai_test.dart` (18 unit) | Melkamu | 1 | Wrote the quiz scoring tests, the stub-repository tests and the notifier tests; followed the patterns from auth and settings tests | Helped debug the `ProviderContainer` override syntax for `AiRepository` | PR #37: reviewed and merged |
| `test/core/router_test.dart` (2 unit + 10 widget) | Sead | 1 | Wrote the route-matching unit tests and the tab-navigation widget tests; added the two regression tests for the `IndexedStack` fix | Explained how to pump a `GoRouter` in a widget test | PR #35: reviewed and merged by Nahom |
| `test/core/layout_test.dart` (15 widget) | Sead | 2 | Wrote the overflow tests for 360 px and 900 px screens at normal and largest text scale; defined which screens to test | Suggested the `tester.binding.setSurfaceSize` approach and the `MediaQuery` override for text scale; Sead wrote the assertions | PR #38: reviewed and merged by Nahom |
| `test/features/articles/home_screen_test.dart` (10 widget), `search_screen_test.dart` (7 widget), `article_reader_test.dart` (10 widget) | Sead | 2 | Designed the test scenarios (loading, data, error, empty, language toggle); wrote the tap-and-verify logic | Generated the `pumpWidget` boilerplate with the `ProviderScope` overrides; Sead filled in the expectations and added the edge cases | PRs #35, #38: reviewed and merged |
| `test/features/auth/sign_in_screen_test.dart` (8 widget) | Nahom | 2 | Wrote the form-interaction tests (enter text, tap sign in, see error); designed the validation test cases | Suggested the `enterText` / `tap` / `pumpAndSettle` sequence; Nahom added the error-message checks and the demo-login test | PR #36: reviewed and merged |
| `test/features/favourites/favourites_screen_test.dart` (7 widget) | Nahom | 1 | Wrote all 7 widget tests for the favourites list, empty state and swipe-to-delete | Helped with the `Dismissible` test gesture syntax | PR #34: reviewed and merged |
| `test/features/settings/settings_screen_test.dart` (7 widget) | Melkamu | 1 | Wrote all 7 widget tests for the settings toggles, text-size slider and sign-in/sign-out flow | Helped understand how to test `Slider` value changes in widget tests | PR #37: reviewed and merged |
| `test/features/ai/ai_tools_screen_test.dart` (11 widget) | Melkamu | 2 | Wrote the consent flow tests and the quiz interaction tests; designed the test for the disclosure label | Suggested the `RadioListTile` selection test pattern and the async quiz-loading test; Melkamu adjusted the score expectations | PR #37: reviewed and merged |
| `MILESTONE.md`, this file | Mohammed | 2 | Wrote the structure and the pull-request table from the GitHub history; filled in the self-score | Helped organise the sections and word some descriptions; Mohammed checked everything against the code and the merge history | Read by the group before tagging |

## What the group did without an assistant

- Chose the app idea, the users, the data sources and the member roles, and decided the scope for Milestone 1.
- Designed the data model, the repository interfaces and the screen flow on paper before writing code.
- Wrote all domain logic (validation rules, language fallback, quiz scoring, article parsing) by hand.
- Wrote most unit tests by hand; used the assistant mainly for widget-test boilerplate (`pumpWidget`, `ProviderScope` overrides).
- Ran the checks ourselves in the terminal: `flutter analyze --fatal-infos` before committing steps, `flutter test` on Mohammed's steps, and both commands on the final `main` before tagging.
- Ran the work as 36 pull requests from our own GitHub accounts: each author applied, committed and pushed their own steps, and each reviewer read the change, commented and merged.
- Sorted out the integration problems ourselves:
  - a step copied with PowerShell instead of Git Bash;
  - steps started before the previous pull request was merged;
  - pushes that failed because of the network;
  - the decision to revert the stack in #28 and redo the steps under their real authors.
- Found and fixed six bugs in the codebase (see below), including bugs in AI-suggested code.

## Problems found and fixed

Found when the analyser and the tests were run during development:

- **Code that did not compile.** freezed 3.2.5 generated a constructor for the `Quiz` lists that the Dart 3.13 compiler rejects (`required final List<…>`). `flutter analyze` did not report it, because generated files are excluded from analysis; only the test run caught it. Melkamu fixed it with `@Freezed(makeCollectionsUnmodifiable: false)`.
- **A crash when switching tabs.** The first version of the router used `StatefulShellRoute.indexedStack`. With Riverpod 3.2.1 this failed an internal assertion when the language changed while the Home tab was hidden. Sead replaced it with a plain `IndexedStack`, and wrote two regression tests.
- **Tests that hung.** Two tests awaited a `Future.delayed` inside `testWidgets`, where fake time does not advance by itself. Melkamu fixed them with `tester.runAsync`.
- **Layout overflow on a 360 px screen.** The empty state, the AI disclosure label (a `Chip` cannot wrap its text) and the consent buttons overflowed with large text. Sead fixed the layouts and added the layout tests.
- **The text-size setting ignored the phone's own text size.** It replaced the system scale instead of multiplying it. Melkamu fixed the `MediaQuery` logic.
- **Wrong expectations in suggested test code.** One quiz score was miscounted, and one test expected "Not now" to go to the home screen although the nested route correctly returns to the article. Mohammed and Sead corrected the assertions.

## Individual declaration

Each member completes their own row. The files listed are the ones each member authored or reviewed in pull requests; confirm or change the list, then answer and sign yourself. The TA chooses oral-check questions from code **not** in your own list (see `milestones.md`).

| Name | I wrote or reviewed and can explain these files | I entered no passwords, keys or personal data into an AI tool (yes / no) | Signature |
|---|---|---|---|
| Mohammed Hassen | `lib/core/domain`, `lib/core/network`, `lib/core/time`, `lib/features/articles/domain`, `lib/features/articles/data`, `test/features/articles/article_test.dart`, `articles_repository_test.dart`; reviewed favourites, settings state, AI tools screen, article widgets | yes | |
| Sead Bushra | `lib/core/theme`, `lib/core/presentation`, `lib/core/router`, `lib/app.dart`, `lib/features/articles/presentation`, `test/features/articles/*_screen_test.dart`, `article_reader_test.dart`, `test/core`; reviewed article models, auth repository, AI models, settings screen | yes | |
| Nahom Solomon | `lib/features/auth`, `lib/features/favourites`, `test/features/auth`, `test/features/favourites`; reviewed project setup, core types, articles repository, settings, AI repository, home and search screens | yes | |
| Melkamu Gatew | `lib/features/settings`, `lib/features/ai`, `test/helpers.dart`, `test/features/ai`, `test/features/settings`; reviewed route constants, articles providers, sign-in screen, article tests | yes | |

Date: 2026-11-28
