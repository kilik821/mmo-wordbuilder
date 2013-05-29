module.exports = (socket, chat) ->
  {
    "send message": (data) ->
      socket.get 'user', (err, user) ->
        unless err?
          chat.in(data.r).emit 'send message', {u: user.name, m: data.m}
        else socket.emit 'error', err
    
    join: (data) ->
      socket.join data.r
    
    leave: (data) ->
      socket.leave data.r
  }