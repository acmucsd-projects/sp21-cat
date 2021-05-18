const express = require('express');
const User = require('../models/user');
const router = express.Router();

router.post('/signup', async (req, res) => {
    const { user } = req.body;
    const { email, name, password } = user;
    if (!email || !name || !password) {
        res.status(400).json({ error: 'Invalid input' });
    } else {
        const newUser = await User.create(user);
        res.status(200).json({ newUser });
    }
});

module.exports = router;