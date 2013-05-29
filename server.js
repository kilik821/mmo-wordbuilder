var app, port, express, io,
    http = require('http');

server = require('./.app');
port = server.port;

server.listen(port, function() {
  return console.log("Express server listening on " + port + "\nPress Ctrl-C to stop server");
});
