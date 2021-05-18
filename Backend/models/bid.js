const mongoose = require('mongoose');

const BidSchema = new mongoose.Schema(
    {
        name: {
            type: String,
            required: true,
        },
        bid: {
            type: Number,
            required: true,
        },
        timestamp: {
            type: Date,
            required: true,
        }
    }
)

const Bid = mongoose.model('Bid', BidSchema);
module.exports = Bid;