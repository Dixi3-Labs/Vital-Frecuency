require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const helmet = require('helmet');
const Sentry = require('@sentry/node');
const passport = require('passport');
const rateLimit = require('express-rate-limit');

Sentry.init({ dsn: process.env.SENTRY_DSN });

const app = express();
app.use(Sentry.Handlers.requestHandler());
app.use(cors());
app.use(express.json());
app.use(helmet());
app.use(passport.initialize());

const limiter = rateLimit({
  windowMs: 5 * 60 * 1000,
  max: 100
});
app.use(limiter);

mongoose.connect(process.env.MONGO_URL || 'mongodb://localhost:27017/dixoraclecore', { 
  useNewUrlParser: true, 
  useUnifiedTopology: true 
}).catch(err => console.error('MongoDB connection error:', err));

app.get('/api/ping', (req, res) => res.json({ message: 'pong' }));

// TODO: Import and mount auth, game, ai, report routes

app.use(Sentry.Handlers.errorHandler());

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`API listening on ${PORT}`));
