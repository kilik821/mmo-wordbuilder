IdProvider = require "../helpers/IdProvider"

class GameObject

  getId: ->
    IdProvider.getNextId()

  position: (x, y) ->
    if x?
      if y?
        @x = x
        @y = y
        this
      else if x.x? and x.y?
        @x = x.x
        @y = x.y
        this
    else
      {x: @x, y: @y}

module.exports = GameObject