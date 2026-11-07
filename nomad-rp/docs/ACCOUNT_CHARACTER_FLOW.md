# NOMAD RP — Аккаунт және кейіпкер ағымы

1. Launcher login/register screens call API `/api/v1/auth/register` and `/api/v1/auth/login`.
2. API stores login and bcrypt password hash; plaintext password is never persisted.
3. Login returns a short-lived JWT (12 hours).
4. Launcher requests `GET /api/v1/characters` with `Authorization: Bearer <token>`.
5. If character list is empty, show character creation screen.
6. Character creation submits first name, last name, gender to `POST /api/v1/characters`.
7. Character selection should then hand off to the compatible mobile game client and selected character ID.

API endpoints:
- `POST /api/v1/auth/register`
- `POST /api/v1/auth/login`
- `GET /api/v1/characters`
- `POST /api/v1/characters`

Player-facing copy is Kazakh. Slash commands are English.
