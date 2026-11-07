# NOMAD RP — Қазақша тіл стандарты

Жобаның негізгі интерфейс тілі — қазақ тілі. Командалар мен командалардың атауы ағылшын тілінде қалады.

## Launcher / UI
- Play: ОЙЫНҒА КІРУ
- Register: ТІРКЕЛУ
- Login: КІРУ
- Settings: БАПТАУЛАР
- Server status: СЕРВЕР ЖАҒДАЙЫ
- Server in development: СЕРВЕР ӘЗІРЛЕНУ ҮСТІНДЕ
- Character selection: КЕЙІПКЕРДІ ТАҢДАУ
- Create character: КЕЙІПКЕР ЖАСАУ
- Health: ДЕНСАУЛЫҚ
- Money: АҚША
- Inventory: ЖАБДЫҚТАР
- Job: ЖҰМЫС
- Bank: БАНК
- Phone: ТЕЛЕФОН
- Vehicle: КӨЛІК
- Faction: ҰЙЫМ
- Notifications: ХАБАРЛАМАЛАР
- Loading: ЖҮКТЕЛУДЕ
- Connection lost: БАЙЛАНЫС ҮЗІЛДІ
- Retry: ҚАЙТА КӨРУ
- Cancel: БАС ТАРТУ
- Confirm: РАСТАУ

## Commands (English aliases retained)
- `/help` — көмек және командалар тізімі
- `/me` — кейіпкердің әрекетін сипаттау
- `/do` — жағдайды немесе ортаны сипаттау
- `/buy` — сатып алу
- `/stats` — кейіпкер статистикасы
- `/inventory` — инвентарьды ашу
- `/phone` — телефонды ашу
- `/gps` — навигация
- `/bank` — банк мәзірі

## Language rules
1. Player-facing messages should be written in natural Kazakh.
2. Slash commands and technical identifiers remain English.
3. Avoid machine-translated or mixed Russian-Kazakh UI strings.
4. Keep localization keys stable (e.g. `launcher.play`, `auth.register`).
5. Before release, native Kazakh proofreading is recommended.
