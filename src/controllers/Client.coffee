Module = require './Module'

class Client extends Module
  constructor: (@socket) ->

  login: (data) ->
    @socket.emit 'successful login', data

  destroy: ->


module.exports = Client