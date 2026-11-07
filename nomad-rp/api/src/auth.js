const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const db = require('./db');

const router = express.Router();
const JWT_SECRET = process.env.JWT_SECRET;
if (!JWT_SECRET && process.env.NODE_ENV === 'production') {
  throw new Error('JWT_SECRET must be configured in production.');
}

function validateLogin(value) {
  return typeof value === 'string' && /^[a-zA-Z0-9_]{3,24}$/.test(value);
}
function validatePassword(value) {
  return typeof value === 'string' && value.length >= 8 && value.length <= 72;
}

router.post('/register', async (req, res) => {
  const { login, password } = req.body || {};
  if (!validateLogin(login) || !validatePassword(password)) {
    return res.status(400).json({
      error: 'Қате деректер. Логин 3–24 таңба, пароль кемінде 8 таңба болуы керек.'
    });
  }
  try {
    const [existing] = await db.execute(
      'SELECT id FROM accounts WHERE login = ? LIMIT 1', [login]
    );
    if (existing.length) {
      return res.status(409).json({ error: 'Бұл логин тіркелген.' });
    }
    const passwordHash = await bcrypt.hash(password, 12);
    const [result] = await db.execute(
      'INSERT INTO accounts (login, password_hash) VALUES (?, ?)',
      [login, passwordHash]
    );
    return res.status(201).json({
      ok: true,
      accountId: result.insertId,
      message: 'Аккаунт сәтті құрылды.'
    });
  } catch (err) {
    console.error('Register failed:', err.code || 'DB_ERROR');
    return res.status(500).json({ error: 'Сервер қатесі. Кейін қайталап көріңіз.' });
  }
});

router.post('/login', async (req, res) => {
  const { login, password } = req.body || {};
  if (!validateLogin(login) || !validatePassword(password)) {
    return res.status(400).json({ error: 'Логин немесе пароль форматы қате.' });
  }
  try {
    const [rows] = await db.execute(
      'SELECT id, login, password_hash FROM accounts WHERE login = ? LIMIT 1',
      [login]
    );
    if (!rows.length || !(await bcrypt.compare(password, rows[0].password_hash))) {
      return res.status(401).json({ error: 'Логин немесе пароль қате.' });
    }
    const token = jwt.sign({ sub: String(rows[0].id), login: rows[0].login },
      JWT_SECRET || 'development-only-secret-change-me', { expiresIn: '12h' });
    return res.json({ ok: true, token, message: 'Жүйеге сәтті кірдіңіз.' });
  } catch (err) {
    console.error('Login failed:', err.code || 'DB_ERROR');
    return res.status(500).json({ error: 'Сервер қатесі. Кейін қайталап көріңіз.' });
  }
});

module.exports = router;
