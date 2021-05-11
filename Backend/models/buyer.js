const mongoose = require('mongoose');

const BuyerSchema = new mongoose.Schema(
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

module.exports = BuyerSchema;