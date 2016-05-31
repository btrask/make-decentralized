#!/usr/bin/env node

var fs = require("fs");

var prism = require("prismjs");
require("./node_modules/prismjs/components/prism-makefile");

if(process.argv.length <= 2) {
	console.log("Usage: generate-html.js path");
	process.exit(1);
}
var path = process.argv[2];
var str = fs.readFileSync(path, "utf8");

var head =
	'<!doctype html>\n'+
	'<meta charset="utf-8">\n'+
	'<title>make decentralized</title>\n'+
	'<style>\n'+
	'body { background: #fff; color: #000; }\n'+
	'pre { font-family: "Monaco", "Melno", monospace; }\n'+
	'.comment { color: #444; }\n'+
	'.symbol { font-weight: 600; }\n'+
//	'.deps { font-style: italic; }\n'+
	'</style>\n'+
	'<code><pre>\n';
var tail =
	'</pre></code>';

process.stdout.write(head, "utf8");

var output = prism.highlight(str, prism.languages.makefile);
process.stdout.write(output, "utf8");

process.stdout.write(tail, "utf8");

