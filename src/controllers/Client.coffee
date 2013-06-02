Module = require '../components/Module'
Player = require './Player'

class Client extends Module
  constructor: (@socket) ->

  login: (data) ->
    @socket.emit 'successful_login', data

    # Load player info from database
    playerInfo =
      username: "bob"
      x: Math.floor(Math.random() * (10 - 2)) + 1
      y: Math.floor(Math.random() * (10 - 2)) + 1
    @player = new Player(playerInfo, this)
    @player.setupActions @socket
    @player.addInterest this

    @player.sendInfo @socket

    @socket.emit 'world_info',
      t: Date.now()

  destroy: ->


module.exports = Client