Informer = require "#{process.cwd()}/.app/components/Informer"
MockClient = require "../mocks/MockClient"

describe 'Informer', ->

  informer = null
  c1 = null
  testData = {}

  beforeEach ->
    informer = new Informer
    c1 = new mockClient

  describe 'should inform interested parties', ->
    it 'given an interested party', ->
      informer.addInterest(c1)
