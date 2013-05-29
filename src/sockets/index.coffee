#### Socket functions

# Chat handles all chat communications
# Game handles basic game actions like attacks, movement...
namespaces = ['chat','game']

module.exports = (io) ->
  # Authorization
  io.configure ->
    io.set 'authorization', (handshakeData, cb) ->
      # TODO: Add authorization procedure
      cb null, true

  for namespace in namespaces
    ns = io.of('/' + namespace).on 'connection', (socket) ->
      for name, handler of require('./' + namespace)(socket, chat)
        socket.on name, handler
