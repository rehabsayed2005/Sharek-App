const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');



const userSchema = new mongoose.Schema({

    name: {
        type: String,
        required: true
    },

    email: {
        type: String,
        required: true,
        unique: true,
        match: [
            /^[a-zA-Z0-9._%+-]+@gmail\.com$/,
            'Email must be a valid Gmail address'
        ]
    },

    password: {
        type: String,
        required: true
    },

    phone: {
        type: String,
        required: true,
        minLength:[11, 'phone is too short, please enter 11 numbers']
    },

    gender: {
        type: String,
        required: true,
        enum: ['male', 'female']
    },

    address: {
        type: String,
        required: true,
        minLength: [5, 'Address is too short, please provide more details']
    },

    isadmin: {
        type: Boolean,
        default: false
    },

    createdAt: {
        type: Date,
        default: Date.now
    }

});
userSchema.pre('save', async function () {

    if (!this.isModified('password')) {
        return ;
    }

    const salt = await bcrypt.genSalt(10);

    this.password = await bcrypt.hash(this.password, salt);
});

userSchema.methods.comparePassword = async function (enteredPassword) {
    return await bcrypt.compare(enteredPassword, this.password);
};

const User = mongoose.model('User', userSchema);



const generateToken = (id) => {

    return jwt.sign(
        { id },
        'secretkey',
        { expiresIn: '30d' }
    );
};




module.exports = { User, generateToken};