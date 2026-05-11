const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({

    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    orderItems: [{
        productId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Product',
            required: true
        },

        name: {
            type: String,
            required: true
        },

        imageUrl: String,

        price: {
            type: Number,
            required: true
        },
        quantity: {
            type: Number,
            default: 1,
            required: true,
            min:1
        },
    }],
    shippingAddress: { 
        type: String,
        required: true
    },

    totalPrice: { type: Number, required: true, default: 0.0 },
    
        status: { 
        type: String, 
        enum: ['pending', 'shipped', 'delivered', 'cancelled'], 
        default: 'pending' 
    },
        paymentMethod: {
        type: String,
        required: true,
        default: 'Cash'
    }
},
    { timestamps: true });


const Order = mongoose.model("Order", orderSchema);
module.exports = Order;