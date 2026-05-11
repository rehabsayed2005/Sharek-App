const Order = require('../models/orderModel');
const Product = require('../models/productModel');

const getUserOrders=async (req, res) => {
    try {
        const orders = await Order.find({ userId: req.user._id });

        if (orders.length === 0) {
            return res.status(404).json({ message: "you have no orders yet" });
        }

        res.json(orders);

    } catch (error) {
        res.status(400).json(error);
    }
}
const getAllOrders=async(req,res)=>{
    try {
        const orders = await Order.find().populate('userId', 'name email');
        res.json(orders);
        }
        
    catch(error){
        res.status(404).json({ message:error.message });
    }
}

const getOrderById=async (req, res) => {
    
    try {
        const order = await Order.findById(req.params.id).populate('userId', 'name email');
        if (!order) {
            return res.status(404).json({ message: "order not found" })
        }
        res.json(order);
    
    } catch (error) {
        
        return res.status(400).json({ message: error.message })
    }
}

const createOrder= async (req, res) => {
    try {   let totalPrice = 0;
            let finalItems = [];
        if (!req.body.products || req.body.products.length === 0) {
        return res.status(400).json({ message: "No products in order" });
    }
        for (let item of req.body.products) {
        const product = await Product.findById(item.productId);
        if (!product) return res.status(404).json({ message: "Product not found" });
        if (product.stock < item.quantity) {
        return res.status(400).json({ message: `Sorry, only ${product.stock} items left for ${product.name}` });
        }
        product.stock -= item.quantity;
        await product.save();
        totalPrice += product.price * item.quantity;
        finalItems.push({
            productId: product._id,
            name: product.name,
            imageUrl: product.imageUrl,
            price: product.price,
            quantity: item.quantity
        });
    }
            const order = new Order({
            userId: req.user._id,
            orderItems: finalItems,
            totalPrice: totalPrice,
                shippingAddress: req.body.shippingAddress
            });

            await order.save();
            res.status(201).json(order);
    }
            catch (error) {
                console.log(error);
        res.status(400).json({ message: error.message });
    }
}

    const UpdateOrder=async (req, res) => {
        try {
        const { status } = req.body;
        
    const allowedStatuses = ['pending', 'shipped', 'delivered', 'cancelled'];
    if (status && !allowedStatuses.includes(status)) {
        return res.status(400).json({ message: "Invalid status value" });
    }
    const result = await Order.findByIdAndUpdate(
        req.params.id,
        { status: status },
        { new: true,runValidators: true}
    );

    if (!result) {
        return res.status(404).json({
        message: "order not found"
        });
    }
        res.status(200).json({
        message: "order status is updated successfully",
        order: result
    });

    } catch (error) {
        res.status(404).json({
        message: "error during the update",
        error: error.message
    });
    }
}

    const deleteOrder=async (req, res) => {
    try {
        const order = await Order.findById(req.params.id);
        if (!order) return res.status(404).json({ message: "Order not found" });

        const isUser = order.userId.equals(req.user._id);
        const isAdmin = req.user.isadmin;

        if (!isUser && !isAdmin) {
            return res.status(403).json({ message: "You are unauthorized!" });
        }
            const { itemId, quantity } = req.body || {}; 
            if (itemId) {
            const itemIndex = order.orderItems.findIndex(item => item._id.toString() === itemId);
            if (itemIndex === -1) return res.status(404).json({ message: "Item not found" });
            const item = order.orderItems[itemIndex];
            if (quantity && quantity < item.quantity) {
                item.quantity -= quantity;
                const product = await Product.findById(item.productId);
                if (product) {
                    product.stock += quantity;
                    await product.save();
                }
                order.totalPrice -= (item.price * quantity);
                await order.save();
                return res.status(200).json({ message: "Quantity decreased", order });
            } 
            else {
                const product = await Product.findById(item.productId);
                if (product) {
                    product.stock += item.quantity;
                    await product.save();
                }
                order.totalPrice -= (item.price * item.quantity);
                order.orderItems.splice(itemIndex, 1);
                
                if (order.orderItems.length === 0) order.status = 'cancelled';
                
                await order.save();
                return res.status(200).json({ message: "Item removed entirely", order });
            }
        }
            if (isAdmin || isUser) {
            for (let item of order.orderItems) {
                const product = await Product.findById(item.productId);
                if (product) {
                    product.stock = (product.stock || 0) + item.quantity;
                    await product.save();
                }
            }
        }
            await Order.findByIdAndDelete(req.params.id);
            res.status(200).json({
            message: isAdmin ? "Order deleted by admin" : "Order cancelled successfully"
        });
    }
    catch (error) {
        res.status(500).json({ message: "Server error", error: error.message });
    }
}

    module.exports = {
        getUserOrders,
        getAllOrders,
        getOrderById,
        createOrder,
        UpdateOrder,
        deleteOrder
        }