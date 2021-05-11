const express = require('express');
const Listing = require('../models/listing');

const router = express.Router();

router.get('/listing', async (req, res) => {
    const listing = await Listing.find().exec();

    res.status(200).json({ listing });
});

router.post('/listing', async (req, res) => {
    const { listing } = req.body;
    Listing.create(listing);
    
    
    /*
    const { item_name, seller, price, highest_bid, categories, description, images, buyers } = listing
    if (( !item_name || !seller || !price || !highest_bid || !description) || images.length > 3 ) {
        res.status(400).json({ error: 'Invalid input' });
    } else {
        const newListing = await Listing.create(listing);
        res.status(200).json({ listing: newListing });
    }
    */
});

module.exports = router;
