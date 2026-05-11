const express = require('express');
const router= express.Router();
const orderController = require('../controllers/orderController');
const { protect, adminOnly } = require('../middleware/authMiddleware');

router.get('/api/orders/myorders', protect,orderController.getUserOrders );

router.get('/api/admin/orders',protect,adminOnly,orderController.getAllOrders);

router.get('/api/admin/orders/:id', protect, adminOnly,orderController.getOrderById );

router.post('/api/orders',protect,orderController.createOrder);

router.patch('/api/orders/:id', protect, adminOnly,orderController.UpdateOrder);

router.delete('/api/orders/:id', protect, orderController.deleteOrder);

module.exports = router;