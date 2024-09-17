// Create web server
// Load express module
var express = require('express');
var app = express();
var fs = require('fs');
var bodyParser = require('body-parser');
var urlencodedParser = bodyParser.urlencoded({ extended: false });

// Use static files
app.use(express.static('public'));

// Load index.html file
app.get('/', function (req, res) {
    res.sendFile(__dirname + "/" + "index.html");
})