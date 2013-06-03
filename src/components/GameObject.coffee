IdProvider = require "../helpers/IdProvider"

class GameObject

  @_id: null

  retrieveId: (provider = IdProvider, override = false) ->
    if override
      @_id = provider.nextId()
    else
      @_id ?= provider.nextId()

  id: (provider) ->
    if provider?
      if typeof provider is 'number'
        @_id = provider
        this
      else
        @retrieveId provider, true
        this
    else
      @_id


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