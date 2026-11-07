# NOMAD RP Architecture

```text
Flutter Launcher (Android / iOS)
  ├─ News / server list / account UI
  ├─ API client
  └─ Compatible SA-MP mobile client integration (separate, licensed/authorized component)
             │ HTTPS
             ▼
Node.js API (Express)
  ├─ Auth and account endpoints
  ├─ Server status / news
  └─ Admin API (later, permission protected)
             │
             ├─ MySQL: accounts, characters, inventory, vehicles, economy
             └─ Game server integration
                         │
                         ▼
Pawn GameMode (SA-MP-compatible server)
  ├─ Character creation / spawn
  ├─ RP commands and interactions
  ├─ Jobs / factions / economy
  └─ Persistence via approved DB integration
```

## Suggested milestones
1. Project scaffold, health endpoint, launcher UI.
2. Secure account system and schema migrations.
3. Character creation, spawn and persistence.
4. Core RP systems: phone, jobs, inventory, vehicles.
5. Factions: Police, EMS, government, media.
6. Mobile client compatibility testing, performance and security hardening.

## Security baseline
- Store password hashes only (Argon2id or bcrypt).
- Use parameterized SQL queries.
- JWT secrets must be generated and never committed.
- Rate-limit authentication routes and log security events.
- Validate every client-provided field server-side.
