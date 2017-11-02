#!/usr/bin/env node

// Reads JSON from stdin, and runs a JSONPath expression from the command-line on it.
//
// eg.
//    $ npm install # install dependencies
//    $ echo '{"store": {"book":[{"category":"fiction"}]}}' | node jsonpath.js '$.store.book[0].category'
//    fiction

var stdin = process.stdin,
    stdout = process.stdout,
    inputChunks = [];

var jsonPath = require('JSONPath');

stdin.resume();
stdin.setEncoding('utf8');

stdin.on('data', function (chunk) {
    inputChunks.push(chunk);
});

stdin.on('end', function () {
    var inputJSON = inputChunks.join(),
        parsedData = JSON.parse(inputJSON);
    var result = jsonPath.eval(parsedData, process.argv[2], {wrap: false})
    stdout.write(result.toString()); // could be a number
    stdout.write('\n');
});
