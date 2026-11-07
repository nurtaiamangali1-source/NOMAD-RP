const express = require('express');
const rateLimit = require('express-rate-limit');

const app = express();
const authRoutes = require('./auth');
const characterRoutes = require('./characters');
app.disable('x-powered-by');
app.use(express.json({ limit: '32kb' }));

const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  limit: 30,
  standardHeaders: 'draft-7',
  legacyHeaders: false
});

app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/characters', characterRoutes);

app.get('/health', (_req, res) => {
  res.json({ ok: true, project: 'NOMAD RP', apiVersion: '0.1.0' });
});

app.get('/api/v1/server/status', (_req, res) => {
  // TODO: replace placeholder with live game-server query integration.
  res.json({
    name: 'NOMAD RP | Kazakhstan',
    status: 'development',
    players: 0,
    maxPlayers: 500
  });
});

app.post('/api/v1/auth/register', authLimiter, (_req, res) => {
  // TODO: validate fields, hash password with bcrypt/Argon2id, persist account.
  // Do not return or log plaintext passwords.
  res.status(501).json({ error: 'Registration is not implemented yet.' });
});

app.post('/api/v1/auth/login', authLimiter, (_req, res) => {
  // TODO: verify password hash, issue JWT, add account lockout/risk controls.
  res.status(501).json({ error: 'Login is not implemented yet.' });
});

const port = Number(process.env.PORT || 3000);
app.listen(port, () => {
  console.log(`NOMAD RP API listening on port ${port}`);
});
