console.log('hi');


const port = 5000;
const hostName = '0.0.0.0';
const DB = "mongodb+srv://mahendhraa:123454321@cluster0.b5s21.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";


const express = require('express');
const app = express();

app.get("/hello", (req, res) => {
    res.send('hello');
});

const hellowRoute = require('./routes/hellowroute')
app.use(hellowRoute);
app.listen(port, hostName, function () {
    console.log(`server running on host: ${hostName} port: ${port}`);
});


const mongoose = require('mongoose');
mongoose.connect(DB).then(() => {
    console.log('Mongo db connected');
}).catch((reason) => {
    console.log(`mongo db error: ${reason}`);
});