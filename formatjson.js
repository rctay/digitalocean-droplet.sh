#!/usr/bin/env node

// Reads JSON from stdin and writes equivalent
// nicely-formatted JSON to stdout.

var fs = require('fs');

process.stdin.resume();
process.stdin.setEncoding('utf8');

var inputChunks = [];

process.stdin.on('data', function (chunk) {
    inputChunks.push(chunk);
});

process.stdin.on('end', function () {
    var inputJSON = inputChunks.join(),
        outputJSON = JSON.parse(inputJSON);
    console.log(JSON.stringify(outputJSON, null, '  '));
});
