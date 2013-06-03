class Informer

  informees: []

  constructor: (options = {})->
    @informees = options.informees ? @informees.slice(0)

  broadcast: () ->
    for informee in @informees
      informee.recieve.apply this, arguments

  # Adds an informee to our list and tells it to add us if it doesn't already
  inform: (informee) ->
    # If informee is an array call this method for each in array
    if toString.apply(informee) is '[object Array]'
      for i in informee
        @inform i
    else
      unless informee in @informees
        @informees.push informee
      unless informee.informedBy(this)
        informee.inform this
    this

  informs: (informee) ->
    informee in @informees

module.exports = Informer