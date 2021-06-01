const express = require('express');
const config = require('./config');
const cors = require('cors');
const mongoose = require('mongoose');

const listingRouter = require('./api/listing');
const userRouter = require('./api/user');
const bidRouter = require('./api/bid');

const server = express();

server.use(cors());
server.use(express.json());
server.use(express.urlencoded({ extended: true }));
server.use('/uploads', express.static('uploads'));

server.use('/listing', listingRouter);
server.use('/user', userRouter);
server.use('/bid', bidRouter);

mongoose.connect(config.databaseUrl, {
    useNewUrlParser: true,
    useUnifiedTopology: true }).then(() => {
  console.log('Connected to MongoDB database');
});

server.listen(config.PORT, () => {
    console.log('Server started on port ' + config.PORT);
});
