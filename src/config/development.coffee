exports.DEBUG_LOG = true
exports.DEGUG_WARN = true
exports.DEBUG_CLIENT = true
exports.DEBUG_ERROR = true

db = 
  host: 'localhost'
  port: ''
  name: 'mmo-dev'
  user: ''
  pass: ''

dbString = "mongodb://#{if db.user and db.pass then db.user + ':' + db.pass + '@' else ''}#{db.host}#{if db.port then ':' + db.port else ''}/#{db.name ? ''}"
exports.db = dbString