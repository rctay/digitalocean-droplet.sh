#!/usr/bin/env node

// Reads JSON from stdin and writes equivalent
// nicely-formatted JSON to stdout.

var inputChunks = [];

process.stdin.resume();
process.stdin.setEncoding('utf8');

process.stdin.on('data', function (chunk) {
    inputChunks.push(chunk);
});

process.stdin.on('end', function () {
    var inputJSON = inputChunks.join(),
        outputJSON = JSON.parse(inputJSON);
    process.stdout.write(JSON.stringify(outputJSON, null, '  '));
    process.stdout.write('\n');
});
