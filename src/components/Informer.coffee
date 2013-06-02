class Informer

  interestedClients: []

  broadcastToInterested: (message, data) ->
    for client in @interestedClients
      client.socket.emit message, data

  addInterest: (client) ->
    unless client in @interestedClients
      @interestedClients.push client
    this

  removeInterest: (client) ->
    _ref = @interestedClients
    until (index = _ref.indexOf client) < 0
      _ref.splice index, 1
    this

module.exports = Informer