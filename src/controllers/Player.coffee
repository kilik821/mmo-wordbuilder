Informer = require "../components/Informer"
Module = require "../components/Module"
GameObject = require "../components/GameObject"

World = require "./World"

helpers = require "../helpers"


class Player extends Module
  @include new Informer
  @include new GameObject

  name: (name) ->
    if name?
      if typeof name is 'string'
        @_name = name
      else if name.name?
        @_name = name.name
      this
    else
      @_name

  setupActions: (socket) ->
    actions =
      player_movement: @player_movement
    for action, handler of actions
      socket.on action, handler

  movementQueue: []

  constructor: (options = {}) ->
    @name options.name ? ''
    @username = options.username ? ''
    @position(options.x ? 0, options.y ? 0)
    @movementSpeed = options.movementSpeed ? 2 # In tiles / second
    @lastMove = options.lastMove ? 0

  sendInfo: () ->
    @broadcastToInterested 'player_information', @playerInfo()

  playerInfo: ->
    obj = {}
    obj.id = @_id if @_id?
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