World = require "#{process.cwd()}/.app/controllers/World"
Tile = require "#{process.cwd()}/.app/controllers/Tile"

describe 'World', ->
  world = null
  testData =
    width: 40
    height: 40


  beforeEach ->
    world = new World(testData)

  describe 'size', ->
    it 'should be 1,1 by default', ->
      world = new World()
      world.size().should.eql {width: 1, height: 1}

    describe 'call to size', ->
      describe 'with object argument', ->
        it 'with width and height should set', ->
          world = new World()
          world.size().should.not.eql {width: testData.width, height: testData.height}
          world.size(testData)
          world.size().should.eql {width: testData.width, height: testData.height}

        it 'with only width should set only width', ->
          world = new World()
          world.size().width.should.equal 1
          world.size().height.should.equal 1
          world.size({width: testData.width})
          world.size().width.should.equal testData.width
          world.size().height.should.equal 1

        it 'with only height should set only height', ->
          world = new World()
          world.size().width.should.equal 1
          world.size().height.should.equal 1
          world.size({height: testData.height})
          world.size().height.should.equal testData.height
          world.size().width.should.equal 1

        it 'with no params should treat like empty assignment', ->
          world = new World()
          world.size().width.should.equal 1
          world.size().height.should.equal 1
          world.size({}).should.be.an.instanceof World
          world.size().height.should.equal 1
          world.size().width.should.equal 1

      it 'with multiple params should set width and height', ->
        world = new World()
        world.size().width.should.equal 1
        world.size().height.should.equal 1
        world.size(testData.width, testData.height)
        world.size().should.eql {width: testData.width, height: testData.height}

      it 'with no params should return an object with width and height', ->
        world = new World()
        world.size().should.have.property 'width'
        world.size().should.have.property 'height'

  describe 'tiles', ->
    describe 'call to tiles', ->
      it 'with no arguments should return 2 dimensional array of tiles', ->
        tiles = world.tiles()
        tiles.should.be.an.instanceof Array
        tiles[0].should.be.an.instanceof Array

    describe 'when initializing', ->
      it 'should be set by two dimensional tiles option in constructor', ->
        tiles = [[{},{}],[{},{}]]
        world = new World {tiles: tiles}
        world.tiles().should.eql tiles

      it 'should be set by one dimensional array of tiles with positions'

      it 'should generate default tiles given width and height option', ->
        tiles = world.tiles()
        tiles.length.should.equal testData.width
        for column, i in tiles
          column.length.should.equal testData.height
          for tile, i in column
            tile.should.be.an.instanceof Tile

      it.only 'should assign positions to tiles', ->
        for column, x in world.tiles()
          for tile, y in column
            tile.position().x.should.equal x
            tile.position().y.should.equal y

    describe 'call to tile', ->
#      it 'with two number parameters should return that tile', ->
#        world.tile(testData.width/2 , testData.height/2).should.be.an.instanceof Tile
#        world.tile(testData.width, testData.height).should.not.exist
