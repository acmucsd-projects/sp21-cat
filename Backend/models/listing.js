const mongoose = require('mongoose');
const ObjectId = require('mongodb').ObjectID;

const ListingSchema = new mongoose.Schema(
    {
        item_name: {
            type: String,
            required: true,
        },
        seller_id: {
            type: ObjectId,
            required: true,
            ref: 'User',
        },
        price: {
            type: Number,
            required: true,
        },
        highest_bid: {
            type: Boolean,
            required: true,
            default: true,
        },
        categories: {
            type: [String],
            required: false,
        },
        description: {
            type: String,
            required: true,
        },
        image: {
            filename: String,
            data: Buffer,
        },
        bids: [{
            type: ObjectId,
            ref: 'Bid',
        }],
    
    }
)

const Listing = mongoose.model('Listing', ListingSchema);
module.exports = Listing;