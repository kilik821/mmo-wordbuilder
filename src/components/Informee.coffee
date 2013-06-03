class Informee

  informers: []

  constructor: ({informers} = {})->
    @informers = informers ? @informers.slice(0)

  # Meant to be overridden by specific informers (sockets, objects, etc.)
  send: () ->

  informFrom: (informer) ->
    unless informer in @informers
      @informers.push informer
    unless informer.informs(this)
      informer.inform this
    this

  informedBy: (informer) ->
    informer in @informers

  uninformFrom: (informer) ->
    while (index = @informers.indexOf(informer)) > -1
      @informers.splice index, 1
    if informer.informs(this)
      informer.uninform this
    this


module.exports = Informee