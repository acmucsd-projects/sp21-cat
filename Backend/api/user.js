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
    if (!user.email || !user.name || !user.password || !user.confirm_pswd) {
        return res.status(400).json({ error: 'Invalid input' });
    }
    
    const existingUser = await User.findOne({ email: user.email }); 
    if (existingUser) {
        return res.status(400).json({ error: 'Email already exists' });
    }

    if (user.password != user.confirm_pswd) {
        return res.status(400).json({ error: 'Passwords must match' });
    }
    
    const newUser = await User.create(user);
    const salt = await bcrypt.genSalt(10);
    newUser.password = await bcrypt.hash(user.password, salt);
    newUser.save();
    res.status(200).json({ newUser });
});

router.put('/:user_id', async (req, res) => {
    const { user } = req.body;
    if (!user.email || !user.name || !user.password || !user.confirm_pswd) {
        return res.status(400).json({ error: 'Invalid input' });
    } 

    const updatedUser = await User.findById(req.params.user_id);
    if (!updatedUser) {
        return res.status(400).json({ error: 'User does not exist' });
    }

    if (user.password != user.confirm_pswd) {
        return res.status(400).json({ error: 'Passwords must match' });
    }
        
    updatedUser.email = user.email;
    updatedUser.name = user.name;
    const salt = await bcrypt.genSalt(10);
    updatedUser.password = await bcrypt.hash(user.password, salt);
    updatedUser.save();
    res.status(200).json({ message: 'User updated successfully' });
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

module.exports = router;