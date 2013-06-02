Module = require "../components/Module"

class World extends Module


  constructor: (redis) ->
    # Generate a new world if one doesn't exist
    # Else load it from the redis store
    @tiles = new Array(20)
    for tile, i in @tiles
      @tiles[i] = new Array(20)
      for subTile, j in @tiles[i]
        @tiles[i][j] = {traversable: true}

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

module.exports = new World