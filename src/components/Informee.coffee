class Informee

  informers: []

  constructor: (options = {})->
    @informers = options.informers ? []

  # Meant to be overridden by specific informers (sockets, objects, etc.)
  recieve: () ->

  informFrom: (informer) ->
    if toString.apply(informer) is '[object Array]'
      for i in informer
        @informFrom i
    else
      unless informer in @informers
        @informers = @informers.slice 0
        @informers.push informer
      unless informer.informs(this)
        informer.inform this
    this

  informedBy: (informer) ->
    informer in @informers

  uninformFrom: (informer) ->
    if toString.apply(informer) is '[object Array]'
      for i in informer
        @uninformFrom i
    else
      while (index = @informers.indexOf(informer)) > -1
        @informers.splice index, 1
      if informer.informs(this)
        informer.uninform this
    this


module.exports = Informee