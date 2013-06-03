class Informee

  informers: []

  constructor: ({informers} = {})->
    @informers = informers ? @informers.slice(0)

  # Meant to be overridden by specific informers (sockets, objects, etc.)
  send: () ->

  inform: (informer) ->
    unless informer in @informers
      @informers.push informer
    unless informer.informs(this)
      informer.inform this
    this

  informedBy: (informer) ->
#    console.log "I am "
#    console.log this
#    console.log "Informer is #{informer.informers}"
    informer in @informers


module.exports = Informee