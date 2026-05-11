const { User, generateToken } = require('../models/userModel');

const addNewUser = async (req, res) => {
try {

        const existingUser = await User.findOne({
            email: req.body.email
        });

        if (existingUser) {

            return res.status(400).json({
                message: 'Email already exists'
            });

        }

        const user = new User(req.body);

        await user.save();

        res.status(201).json({

            message: 'User created successfully',

            token: generateToken(user._id),

            user

        });

    } catch (error) {
    res.status(400).json(error);

    }

}


const loginUser=async (req, res) => {

    try {

        const user = await User.findOne({
            email: req.body.email
        });

        if (!user) {

            return res.status(400).json({
                message: 'Wrong email or password'
            });

        }

        const isMatch = await user.comparePassword(req.body.password);

        if (!isMatch) {

            return res.status(400).json({
                message: 'Wrong email or password'
            });
            }res.json({
                message: 'Login success',
                token: generateToken(user._id), user
            });

    } catch (error) {

        res.status(400).json(error);
    }

}

const getUserProfile= async (req, res) => {

    try {

        const user = await User.findById(req.user._id).select('-password');

        if (!user) {

            return res.status(404).json({
                message: 'User not found'
            });

        }

        res.json(user);

    } catch (error) {

        res.status(400).json(error);

    }

}

const updateUserProfile=async (req, res) => {

    try {
            const user = await User.findById(req.user._id);
            if (!user) {
            return res.status(404).json({
                message: 'User not found'
            });
        }
        if (req.body.name === '') {
            return res.status(400).json({
                message: 'Name cannot be empty'
            });
        }
        if (req.body.name) user.name = req.body.name;
        if (req.body.phone) user.phone = req.body.phone;
        if (req.body.address) user.address = req.body.address;
        if (req.body.gender) user.gender = req.body.gender;
        if (req.body.password) user.password = req.body.password; 
        const updatedUser = await user.save();
        res.json({
            message: 'Profile updated successfully',
            user: updatedUser
        });

    } catch (error) {

        res.status(400).json({ message: error.message });
    }

}

const getAllUsers=async (req, res) => {
    try {
        const users = await User.find().select('-password');
        res.json(users);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

const deletedUser=async (req, res) => {

    try {

        const id = req.params.id;

        const user = await User.findByIdAndDelete(id);

        if (!user) {

            return res.status(404).json({
                message: 'User not found'
            });

        }

        res.json({
            message: 'User deleted successfully',
            user
        });

    } catch (error) {

        res.status(400).json({ message: error.message });

    }
}
module.exports = {
    addNewUser,
    loginUser,
    getUserProfile,
    updateUserProfile,
    getAllUsers,
    deletedUser

}