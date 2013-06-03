Informer = require "../components/Informer"
Module = require "../components/Module"

class Tile extends Module
  @include new Informer

  _traversable: null
  _x: null
  _y: null
  _type: null

  constructor: (options = {}) ->
    @_traversable = options.traversable ? Tile.traversable ? true
    @_x = options.x ? options.position?.x ? 0
    @_y = options.y ? options.position?.y ? 0
    @_type = options.type ? ''

  traversable: (traversable) ->
    if traversable?
      @_traversable = traversable
      this
    else
      @_traversable

  position: (x, y) ->
    if x?
      if y?
        @_x = x
        @_y = y
        this
      else
        @_x = x.x
        @_y = x.y
        this
    else
      {x: @_x,y: @_y}

  type: (type) ->
    if type?
      @_type = type
      this
    else
      @_type

module.exports = Tile