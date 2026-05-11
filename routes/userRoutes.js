const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const { protect, adminOnly } = require('../middleware/authMiddleware');

router.post('/api/signup',userController.addNewUser);

router.post('/api/signin',userController.loginUser );

router.get('/api/users/profile', protect,userController.getUserProfile);

router.patch('/api/users/profile', protect, userController.updateUserProfile);

router.get('/api/users', protect, adminOnly, userController.getAllUsers);

router.delete('/api/users/:id', protect, adminOnly, userController.deletedUser);

module.exports = router;



