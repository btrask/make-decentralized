#!/usr/bin/env node

var fs = require("fs");

var prism = require("prismjs");
require("./node_modules/prismjs/components/prism-makefile");

if(process.argv.length <= 2) {
	console.error("Usage: generate-html.js path");
	process.exit(1);
}
var path = process.argv[2];
var str = fs.readFileSync(path, "utf8");

var output = prism.highlight(str, prism.languages.makefile);
process.stdout.write("<code><pre>"+output+"</pre></code>", "utf8");

