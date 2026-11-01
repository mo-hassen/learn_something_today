# Project Proposal

**Due:** Sunday 8 November 2026 · **Submit:** committed as `PROPOSAL.md` in the root
of the group repository, tagged `proposal`

---

## 1. Title and one-sentence description

**Learn Something Today** — Amharic Wikipedia Reader

An app that helps curious readers to discover a daily featured article or "On This Day" fact from Amharic (or English) Wikipedia, read it offline, and save favourites synced across devices so that they learn something new every day.

---

## 2. Group

Student IDs, emails and GitHub usernames are in `project.yaml`.

| Name | Role |
|---|---|
| Mohammed Hassen | Team lead, navigation & app architecture |
| Sead Bushra | UI design & screen implementation |
| Nahom Solomon | Data / backend (Wikipedia REST, Firebase) |
| Melkamu Gatew | Testing, device features & CI |

*Roles are starting points; everyone writes code in every layer.*

---

## 3. The problem

Most Ethiopian university students want to improve their Amharic reading but have no easy daily habit to do so. They either read English content (which does not build Amharic literacy) or open the Amharic Wikipedia website on a browser — an experience that is slow, not mobile-optimised, and impossible to read without a connection.

Meanwhile, Amharic Wikipedia has hundreds of featured articles and a growing "On This Day" feed, yet almost no native mobile app surfaces this content in a clean, readable way. A dedicated app that delivers one article or one fact per day — in Amharic with an English fallback — gives readers a low-commitment, high-reward daily ritual.

We talked to Kalkidan, a third-year engineering student who reads Wikipedia in English every day but has never read it in Amharic because "the mobile site is too slow and the font is too small." She said she would read one Amharic article a day if it loaded fast and she could save it for the commute home.

---

## 4. Users

**Curious daily reader (e.g. Kalkidan)**
Wants one interesting thing to read per day. Uses the app for 5–10 minutes in the morning. Needs offline access so she can read on the bus. Saves articles she wants to return to.

**Amharic language learner**
Studies Amharic formally or as a heritage speaker building reading fluency. Wants to read real Amharic prose, hear it read aloud (TTS), and switch to English when a passage is confusing. May use the AI quiz to test comprehension.

**Teacher or content sharer**
Discovers an interesting article and wants to share it with students or a chat group. Needs a clean share sheet that includes the article link and a short summary.

---

## 5. User stories

1. As a daily reader, I want to open the app and immediately see today's featured article from Amharic Wikipedia so that I have something interesting to read without searching. (**must**)
2. As a daily reader, I want to switch any article between Amharic and English so that I can read in the language I prefer or check my understanding. (**must**)
3. As a daily reader, I want to save an article for offline reading so that I can read it later without an internet connection. (**must**)
4. As a logged-in user, I want my saved favourites to sync across my devices via my account so that I can start reading on my phone and finish on a tablet. (**must**)
5. As a reader, I want to see an "On This Day" card for today's date so that I discover historical facts I did not know. (**must**)
6. As a language learner, I want the app to read an article aloud using text-to-speech so that I can hear correct Amharic pronunciation while I follow along. (**should**)
7. As a reader, I want to share an article to WhatsApp, Telegram or another app with one tap so that I can send it to a friend. (**should**)
8. As a reader, I want to ask the app to simplify a long article into three short paragraphs using AI so that I can understand complex topics quickly. (**could**)
9. As a learner, I want the app to generate a 3-question quiz from the article I just read so that I can check how much I understood. (**could**)

---

## 6. Screens

| Screen | Purpose | User stories |
|---|---|---|
| **Home / Daily feed** | Shows today's featured article card and the "On This Day" card; pull-to-refresh | 1, 5 |
| **Article reader** | Full article text with language toggle (Amharic ↔ English), TTS play button, share button | 1, 2, 6, 7 |
| **Saved articles** | List of favourites stored locally; shows offline badge when cached | 3, 4 |
| **AI tools** | "Simplify" and "Quiz me" actions for the open article, with consent notice | 8, 9 |
| **Search** | Search Wikipedia (Amharic or English) by keyword | — |
| **Sign-in / Account** | Firebase Auth (Google or email); shows sync status | 4 |
| **Settings** | Default language, font size, TTS speed, notification for daily article | 1, 6 |

Sketches are attached to the pull request as `docs/sketches/*.png`.

---

## 7. Data model

```
User: id, email, displayName, preferredLanguage, createdAt

SavedArticle: id, userId, pageId, title, language, summary, fullText,
              thumbnailUrl, articleUrl, savedAt, isOfflineCached

OnThisDayFact: id, date, text, language, relatedPageId, fetchedAt

QuizResult: id, userId, articlePageId, score, totalQuestions, takenAt
```

