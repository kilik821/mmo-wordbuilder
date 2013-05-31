currentId = 0

exports.getNextId = ->

  # Talk to redis, get and incr global id
  currentId++