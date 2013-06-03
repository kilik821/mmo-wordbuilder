currentId = 0

exports.nextId = ->

  # Talk to redis, get and incr global id
  currentId++