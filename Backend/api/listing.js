const express = require('express');
const Listing = require('../models/listing');
const User = require('../models/user');
const router = express.Router();

router.get('/', async (req, res) => {
    const listing = await Listing.find().exec();
    res.status(200).json({ listing });
});

router.get('/:sellerEmail', async (req, res) => {
    const { sellerEmail } = req.params;
    if (!sellerEmail) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const existingUser = await User.findOne({ email: sellerEmail }); 
    if (!existingUser) {
        return res.status(400).json({ error: 'User does not exist' });
    }

    await Listing.find({ sellerEmail: sellerEmail }, function(err, listings) {
        if (err) {
            return res.status(400).json({ error: 'An error has occurred' });
        }
        if (!listings || listings.length == 0) {
            return res.status(200).json({ message: 'User does not have any listings' });
        }
        res.status(200).json({ listings });
    }); 
});

router.post('/', async (req, res) => {
    const { listing } = req.body;
    const { item_name, sellerName, price, highest_bid, description } = listing;

    if (!item_name || !sellerName || !price || !highest_bid || !description) {
        return res.status(400).json({ error: 'Invalid input' });
    }

    const newListing = await Listing.create(listing);
    res.status(200).json({ newListing });

    // req.file --> has file 
    // frontend sends request with multi part form data as content type
    // multer parses form data into req.file
    // backend implements uploading file into aws s3 and getting url
    // store url in listing
    // all this done before creating listing
    
});

router.put('/:listing_id', async (req, res) => {
    const { listing } = req.body;
    const { item_name, sellerName, price, highest_bid, description } = listing;

    if (!item_name || !sellerName || !price || !highest_bid || !description) {
        return res.status(400).json({ error: 'Invalid input' });
    }

    const existingListing = User.findById(req.params.user_id);
    if (existingListing) {
        existingListing.item_name = item_name;
        existingListing.sellerName = sellerName;
        existingListing.price = price;
        existingListing.highest_bid = highest_bid;
        existingListing.description = description;
        existingListing.save();
        res.status(200).json({ message: 'User updated successfully', existingListing });
    }
});

module.exports = router;