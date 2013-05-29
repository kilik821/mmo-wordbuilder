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

dbString = "mongodb://#{if db.user and db.pass then db.user + ':' + db.pass + '@' else ''}#{db.host}#{if db.port then ':' + db.port else ''}/#{db.name ? ''}"
exports.db = dbString