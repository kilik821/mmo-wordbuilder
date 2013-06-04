IdProvider = require "../helpers/IdProvider"

class GameObject

  @_id: null

  included: (provider) ->
    @::id provider

  retrieveId: (provider = IdProvider, override = true) ->
    if override
      @_id = provider.nextId()
    else
      @_id ?= provider.nextId()
    this

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

  x: (x) ->
    if x?
      @_x = x
      this
    else
      @_x

  y: (y) ->
    if y?
      @_y = y
      this
    else
      @_y


  position: (x, y) ->
    if x?
      if y?
        @_x = x
        @_y = y
        this
      else if x.x? and x.y?
        @_x = x.x
        @_y = x.y
        this
    else
      {x: @_x, y: @_y}

module.exports = GameObject