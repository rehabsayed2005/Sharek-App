const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');
const { protect, adminOnly } = require('../middleware/authMiddleware');

router.post('/api/products', protect, adminOnly,productController.addProduct);

router.get('/api/products',productController.getAllProducts );

router.get('/api/products/:id', productController.getSingleProduct);

router.put('/api/products/:id',protect,adminOnly,productController.replaceProduct );

router.patch('/api/products/:id',protect,adminOnly,productController.updateProduct );

router.delete('/api/products/:id', protect, adminOnly, productController.deleteProduct);

module.exports = router;