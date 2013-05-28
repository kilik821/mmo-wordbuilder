exports.DEBUG_LOG = false
exports.DEGUG_WARN = false
exports.DEBUG_CLIENT = false
exports.DEBUG_ERROR = true

db = 
  host: ''
  port: ''
  name: ''
  user: ''
  pass: ''

exports.db = "mongodb://#{db.user}:#{db.pass}@#{db.host}:#{db.port}/#{db.name}"
