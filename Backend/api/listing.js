const express = require('express');
const Listing = require('../models/listing');
const router = express.Router();

router.get('/', async (req, res) => {
    const listing = await Listing.find().exec();

    res.status(200).json({ listing });
});

router.post('/', async (req, res) => {
    const { listing } = req.body;
    const { item_name, seller, price, highest_bid, description } = listing;
    if (!item_name || !seller || !price || !highest_bid || !description) {
        res.status(400).json({ error: 'Invalid input' });
    } else {
        const newListing = await Listing.create(listing);
        res.status(200).json({ newListing });
    }

    // req.file --> has file 
    // frontend sends request with multi part form data as content type
    // multer parses form data into req.file
    // backend implements uploading file into aws s3 and getting url
    // store url in listing
    // all this done before creating listing
    
});

module.exports = router;