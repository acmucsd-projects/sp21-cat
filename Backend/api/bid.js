const express = require('express');
const Listing = require('../models/listing');
const User = require('../models/user');
const Bid = require('../models/bid');
const router = express.Router();

router.get('/', async (req, res) => {
    const bid = await Bid.find().populate('listing_id').populate({ path: 'bidder_id', select: [ 'name' ] }).exec();
    res.status(200).json({ bid });
});

router.post('/:listing_id', async (req, res) => {
    const { listing_id } = req.params;
    if (!listing_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const { bid } = req.body;
    const { bidder_id, bid_amt } = bid;
    if (!bidder_id || !bid_amt) {
        return res.status(400).json({ error: 'Invalid input' });
    }

    const listing = await Listing.findById(req.params.listing_id);
    if (!listing) {
        return res.status(400).json({ error: 'Listing does not exist' });
    }

    const existingBid = await Bid.findOne({ bidder_id: bidder_id, listing_id: listing_id });
    if (existingBid) {
        return res.status(400).json({ error: 'Already made bid for this item' });
    }

    if (bid_amt < listing.price) {
        return res.status(400).json({ error: 'Bid amount must be greater than listed price' });
    }

    if (listing.seller_id.equals(bidder_id)) {
        return res.status(400).json({ error: 'Seller cannot bid' });
    }

    const newBidSchema = {
        bidder_id: bidder_id,
        listing_id: listing_id,
        bid_amt: bid_amt,
    }

    const newBid = await Bid.create(newBidSchema);
    const bids = listing.bids;
    bids.push(newBid._id);
    listing.bids = bids;
    listing.save();
    
    res.status(200).json({ message: 'Bid successful' });
});

router.get('/price/:listing_id', async (req, res) => {
    const { listing_id } = req.params;
    if (!listing_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const listing = await Listing.findById(req.params.listing_id).populate('bids').populate({ path: 'bids.bidder_id', select: [ 'name' ] });
    if (!listing) {
        return res.status(400).json({ error: 'Listing does not exist' });
    }

    const bids = listing.bids;
    bids.sort((a, b) => (a.bid_amt > b.bid_amt || (a.bid_amt === b.bid_amt && a.timestamp > b.timestamp)) ? -1 : 1);
    return res.status(200).json({ bids });
});

router.get('/time/:listing_id', async (req, res) => {
    const { listing_id } = req.params;
    if (!listing_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const listing = await Listing.findById(req.params.listing_id).populate('bids');
    if (!listing) {
        return res.status(400).json({ error: 'Listing does not exist' });
    }

    const bids = listing.bids;
    bids.sort((a, b) => (a.timestamp > b.timestamp || (a.timestamp === b.timestamp && a.bid_amt > b.bid_amt)) ? 1 : -1);
    return res.status(200).json({ bids });
});

router.get('/:buyer_id', async (req, res) => {
    const { buyer_id } = req.params;
    if (!buyer_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const user = await User.findById(buyer_id);
    if (!user) {
        return res.status(400).json({ error: 'User does not exist' });
    }

    const bids = await Bid.find({ bidder_id: buyer_id }).populate('listing_id');
    return res.status(200).json({ bids });
});

router.post('/approve/:bid_id', async (req, res) => {
    const { bid_id } = req.params;
    if (!bid_id) {
        return res.status(400).json({ error: 'Invalid parameter' });
    }

    const bid = await Bid.findById(bid_id);
    if (!bid) {
        return res.status(400).json({ error: 'Bid does not exist' });
    }

    bid.approved = true;
    bid.save();
    return res.status(200).json({ message: 'Successfully approved bid' });
})

module.exports = router;