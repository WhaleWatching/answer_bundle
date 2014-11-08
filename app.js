var ws = require('nodejs-websocket')

// Scream server example: 'hi' -> 'HI!!!'
var server = ws.createServer(function (conn) {
    console.log('New connection');
    conn.on('text', function (str) {
        console.log('Received '+str);
        conn.sendText('I got [' + str + '] just a well, thanks.');
    });
    conn.on('close', function (code, reason) {
        console.log('Connection closed');
    });
}).listen(8085);

console.log('websocket server listening on 8085');


var express = require('express');
var app = express();
var router = express.Router();
var http = require('http');

var wwwroot = './prod/bundle/';

app.use(express.static(wwwroot));

console.log('express on localhost:8080');
app.listen(8080);