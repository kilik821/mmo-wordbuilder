Player = require "#{process.cwd()}/.app/controllers/Player"
GameObject = require "#{process.cwd()}/.app/components/GameObject"
Informer = require "#{process.cwd()}/.app/components/Informer"

describe 'Player', ->

  player = null
  playerData = {}

  testData =
    name: 'Billy bob'
    position:
      x: 5
      y: 10

  beforeEach ->
    player = new Player(playerData)

  describe 'name', ->
    it 'should be empty by default', ->
      player = new Player()
      player.name().should.equal ''

    describe 'call to name', ->
      it 'with one argument should set the name', ->
        player.name(testData.name)
        player.name().should.equal testData.name

      it 'with no arguments should return a string', ->
        player.name().should.be.a 'string'

  it 'should implement GameObject', ->
    o = new GameObject()
    for prop of o
      if o.hasOwnProperty prop and prop not in ['included','extended']
        player.should.have.property prop

  it 'should implement Informer', ->
    i = new Informer
    for prop of i
      if i.hasOwnProperty(prop) and prop not in ['included', 'extended']
        player.should.have.property prop