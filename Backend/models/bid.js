const mongoose = require('mongoose');
const ObjectId = require('mongodb').ObjectID;

const BidSchema = new mongoose.Schema(
    {
        bidder_id: {
            type: ObjectId,
            required: true,
            ref: 'User',
        },
        listing_id: {
            type: ObjectId,
            required: true,
            ref: 'Listing',
        },
        bid_amt: {
            type: Number,
            required: true,
        },
        timestamp: {
            type: Date,
            required: true,
            /* default: Date.now */
        }
    }
)

const Bid = mongoose.model('Bid', BidSchema);
module.exports = Bid;