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

  constructor: (playerInfo) ->
    @username = playerInfo.username ? ''
    @id = playerInfo.id ? @getId()
    @position(playerInfo.x ? 1, playerInfo.y ? 1)
    @movementSpeed = playerInfo.movementSpeed ? 2 # In tiles / second
    @lastMove = playerInfo.lastMove ? 0

  sendInfo: (socket) ->
    socket.emit 'player_information', @playerInfo()

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
        next = true
        unless moved
          switch info.reason
            when "too fast"
              setTimeout self.movePlayer(repeat), info.dt
              next = false
              break
            else
        if moved
          self.broadcastToInterested 'player_movement',
            id: self.id
            x: self.x
            y: self.y
            t: Date.now()
        if next
          self.movementQueue.shift()
          self.movePlayer true if repeat
          return

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