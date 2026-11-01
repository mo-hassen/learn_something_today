# Decision log

A short record of every significant group decision, newest first.
Add a row whenever the group agrees on something that affects direction, architecture or scope.

| Date | Decision | Reason | Who was present |
|---|---|---|---|
| 2026-11-01 | Changed project title from "Amharic Flashcards" to "Learn Something Today – Amharic Wikipedia Reader" | New concept better fits the course requirements: free REST API (Wikipedia), clear device feature (TTS/share), Firebase sync, and an AI angle (simplify/quiz). | Mohammed, Sead, Nahom, Melkamu |
| 2026-11-01 | Chose Wikipedia REST API as the primary REST data source | Free, no API key required, has both Amharic (`am.wikipedia.org`) and English (`en.wikipedia.org`) endpoints, documented fallback strategy if Amharic content is sparse. | Mohammed, Sead, Nahom, Melkamu |
| 2026-11-01 | Chose `drift` for local persistence | Supports complex queries needed for offline article caching; good Riverpod integration; taught in the course. | Mohammed, Sead, Nahom, Melkamu |
| 2026-11-01 | Chose text-to-speech + share as the device features | No hardware permission required on most devices (TTS uses installed voices; share uses the system sheet), reducing permission-handling complexity for Milestone 1. | Mohammed, Sead, Nahom, Melkamu |
| 2026-11-01 | Scoped AI features (simplify / quiz) as `could` stories | Keeps the core app deliverable at Milestones 1 and 2 risk-free; AI features added in the final sprint if time allows. | Mohammed, Sead, Nahom, Melkamu |
