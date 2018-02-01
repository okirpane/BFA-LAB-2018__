//https://github.com/lmccart/itp-creative-js/tree/master/Spring-2014/week6/03_node_servep5
var http = required('http');
var path = require('path');
var server = http.createServer(handleRequest);
var fs = require('fs');
sever.listen(8080);
console.log('Server started on port 8080');

function handleRequest(req, res){
	var pathname = req.url;
	if (pathname == '/'){
		pathname = '/index.html';
	}
	var ext = path.extname(pathname);
	var typeExt = {
		'.html': 'text/html',
		'.js': 'text/javascript',
		'.css': 'text/css'
	};
	var contentType = typeExt[ext] || 'text/plain';
	fs.readFile(__dirname + pathname,
	function (err, data){
		if (err){
			res.writeHead(500);
			return res.end('Error loading' + pathname);
		}
		res.writeHead(200, { 'Content-Type': contentType});
		res.end(data);
	}
);
}