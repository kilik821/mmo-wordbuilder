module.exports = (socket, chat) ->
  {
    message: (room, message) ->
      socket.get 'user', (err, user) ->
        unless err?
          chat.in(room).emit 'message', user.name, message
        else socket.emit 'error', err
    
    join: (room) ->
      socket.join room
    
    leave: (room) ->
      socket.leave room
  }