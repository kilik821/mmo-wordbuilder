Player = require "#{process.cwd()}/.app/controllers/Player"

describe 'Player', ->

  p = null
  playerData = {}

  testData =
    name: 'Billy bob'
    position:
      x: 5
      y: 10

  beforeEach ->
    p = new Player(playerData)

  it 'should set the name', ->
    p.name(testData.name)
    p.name().should.equal testData.name

  it 'should set the position', ->
    p.position(testData.position)
    p.position().x.should.equal testData.position.x
    p.position().y.should.equal testData.position.y

#  it 'should ', ->