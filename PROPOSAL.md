# Project proposal

---

## 1. Title and one-sentence description

**Learn Something Today — Amharic Wikipedia Reader**

An app that helps curious students and lifelong learners to discover a daily featured article or "On This Day" fact from Amharic (or English) Wikipedia, read it offline, and save favourites synced across devices so that they learn something new every day.

---

## 2. Group

Student IDs, emails and GitHub usernames are in `project.yaml`.

| Name | Role |
|---|---|
| Mohammed Hassen | Team lead / backend & data layer |
| Sead Bushra | UI / screens & navigation |
| Nahom Solomon | UI / screens & Firebase integration |
| Melkamu Gatew | Testing & AI Integration |


---

## 3. The problem

Many students and lifelong learners in Ethiopia want to build a daily reading habit in Amharic, but they struggle to find curated, bite-sized content in their local language. Browsing the raw Wikipedia mobile site is slow, hard to read on a small screen, and completely unavailable when the connection drops. When a topic is searched in Amharic, Wikipedia often returns a stub or nothing at all, leaving the user stuck without any fallback.

A dedicated mobile app solves this by fetching the daily featured article and "On This Day" facts from the Wikipedia REST API, showing them in a clean phone-friendly layout, and caching them locally for offline reading. An automatic fallback to English removes the dead-end problem when Amharic content is missing.

We talked to Tigist Alemu, a second-year Chemistry student at AAU, who said she occasionally tries to read Amharic Wikipedia but gives up because the mobile browser is frustrating and she can never find the articles again later. She said a daily curated feed with offline saving and a short quiz would make her open the app every morning. We also spoke to Bereket Tadesse, a Civics teacher in Addis Ababa, who wants short Amharic articles to use as conversation starters in class but cannot rely on internet at school.

---

## 4. Users

**Tigist Alemu — university student**
Tigist wants to read about science and history in Amharic during breaks between lectures. She needs articles that load fast, look good on her phone, and are available offline. She would open the app once or twice a day and use the quiz feature to check what she remembered.

**Bereket Tadesse — secondary school teacher**
Bereket wants a daily source of Amharic facts and short articles to share with his students. He needs reliable offline access because the school Wi-Fi is unreliable. He would open the app every morning and save two or three articles per week.

**Leul — bilingual professional**
Leul wants to read interesting articles on the go and sometimes listen to them while commuting. He switches between Amharic and English depending on the article quality. He would use the app once a day and sync his saved articles across his phone and tablet.

---

## 5. User stories

1. As a student, I want to see a featured Amharic Wikipedia article every day so that I can learn something new without having to search. (**must**)
2. As a student, I want to save an article to my favourites so that I can read it later without an internet connection. (**must**)
3. As a teacher, I want to read saved articles offline so that I can use them in class where there is no Wi-Fi. (**must**)
4. As a casual reader, I want to see an "On This Day" fact on the home screen so that I get a quick piece of learning even when I have no time for a full article. (**must**)
5. As a user, I want to switch an article between Amharic and English, with an automatic fallback to English if the Amharic version is missing, so that I never hit a dead end. (**must**)
6. As a professional, I want to listen to an article using text-to-speech and share it with a friend so that I can consume content hands-free and recommend interesting reads. (**should**)
7. As a registered user, I want my saved favourites to sync across my devices via my account so that my collection is always up to date. (**should**)
9. As a student, I want the app to generate a short quiz and simplify long articles into plain summaries so that I can test and improve my comprehension. (**could**)

---

## 6. Screens

| Screen | Purpose | User stories |
|---|---|---|
| Sign-in | Email/password and Google sign-in via Firebase Auth | 7 |
| Home / Daily feed | Today's featured article card and "On This Day" fact with language toggle and offline badge | 1, 4, 5 |
| Article reader | Full article text, language toggle, TTS play/pause, share button, bookmark button | 1, 2, 3, 5, 6 |
| Favourites | Saved articles with offline indicator; swipe to remove | 2, 3, 7 |
| AI tools | Simplify or quiz buttons for the open article; consent notice on first use | 8 |
| Search | Search Amharic or English Wikipedia by keyword | 5 |
| Settings | Default language, font size, notification toggle | 1, 6 |

**Sketches for the four most important screens:**

- *Sign-in:* minimal form with email/password fields and a Google sign-in button.
- *Home feed:* card layout with article thumbnail, title, short snippet and a language badge (AM / EN).
- *Article reader:* scrollable text area with a top toolbar for TTS, font size, bookmark and share; bottom action bar for AI Quiz and Simplify.
- *Favourites:* list view with article title, date saved and an offline-available badge.

Photos of paper sketches will be committed to `docs/sketches/` before Milestone 1.

