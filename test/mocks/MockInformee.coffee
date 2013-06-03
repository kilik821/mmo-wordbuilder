Module = require "#{process.cwd()}/.app/components/Module"
Informee = require "#{process.cwd()}/.app/components/Informee"
_ = require "underscore"

class MockInformee extends Module
  @include new Informee

  constructor: ->
    @data = []

  recieve: ->
    @data = arguments

  hasData: ->
    _.isEqual @data, arguments

module.exports = MockInformee

