const mongoose = require('mongoose');
const BidSchema = require('./bid');

const ListingSchema = new mongoose.Schema(
    {
        item_name: {
            type: String,
            required: true,
        },
        sellerEmail: {
            type: String,
            required: true,
        },
        sellerName: {
            type: String,
            required: true,
        },
        price: {
            type: Number,
            required: true,
        },
        highest_bid: {
            type: Boolean,
            required: true,
        },
        categories: {
            type: [String],
            required: false,
        },
        description: {
            type: String,
            required: true,
        },
        /*images: {
            type: [String],
            required: false,
        },
        bids: {
            type: [BidSchema],
            required: false,
        }*/
    
    }
)

const Listing = mongoose.model('Listing', ListingSchema);
module.exports = Listing;