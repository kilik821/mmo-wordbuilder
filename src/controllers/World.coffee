Module = require "../components/Module"
Tile = require "./Tile"

class World extends Module

  _width: 1
  _height: 1
  _tiles: [[]]

  constructor: (options = {}) ->
    @size options.width ? @_width, options.height ? @_height
    @tiles options.tiles ? {width: @_width, height: @_height}

  size: (width, height) ->
    if width?
      if height?
        @_width = width
        @_height = height
      else
        @_width = width.width ? @_width
        @_height = width.height ? @_height
      this
    else {width: @_width, height: @_height}

  tiles: (tiles) ->
    if tiles?
      if toString.apply(tiles) is '[object Array]'
        @_tiles = tiles
      else
        t = new Array
        for i in [0...tiles.width]
          col = new Array
          for j in [0...tiles.height]
            col.push new Tile {x: i, y: j}
          t.push col
        @_tiles = t
      this
    else
      @_tiles

  tile: (x, y) ->
    @_tiles[x][y]


  registerPlayer: (player) ->
    @players.push player
    for p1 in @players
      for p2 in @players
        p1.addInterest(p2.client)

  move: (player, moveRequest, cb) ->
    # See if the request time is before the last move time.  Potentially cheating.
    if moveRequest.time < player.lastMove
      console.log "Back in time: #{moveRequest.time}, #{player.lastMove}"
      return cb false, {reason: "back in time"}

    # Make sure the player hasn't moved too recently. If they have, return the time til next move.
    unless ((dt = Math.max (moveRequest.time - player.lastMove), (Date.now() - player.lastMove)) > (1000.0 / player.movementSpeed))
      console.log "Too fast #{dt} passed, ms: #{1000.0 / player.movementSpeed} seconds/tile"
      return cb false, {reason: "too fast", dt: dt}

    # Make sure Manhatten distance is <= 1
    unless (distance = (Math.abs(player.x - moveRequest.x) + Math.abs(player.y - moveRequest.y))) is 1
      console.log "Player: #{player.x}, #{player.y} Move: #{moveRequest.x}, #{moveRequest.y}"
      return cb false, {reason: "too far", distance: distance}

    # Make sure the destination is traversable
    unless @tiles[moveRequest.x][moveRequest.y].traversable
      return cb false, {reason: "not traversible"}

    # Otherwise, the player can move, so do the movement
    player.x = moveRequest.x
    player.y = moveRequest.y

    player.lastMove = Math.min Date.now(), (moveRequest.time + 1000.0 / player.movementSpeed)
    cb true

module.exports = World