Module = require '../components/Module'
Player = require './Player'

class Client extends Module
  constructor: (@socket) ->

  login: (data) ->
    @socket.emit 'successful_login', data

    # Load player info from database
    playerInfo = {username: "bob"}
    @player = new Player(playerInfo)
    @player.setupActions @socket
    @player.addInterest @socket

    @player.sendInfo @socket

#    player = @player
#    @socket.on 'player_movement', (message) ->
#      player.player_movement message

  destroy: ->


module.exports = Client