const express = require('express');
const Listing = require('../models/listing');
const User = require('../models/user');
const router = express.Router();

router.get('/', async (req, res) => {
    const listing = await Listing.find().exec();
    return res.status(200).json({ listing });
});

router.get('/:listing_id', async (req, res) => {
    const { listing_id } = req.params;
    if (!listing_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const listing = await Listing.findById(req.params.listing_id);
    if (!listing) {
        return res.status(400).json({ error: 'Listing does not exist' });
    }

    return res.status(200).json({ listing });
});

router.get('/seller/:seller_id', async (req, res) => {
    const { seller_id } = req.params;
    if (!seller_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const user = await User.findById(seller_id);
    if (!user) {
        return res.status(400).json({ error: 'User does not exist' });
    }

    const listing = await Listing.find({ seller_id: seller_id });
    if (!listing || listing.length === 0) {
        return res.status(200).json({ message: 'User does not have any listings' });
    }
    
    return res.status(200).json({ listing });
});

router.post('/', async (req, res) => {
    const { listing } = req.body;
    const { item_name, seller_id, price, highest_bid, description } = listing;

    if (!item_name || !seller_id || !price || !highest_bid || !description) {
        return res.status(400).json({ error: 'Invalid input' });
    }

    const newListing = await Listing.create(listing);
    return res.status(200).json({ newListing });

    // req.file --> has file 
    // frontend sends request with multi part form data as content type
    // multer parses form data into req.file
    // backend implements uploading file into aws s3 and getting url
    // store url in listing
    // all this done before creating listing
    
});

router.put('/:listing_id', async (req, res) => {
    const { listing_id } = req.params;
    if (!listing_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const { listing } = req.body;
    const { item_name, seller_id, price, highest_bid, description } = listing;

    if (!item_name || !seller_id || !price || !highest_bid || !description) {
        return res.status(400).json({ error: 'Invalid input' });
    }

    const existingListing = await Listing.findById(req.params.listing_id);
    if (!existingListing) {
        return res.status(400).json({ error: 'Listing does not exist' });
    }

    existingListing.item_name = item_name;
    existingListing.seller_id = seller_id;
    existingListing.price = price;
    existingListing.highest_bid = highest_bid;
    existingListing.description = description;
    existingListing.save();
    return res.status(200).json({ message: 'Listing updated successfully' });
});

router.delete('/:listing_id', async (req, res) => {
    const { listing_id } = req.params;
    if (!listing_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const existingListing = await Listing.findById(req.params.listing_id);
    if (!existingListing) {
        return res.status(400).json({ error: 'Listing does not exist' });
    }

    await Listing.deleteMany({ _id: listing_id });
    return res.status(200).json({ message: 'Listing deleted successfully' });
});

module.exports = router;