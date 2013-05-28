exports.DEBUG_LOG = true
exports.DEGUG_WARN = true
exports.DEBUG_CLIENT = true
exports.DEBUG_ERROR = true

db = 
  host: ''
  port: ''
  name: ''
  user: ''
  pass: ''

exports.db = "mongodb://#{db.user}:#{db.pass}@#{db.host}:#{db.port}/#{db.name}"