`User` ←→ `SavedArticle` (one-to-many)
`SavedArticle` — `pageId` is the Wikipedia page ID, same regardless of language
`QuizResult` is local only (not synced)

---

## 8. Data sources

| Layer | Technology | What is stored / fetched |
|---|---|---|
| **Local persistence** | `drift` (SQLite) | `SavedArticle` rows with full article text for offline reading; `OnThisDayFact` cache |
| **REST web service** | [Wikimedia REST API](https://www.mediawiki.org/wiki/API:REST_API) — free, no key | Daily featured article (`/page/featured/{date}`), "On This Day" (`/feed/onthisday/events/{date}`), article summary, full page content; Amharic endpoint: `am.wikipedia.org`, English fallback: `en.wikipedia.org` |
| **Firebase Auth** | Sign-in with Google or email/password | User identity |
| **Firebase Cloud Firestore** | `savedArticles` collection (one document per saved article, keyed by userId + pageId) | Syncs favourites across devices; security rules restrict each user to their own documents |

---

## 9. Device feature and AI feature

**Device feature — Text-to-Speech (TTS) & Share**
Used by user stories 6 and 7.
- TTS: uses `flutter_tts` which reads aloud in Amharic or English depending on the active language. No permissions required on Android/iOS; we handle the case where an Amharic TTS voice is not installed on the device by showing a toast and switching to English.
- Share: uses the system share sheet (`share_plus`) to share the article URL and title. No permissions required.

**AI feature — Simplify article / Generate quiz**
Used by user stories 8 and 9. The article text (plain text, no personal data) is sent over HTTPS to the Google Gemini API. Before the first AI request the app shows a one-time consent dialog explaining exactly what is sent and to which service. The feature is behind an `AiRepository` interface so the backend can be swapped. If the API is unavailable the buttons are disabled with a clear message.

---

## 10. Risks

| Risk | Likelihood | Plan |
|---|---|---|
| Amharic Wikipedia has fewer featured articles than English, so the daily feed may repeat | Medium | Add a fallback: if no Amharic featured article exists for today, fetch the English one and show a language badge; also expose a search screen so users find content beyond the daily pick |
| Wikimedia API rate-limits heavy usage | Low | Cache responses in `drift` for 24 hours; respect `Cache-Control` headers |
| Amharic TTS voice not available on all devices | Medium | Detect at startup; fall back to English TTS and show a notice; suggest installing the Amharic voice pack via a deep link to system settings |
| Google Gemini API requires a paid key or has quota limits | Low | AI features are behind `could` stories; the app is fully usable without them; quota is generous on the free tier for a class project |
| A group member has exam clashes at Milestone 1 | Low | Tasks assigned two weeks ahead; anyone blocked hands off with a documented partial PR so the branch stays reviewable |

---

## 11. Milestone plan

**Milestone 1 (end of week 6) — screens, navigation, in-memory state**
- All seven screens scaffolded and navigable with `go_router`
- Home feed showing a hard-coded article card and an "On This Day" card
- Article reader with language toggle (static mock data), share button
- Riverpod providers for `dailyArticle`, `onThisDay`, and `savedArticles` (in-memory)
- User stories 1, 2, 5 completed at the screen/navigation level

**Milestone 2 (end of week 10) — real data, backend, tests**
- Wikipedia REST API integrated for live featured article and "On This Day" data
- `drift` database with offline article caching
- Firebase Auth (Google sign-in) and Firestore favourites sync
- TTS playback and system share sheet working
- Unit tests for repository layer; widget tests for article reader; one integration test (save and retrieve an article)
- User stories 1–7 fully functional

**Final submission (end of week 14)**
- AI simplify and quiz features (user stories 8–9) with consent dialog
- Daily push notification for new featured article
- Two build flavours (development / production) with separate Firebase projects
- Signed release APK attached to `final` tag
- Full test suite with ≥ 60 % line coverage passing in GitHub Actions
- `README.md`, `AI_USAGE.md`, `PRIVACY.md`, `USER_TEST.md` complete

---

## 12. AI-use plan

| Tool | Intended use |
|---|---|
| GitHub Copilot / Kiro | Generating boilerplate (Riverpod providers, Freezed models, drift table definitions, widget tests), explaining compiler errors |
| ChatGPT / Gemini (chat) | Researching Wikipedia API endpoints, understanding Firestore security rules, reviewing PR descriptions |

All AI-generated code is reviewed line by line before merging and noted at level 3 (Draft and verify) in `AI_USAGE.md`. We will design the data model and Firestore security rules ourselves before consulting any assistant.
