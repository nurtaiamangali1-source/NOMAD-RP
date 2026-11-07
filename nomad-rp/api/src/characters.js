const express = require('express');
const jwt = require('jsonwebtoken');
const db = require('./db');

const router = express.Router();
const JWT_SECRET = process.env.JWT_SECRET || 'development-only-secret-change-me';

function requireAuth(req, res, next) {
  const header = req.headers.authorization || '';
  const token = header.startsWith('Bearer ') ? header.slice(7) : '';
  try {
    req.user = jwt.verify(token, JWT_SECRET);
    return next();
  } catch {
    return res.status(401).json({ error: 'Жүйеге қайта кіріңіз.' });
  }
}

function validName(value) {
  return typeof value === 'string' && /^[A-ZА-ЯӘҒҚҢӨҰҮҺІ][a-zа-яәғқңөұүһі]{1,23}$/.test(value);
}

router.get('/', requireAuth, async (req, res) => {
  try {
    const [rows] = await db.execute(
      'SELECT id, first_name, last_name, gender, created_at FROM characters WHERE account_id = ?',
      [Number(req.user.sub)]
    );
    res.json({ characters: rows });
  } catch {
    res.status(500).json({ error: 'Кейіпкерлерді жүктеу мүмкін болмады.' });
  }
});

router.post('/', requireAuth, async (req, res) => {
  const { firstName, lastName, gender } = req.body || {};
  if (!validName(firstName) || !validName(lastName) || !['male', 'female'].includes(gender)) {
    return res.status(400).json({
      error: 'Аты-жөніңізді дұрыс енгізіңіз. Жынысын таңдаңыз.'
    });
  }
  try {
    const [rows] = await db.execute(
      'SELECT COUNT(*) AS count FROM characters WHERE account_id = ?',
      [Number(req.user.sub)]
    );
    if (rows[0].count >= 3) {
      return res.status(409).json({ error: 'Бір аккаунтта ең көбі 3 кейіпкер болуы мүмкін.' });
    }
    const [result] = await db.execute(
      `INSERT INTO characters (account_id, first_name, last_name, gender)
       VALUES (?, ?, ?, ?)`,
      [Number(req.user.sub), firstName, lastName, gender]
    );
    res.status(201).json({ ok: true, characterId: result.insertId,
      message: 'Кейіпкер сәтті құрылды.' });
  } catch {
    res.status(500).json({ error: 'Кейіпкерді сақтау кезінде қате шықты.' });
  }
});

module.exports = router;
