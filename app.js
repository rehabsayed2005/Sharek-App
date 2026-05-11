const express = require('express');
const app = express();
const userRouter = require('./routes/userRoutes');
const productRouter = require('./routes/productRoutes');
const orderRouter = require('./routes/orderRoutes');

app.use(express.json());
app.use(userRouter);
app.use(productRouter);
app.use(orderRouter);


module.exports = app;











