#!/usr/bin/env node

var fs = require("fs");

var prism = require("prismjs");
require("./node_modules/prismjs/components/prism-makefile");

if(process.argv.length <= 4) {
	console.error("Usage: generate-html.js head body tail");
	process.exit(1);
}
var head = fs.readFileSync(process.argv[2], "utf8");
var body = fs.readFileSync(process.argv[3], "utf8");
var tail = fs.readFileSync(process.argv[4], "utf8");

var output = prism.highlight(body, prism.languages.makefile);
process.stdout.write(head+"<pre class='line-numbers'><code>"+output+"</code></pre>"+tail, "utf8");

