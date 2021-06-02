const express = require('express');
const router = express.Router();

const multer = require('multer');
const fs = require('fs');
const path = require('path');
 
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads')
    },
    filename: (req, file, cb) => {
        cb(null, new Date().toISOString() + '-' + file.originalname)
    }
});
const upload = multer({ storage: storage });

const Listing = require('../models/listing');
const User = require('../models/user');

router.get('/', async (req, res) => {
    const listing = await Listing.find().populate({ path: 'seller_id', select: [ 'name' ] }).populate('bids').exec();
    return res.status(200).json({ listing });
});

router.get('/:listing_id', async (req, res) => {
    const { listing_id } = req.params;
    if (!listing_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const listing = await Listing.findById(req.params.listing_id).populate({ path: 'seller_id', select: [ 'name' ] }).populate('bids');
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

    const listing = await Listing.find({ seller_id: seller_id }).populate({ path: 'seller_id', select: [ 'name' ] }).populate('bids');
    if (!listing || listing.length === 0) {
        return res.status(200).json({ message: 'User does not have any listings' });
    }
    
    return res.status(200).json({ listing });
});

router.get('/category/:category_name', async (req, res) => {
    const { category_name } = req.params;
    if (!category_name) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const all_listings = await Listing.find().populate({ path: 'seller_id', select: [ 'name' ] }).populate('bids');
    const listings = [];

    all_listings.forEach(listing => {
        if (listing.categories.includes(category_name)) {
            listings.push(listing);
        }
    });

    return res.status(200).json({ listings });
});

router.post('/', upload.single('image'), async (req, res) => {
    const { item_name, seller_id, price, highest_bid, description, categories } = req.body;
    const listing = { item_name, seller_id, price, highest_bid, description, categories };

    if (!item_name || !seller_id || !price || !highest_bid || !description) {
        return res.status(400).json({ error: 'Invalid input' });
    }

    const newListing = await Listing.create(listing);
    if (req.file) {
        //newListing.image = req.file.path;
        newListing.image.filename = req.file.filename;
        newListing.image.data = fs.readFileSync(path.join('uploads/' + req.file.filename));
        newListing.save();
    }
    return res.status(200).json({ newListing });    
});

router.put('/:listing_id', upload.single('image'), async (req, res) => {
    const { listing_id } = req.params;
    if (!listing_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }
    
    const existingListing = await Listing.findById(req.params.listing_id);
    if (!existingListing) {
        return res.status(400).json({ error: 'Listing does not exist' });
    }

    if (req.body.item_name)   existingListing.item_name = req.body.item_name;
    if (req.body.seller_id)   existingListing.seller_id = req.body.seller_id;
    if (req.body.price)       existingListing.price = req.body.price;
    if (req.body.highest_bid) existingListing.highest_bid = req.body.highest_bid;
    if (req.body.description) existingListing.description = req.body.description;
    if (req.body.categories)  existingListing.categories = req.body.categories;
    if (req.file) {
        existingListing.image.filename = req.file.filename;
        existingListing.image.data = fs.readFileSync(path.join('uploads/' + req.file.filename));
    }
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