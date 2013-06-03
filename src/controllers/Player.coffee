Informer = require "../components/Informer"
Module = require "../components/Module"
GameObject = require "../components/GameObject"

World = require "./World"

helpers = require "../helpers"


class Player extends Module
  @include new Informer
  @include new GameObject

  setupActions: (socket) ->
    actions =
      player_movement: @player_movement
    for action, handler of actions
      socket.on action, handler

  movementQueue: []

  constructor: (playerInfo, @client) ->
    @username = playerInfo.username ? ''
    @id = playerInfo.id ? @retrieveId()
    @position(playerInfo.x ? 0, playerInfo.y ? 0)
    @movementSpeed = playerInfo.movementSpeed ? 2 # In tiles / second
    @lastMove = playerInfo.lastMove ? 0

  name: (nameArg) =>
    if nameArg
      @_name = nameArg
      this
    else
      @_name

  sendInfo: () ->
    @broadcastToInterested 'player_information', @playerInfo()

  playerInfo: ->
    obj = {}
    obj.id = @id if @id?
    obj.username = @username if @username?
    obj.x = @x if @x?
    obj.y = @y if @y?
    obj.ms = @movementSpeed
    obj

  movePlayer: (repeat = true) =>
    self = @
    if @movementQueue.length
      moveRequest = @movementQueue[0]
      World.move this, moveRequest, (moved, info) ->
        unless moved
          switch info.reason
            when "too fast"
              console.log "Too fast, waiting: #{info.dt} millis"
              setTimeout (() ->
                self.movePlayer(repeat)
              ), info.dt
              return
            else
              console.log "Movement failed: #{info.reason}"
        if moved
          self.broadcast 'player_movement',
            id: self.id
            x: self.x
            y: self.y
            t: Date.now()
        self.movementQueue.shift()
        self.movePlayer true if repeat

  queueMovement: (moveRequest, doMovement = true) =>
    if @movementQueue.length
      for movement, i in @movementQueue
        if movement.time > moveRequest.time
          @movementQueue.splice i, 0, moveRequest
    else
      @movementQueue.push moveRequest
    if doMovement
      @movePlayer true
    this

  player_movement: (data) =>
    @queueMovement
      time: data.t
      x: data.x
      y: data.y



  @prefix: "player"

module.exports = Player