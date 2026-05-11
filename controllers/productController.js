const Product = require('../models/productModel');

const addProduct = async (req, res) => {
    try {
        const productdata = { ...req.body };
        productdata.user = req.user._id;
        const newProduct = new Product(productdata);
        const savedProduct = await newProduct.save();
        res.status(201).json(
            {
                message: "product added successfully by admin",
                product:savedProduct
            }   
        );
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
}

        const getAllProducts=async (req, res) => {
    try {
        const { category, type,condition,name,price,minPrice, maxPrice } = req.query;
        let filter = {};
        
        if (category) filter.category = category.toLowerCase();
        if (type) filter.type = type.toLowerCase();
        if (condition) filter.condition = condition.toLowerCase();
        if (name) filter.name = { $regex: name, $options: 'i' };
        if (price) {
            filter.price = Number(price);
        } else if (minPrice || maxPrice) {
            filter.price = {};
            if (minPrice) filter.price.$gte = Number(minPrice);
            if (maxPrice) filter.price.$lte = Number(maxPrice);
        }
        const products = await Product.find(filter).populate('user','name email');
        res.json(products);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
}

const getSingleProduct=async (req, res) => {
    try {
        const product = await Product.findById(req.params.id).populate('user','name email');
        if (!product) return res.status(404).json({ message: "Product not found" });
        res.json(product);
    } catch (err) {
        res.status(400).json({ message: "Invalid ID format" });
    }
}

const replaceProduct=async (req, res) => {
    try {
        const updatedProduct = await Product.findByIdAndUpdate(
            req.params.id, 
            req.body, 
            { new: true, runValidators: true, overwrite: true }
        );
        if (!updatedProduct) return res.status(404).json({ message: "Product not found" });
        res.json(
            {
                message: "product fully updated by admin",
                product: updatedProduct
            });
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
}

const updateProduct=async (req, res) => {
    try {
        const updatedProduct = await Product.findByIdAndUpdate(
            req.params.id, 
            { $set: req.body }, 
            { new: true,runValidators:true }
        );
        if (!updatedProduct) return res.status(404).json({ message: "Product not found" });
        res.json(updatedProduct);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
}

const deleteProduct=async (req, res) => {
    try {
        const deletedProduct = await Product.findByIdAndDelete(req.params.id);
        if (!deletedProduct) return res.status(404).json({ message: "Product not found" });
        res.json({ message: "Product deleted successfully" });
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
}

module.exports ={
    addProduct,
    getAllProducts,
    getSingleProduct,
    replaceProduct,
    updateProduct,
    deleteProduct

}