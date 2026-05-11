const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    name: { type: String, required: true,minLength:3 },
    price: { type: Number, required: true ,min:0},
    category: { type: String, enum: ['clothes', 'electronic', 'accessories', 'beauty'], required: true },
    type: { type: String, enum: ['new', 'used'], required: true },
    condition: { type: String, enum: ['good', 'new', 'like new', 'almost new'], required: true },
    description: { type: String, required: true, minLength: 5 },
    imageUrl: { type: String, required: true },
    createdAt: { type: Date, default: Date.now },
    stock: { 
        type: Number, 
        required: true, 
        default: 0, 
        min: [0, 'Stock cannot be less than zero'] 
        },
    user: { 
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'User', 
        required: true 
    }
});

const Product = mongoose.model('Product', productSchema);
module.exports = Product;