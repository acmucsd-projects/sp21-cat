const express = require('express');
const bcrypt = require("bcrypt");
const User = require('../models/user');
const Listing = require('../models/listing');
const router = express.Router();

router.get('/', async (req, res) => {
    const user = await User.find().exec();
    res.status(200).json({ user });
});

router.post('/signup', async (req, res) => {
    const { user } = req.body;
    if (!user.email || !user.name || !user.password) {
        return res.status(400).json({ error: 'Invalid input' });
    } 
    
    const existingUser = await User.findOne({ email: user.email }); 
    if (existingUser) {
        return res.status(400).json({ error: 'Email already exists' });
    }
    
    const newUser = await User.create(user);
    const salt = await bcrypt.genSalt(10);
    newUser.password = await bcrypt.hash(user.password, salt);
    newUser.save();
    res.status(200).json({ newUser });
});

router.post('/login', async (req, res) => {
    const { user } = req.body;
    if (!user.email || !user.password) {
        return res.status(400).json({ error: 'Invalid input' });
    } 
    
    const existingUser = await User.findOne({ email: user.email }); 
    if (existingUser) {
        const validPassword = await bcrypt.compare(user.password, existingUser.password);
        if (validPassword) {
            return res.status(200).json({ message: 'Successfully logged in' });
        } 
        return res.status(400).json({ error: 'Incorrect password' });
    } 

    res.status(400).json({ error: 'User does not exist' });
});

router.post('/edit', async (req, res) => {
    const { user } = req.body;
    if (!user.email || !user.name || !user.password) {
        return res.status(400).json({ error: 'Invalid input' });
    } 

    const existingUser = await User.findOne({ email: user.email }); 
    if (existingUser) {
        existingUser.name = user.name;
        const salt = await bcrypt.genSalt(10);
        existingUser.password = await bcrypt.hash(user.password, salt);
        existingUser.save();
        res.status(200).json({ existingUser });
    }
});

module.exports = router;