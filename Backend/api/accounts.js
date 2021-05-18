const express = require('express');
const bcrypt = require("bcrypt");
const User = require('../models/user');
const router = express.Router();

router.get('/', async (req, res) => {
    const user = await User.find().exec();
    res.status(200).json({ user });
});

router.post('/signup', async (req, res) => {
    const { user } = req.body;
    if (!user.email || !user.name || !user.password) {
        res.status(400).json({ error: 'Invalid input' });
    } else {
        const existingUser = await User.findOne({ email: user.email }); 
        if (existingUser) {
            res.status(400).json({ error: 'Email already exists', existingUser });
        } else {
            const newUser = await User.create(user);
            const salt = await bcrypt.genSalt(10);
            newUser.password = await bcrypt.hash(user.password, salt);
            newUser.save();
            res.status(200).json({ newUser });
        }
    }
});



module.exports = router;