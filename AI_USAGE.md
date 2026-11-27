# AI usage disclosure

Milestone 1. Updated for every milestone and for the final submission.

## Tools used

| Tool | Version / model | Used for |
|---|---|---|
| Kiro (AI coding agent in the Kiro IDE) | Auto model selection | Writing the Milestone 1 code and tests in `lib/` and `test/`, running `flutter analyze` and `flutter test`, and drafting `MILESTONE.md` |

## What was generated and where

AI-use level 3 (draft and verify) for every entry below. The group fills in the "What we changed" column after reviewing each pull request.

| File / function | Member | AI-use level | What the tool produced | What we changed | How we verified it |
|---|---|---|---|---|---|
| `lib/core/**` (router, shell, routes, error types, state views, theme, clock) | | 3 | The router with the four tabs and the detail routes, the shared loading/error/empty views and `AppException` | | Ran `test/core/router_test.dart` and `test/core/layout_test.dart` |
| `lib/features/articles/**` | | 3 | `Article` and `OnThisDayFact` models, `ArticlesRepository` with the in-memory version and sample content, providers, Home, Reader and Search screens | | Ran the four test files in `test/features/articles/` |
| `lib/features/favourites/**` | | 3 | `Favourite` model, repository, notifier and Favourites screen | | Ran `test/features/favourites/` |
| `lib/features/auth/**` | | 3 | `AppUser`, `CredentialsValidator`, in-memory `AuthRepository`, notifier and Sign-in screen | | Ran `test/features/auth/` |
| `lib/features/settings/**` | | 3 | `AppSettings`, repository, notifier and Settings screen | | Ran `test/features/settings/` |
| `lib/features/ai/**` | | 3 | `Quiz` and `QuizResult` models, `AiRepository` with the offline stub, consent and result notifiers, AI tools screen | | Ran `test/features/ai/` |
| `test/**` | | 3 | All 164 tests and the helpers in `test/helpers.dart` | | Ran `flutter test` (164 passing) |
| `MILESTONE.md` | | 3 | The first draft | | Checked every statement against the code |

## Which tasks did we do without an assistant first?

The proposal: the problem, the users, the user stories, the screens, the data model and the choice of data sources. The Milestone 1 code was built from that design.

## Problems found in AI output

Found by running the analyser and the tests on the generated code:

- **Code that did not compile.** freezed 3.2.5 generated a constructor for the `Quiz` lists that the Dart 3.13 compiler rejects (`required final List<…>`). `flutter analyze` did not report it, because generated files are excluded from analysis; only the test run caught it. Fixed with `@Freezed(makeCollectionsUnmodifiable: false)`.
- **A crash when switching tabs.** The first version of the router used `StatefulShellRoute.indexedStack`. With Riverpod 3.2.1 this failed an internal assertion when the language changed while the Home tab was hidden. Replaced with a plain `IndexedStack`, and two regression tests were added.
- **Tests that hung.** Two tests awaited a `Future.delayed` inside `testWidgets`, where fake time does not advance by itself. Fixed with `tester.runAsync`.
- **Layout overflow on a 360 px screen.** The empty state, the AI disclosure label (a `Chip` cannot wrap its text) and the consent buttons overflowed with large text.
- **The text-size setting ignored the phone's own text size.** It replaced the system scale instead of multiplying it.
- **Wrong expectations in the generated tests.** One quiz score was miscounted, and one test expected "Not now" to go to the home screen although the nested route correctly returns to the article.

## Individual declaration

Each member completes one row. List the files you can explain, including the ones an assistant helped with. The TA chooses oral-check questions from code **not** in your own list (see `milestones.md`).

| Name | I wrote or reviewed and can explain these files | I entered no passwords, keys or personal data into an AI tool (yes / no) | Signature |
|---|---|---|---|
| Mohammed Hassen | | | |
| Sead Bushra | | | |
| Nahom Solomon | | | |
| Melkamu Gatew | | | |

Date:
