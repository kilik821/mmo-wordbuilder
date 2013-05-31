#### Socket functions

# Chat handles all chat communications
# Game handles basic game actions like attacks, movement...
Client = require "./Client"

module.exports = (io) ->

  io.sockets.on 'connection', (socket) ->
    client = new Client(socket)
    socket.emit 'login'
    socket.on 'login', (data) ->
      client.login data
#    socket.on 'player_movement', (message) ->
#      console.log message
    socket.on 'disconnect', () ->