const mongoose = require('mongoose');
const BuyerSchema = require('./buyer');

const ListingSchema = new mongoose.Schema(
    {
        name: {
            type: String
        }
        
    /*    item_name: {
            type: String,
            required: true,
        },
        seller: {
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
        images: {
            type: [String],
            required: false,
        },
        buyers: {
            type: [BuyerSchema],
            required: false,
        }
    */
    }
)

const Listing = mongoose.model('Listing', ListingSchema);
module.exports = Listing;