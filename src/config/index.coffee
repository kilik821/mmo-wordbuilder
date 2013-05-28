prod = require "./production"
dev = require "./development"
test = require "./testing"

exports.setEnvironment = (env) ->
  console.log "Setting app environment: #{env}"
  switch env
    when 'production'
      exports.settings = prod
    when 'development'
      exports.settings = dev
    when 'testing'
      exports.settings = test
    else
      console.log "Environment #{env} not found"