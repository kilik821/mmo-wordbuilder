var app, port, express, io;

app = require('./.app');
express = app.express
io = app.io;
port = app.port;
app.listen(port, function() {
  return console.log("Express server listening on " + port + "\nPress Ctrl-C to stop server");
});

io.listen(app, function() {
  return console.log("Socket.io server listening on " + port);
});