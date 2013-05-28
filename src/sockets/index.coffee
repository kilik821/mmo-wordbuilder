#### Socket functions
# 

module.exports = (io) ->
  # Chat handles all chat communications
  chat = io.of('/chat').on 'connection', (socket) ->
    for name, handler of require('./chat')(socket, chat)
      socket.on name, handler
    loginSetup socket
  
  # Game handles basic game actions like attacks, movement...
  game = io.of('/game').on 'connection', (socket) ->
    for name, handler of require('./game')(socket, game)
      socket.on name, handler
    loginSetup socket
      
loginSetup = (socket) ->
  socket.emit 'login'
  socket.on 'login', login (err, user) ->
    unless err?
      socket.set 'user', user ->
        socket.emit 'logged in'
    else
      socket.emit 'failed login', err

login = (cb) ->
  # TODO: Add login functionality
  (user, pass) ->
    cb new Error('You suck at this')