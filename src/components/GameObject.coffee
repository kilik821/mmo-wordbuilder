IdProvider = require "../helpers/IdProvider"

class GameObject

  getId: ->
    IdProvider.getNextId()

  position: (x, y) ->
    if x? and y?
      @x = x
      @y = y
      this
    else
      {x: @x, y: @y}

module.exports = GameObject