---

## 7. Data model

```
User:      id, email, displayName, preferredLanguage, createdAt
Article:   id, title, language, summary, fullText, imageUrl, articleUrl, date
Favourite: id, userId, articleId, savedAt
OnThisDay: id, date, text, language, relatedArticleId
QuizResult: id, userId, articleId, score, completedAt
```

`Article` and `OnThisDay` are fetched from the Wikipedia REST API and cached locally with drift. `Favourite` is stored in both drift (for offline access) and Firestore (for cross-device sync). `QuizResult` is local only.

---

## 8. Data sources

- **Local persistence (drift):** full article text, favourites list and OnThisDay cache stored in SQLite so the app works offline after the first load.
- **REST web service (Wikipedia REST API):** `https://am.wikipedia.org/api/rest_v1/` for Amharic content and `https://en.wikipedia.org/api/rest_v1/` for English fallback — provides featured articles, "On This Day" events and article summaries. No API key required.
- **Firebase Auth:** email/password and Google sign-in to identify the user across devices.
- **Cloud Firestore:** `users/{userId}/favourites` collection syncs the user's saved articles across devices. Security rules restrict every read and write to the authenticated owner.

---

## 9. Device feature and AI feature

**Device feature — Text-to-speech and Share**

Text-to-speech (user story 6): the app reads the open article aloud in Amharic or English using the device's built-in TTS engine via `flutter_tts`. No runtime permission is needed. If an Amharic voice is not installed, the app falls back to English and shows a short notice with a link to system voice settings.

Share (user story 7): a share button opens the system share sheet with the article title and Wikipedia URL via `share_plus`. No permission is needed.

**AI feature — quiz and simplify**

When the user taps Quiz or Simplify, the app sends the article text (no personal data) to an AI API and returns either a 3-question multiple-choice quiz or a short plain-language summary. A consent notice is shown before the first request explaining what is sent and to whom. Every AI response is labelled "Generated by AI".

---

## 10. Risks

| Risk | Likelihood | Plan |
|---|---|---|
| Amharic Wikipedia returns empty or stub articles for the daily feed | Medium | Automatically fall back to the English API; cache the last successful response so the home screen never shows empty |
| TTS pronunciation sounds unnatural with mixed Amharic/English text | Low | Restrict TTS to the active language and configure the correct locale; fall back to English voice if Amharic is unavailable |
| Firebase free-tier quota exceeded during demo or grading | Low | Use Firestore offline persistence to reduce reads; monitor usage in the Firebase console |
| A group member is unavailable during a milestone week due to exams | Medium | Assign tasks at least two weeks ahead; keep DECISIONS.md updated so anyone can pick up a partial branch |
| The AI API requires a paid key or hits quota limits | Medium | AI features are `could` stories; use a local stub returning the first sentence until a free key is available |

---

## 11. Milestone plan

**Milestone 1 — end of week 6 (screens, navigation, in-memory state)**
- All seven screens scaffolded and navigable with `go_router` and a bottom navigation bar
- Home feed and Article reader with hardcoded mock data; language toggle working in the UI
- Favourites screen with in-memory list; TTS and share buttons visible (static mock)
- Riverpod providers for `dailyArticle`, `onThisDay`, `savedArticles` — all in-memory
- Freezed models for `Article`, `Favourite`, `OnThisDay`
- At least five widget or unit tests; `flutter analyze --fatal-infos` clean
- User stories 1, 4, 5 complete at the screen and navigation level

**Milestone 2 — end of week 10 (real data)**
- Wikipedia REST API integrated for live featured article and "On This Day" data
- drift database for offline article caching; articles readable after first load without network
- Firebase Auth (Google sign-in) working; Firestore favourites sync across devices
- TTS playback and system share sheet fully functional
- Repository-layer tests with fakes; widget tests for Article reader (loading, data, error, empty); one integration test
- User stories 1–7 fully functional

**Final submission — end of week 14**
- AI quiz and simplify features (user story 8) with consent notice
- Daily notification for new featured article
- Two build flavours: `development` (emulators) and `production` (live endpoints)
- Signed release APK attached to the `final` tag
- Full test suite with ≥ 60 % line coverage; GitHub Actions CI green
- `README.md`, `AI_USAGE.md`, `PRIVACY.md`, `USER_TEST.md` complete

---

## 12. AI-use plan

We plan to use GitHub Copilot and occasionally a chat assistant for explaining error messages, generating repetitive boilerplate like data classes and provider stubs after we have decided the structure ourselves, and drafting widget test skeletons that we then fill in and verify. We will not use AI for lab exercises or exam practice. Everything will be logged in `AI_USAGE.md`.
