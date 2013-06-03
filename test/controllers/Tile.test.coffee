Tile = require "#{process.cwd()}/.app/controllers/Tile"
Informer = require "#{process.cwd()}/.app/components/Informer"

describe "Tile", ->

  tile = null

  testData =
    traversable: false
    x: 5
    y: 60
    position:
      x: 10
      y: 20
    type: 'grass'

  beforeEach ->
    tile = new Tile(testData)

  describe 'traversable', ->
    it 'should be true by default', ->
      tile = new Tile()
      tile.traversable().should.be.true
    it 'should set from initial arguments', ->
      tile.traversable().should.equal testData.traversable

    describe 'call to traversable', ->
      it 'with argument should set', ->
        tile.traversable(!testData.traversable).traversable().should.equal !testData.traversable
      it 'with no argument should return boolean', ->
        tile.traversable().should.be.a('boolean')

  describe 'position', ->
    it 'should be 0,0 by default', ->
      tile = new Tile()
      tile.position().x.should.equal 0
      tile.position().y.should.equal 0
    describe 'should set', ->
      it 'from initial arguments of x and y', ->
        tile.position().x.should.equal testData.x
        tile.position().y.should.equal testData.y
      it 'from initial arguments of position', ->
        tile = new Tile({position: testData.position})
        tile.position().x.should.equal testData.position.x
        tile.position().y.should.equal testData.position.y
    describe 'call to position', ->
      it 'with two arguments should set', ->
        x = testData.x + 5
        y = testData.y + 5
        tile.position(x, y)
        tile.position().x.should.equal x
        tile.position().y.should.equal y
#        p.x.should.equal x
#        p.y.should.equal y
      it 'with one argument of type object should set', ->
        arg = {x: testData.x + 3, y: testData.y + 6}
        p = tile.position(arg).position()
        p.x.should.equal arg.x
        p.y.should.equal arg.y
      it 'with no arguments should return object with x and y', ->
        p = tile.position()
        p.should.be.a 'object'
        p.x.should.be.a 'number'
        p.y.should.be.a 'number'

  describe 'type', ->
    it 'should be empty by default', ->
      tile = new Tile()
      tile.type().should.equal ''

    it 'should set from initial arguments', ->
        tile.type().should.equal testData.type

    describe 'call to type', ->
      it 'should return string', ->
        tile.type().should.be.a 'string'
      it 'with one argument should set', ->
        type = 'lava'
        tile.type(type).type().should.equal type

  it 'should implement Informer', ->
    i = new Informer
    for prop of i
      if i.hasOwnProperty prop
        tile.should.have.property prop
