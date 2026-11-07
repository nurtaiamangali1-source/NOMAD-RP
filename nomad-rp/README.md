# NOMAD RP — Mobile Kazakhstan RolePlay

Initial project scaffold for Android + iOS launcher, Node.js API, and Pawn server module. Player-facing UI is localized in Kazakh; slash commands remain English.

## Structure
- `launcher/` — Flutter launcher UI starter (Android/iOS shell)
- `api/` — Node.js + Express API with health endpoint and auth route skeleton
- `server/pawn/` — Pawn gamemode starter for a SA-MP-compatible server
- `docs/ARCHITECTURE.md` — architecture overview
- `.env.example` — local configuration template

## Current status
This is a development scaffold, not a playable complete game. It does not bundle GTA assets,
a SA-MP mobile client, proprietary client code, or production credentials. Connecting a compatible
mobile client and hosting the server are separate integration tasks.

## Quick start: API
1. Install Node.js 20+
2. `cd api`
3. `npm install`
4. Copy `.env.example` to `.env` (or use the root example)
5. `npm run dev`

Health endpoint: `GET http://localhost:3000/health`

## Launcher
Install Flutter SDK, then:
1. `cd launcher`
2. `flutter pub get`
3. `flutter run`

Flutter must have Android and/or iOS tooling configured. The UI currently provides a launcher concept
and server status placeholder. Client launch/update actions are not wired to a proprietary game client.

## Server
Compile the Pawn source using a compatible server environment and its `a_samp` include.
Check the server runtime's license and compatibility before deploying.

## Account and character API (development)
- Import `api/sql/schema.sql` into MySQL.
- Configure API environment variables (especially JWT_SECRET).
- Register/login endpoints and character listing/creation are implemented in starter form.
- This is not production-ready; add deployment secrets, TLS, monitoring, additional validation and account abuse controls before public launch.
