const mongoose = require('mongoose');


const url = 'mongodb://127.0.0.1:27017/Sharek_App';
const connectDb = () => {
    mongoose.connect(url).then(() => {
        console.log('Connected successfully to Sharek_App.DB');
    })
    .catch((err) => {
        console.log({ message: err.message });
    });
}
module.exports = connectDb;