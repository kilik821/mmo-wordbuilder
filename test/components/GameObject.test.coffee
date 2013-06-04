GameObject = require "#{process.cwd()}/.app/components/GameObject"

describe 'GameObject', ->

  gameObject = null
  gameObject1 = null

  beforeEach ->
    gameObject = new GameObject
    gameObject1 = new GameObject

  testData =
    x: 5
    y: 10
    id: 5

  describe 'should set position', ->
    describe "call to position", ->
      it "given data object", ->
        gameObject.position(testData)
        gameObject.position().should.eql {x: testData.x, y: testData.y}

      it "given x and y", ->
        gameObject.position(testData.x, testData.y)
        gameObject.position().should.eql {x: testData.x, y: testData.y}

    describe "call to x", ->
      it "given number", ->
        gameObject.x(testData.x).x().should.equal testData.x

    describe "call to y", ->
      it "given number", ->
        gameObject.y(testData.y).y().should.equal testData.y

  describe 'when retriving IDs', ->
    describe 'from a provider', ->
      it 'should set its id', ->
        gameObject.retrieveId(new MockIdProvider(testData.id))
        gameObject.id().should.equal testData.id

      it 'should not care about duplicates', ->
        gameObject.retrieveId(new MockIdProvider(testData.id))
        gameObject1.retrieveId(new MockIdProvider(testData.id))
        gameObject.id().should.equal testData.id
        gameObject1.id().should.equal testData.id

    describe 'default provider', ->
      it 'should not give duplicates', ->
        gameObject.retrieveId().id().should.not.equal gameObject.retrieveId().id()

  describe 'when manually setting IDs', ->
    describe 'should set its id', ->
      it 'from a provider', ->
        gameObject.id(new MockIdProvider(testData.id)).id().should.equal testData.id

      it 'from a number', ->
        gameObject.id(testData.id).id().should.equal testData.id

class MockIdProvider

  @currentId: 0

  constructor: (id = MockIdProvider.currentId++) ->
    @currentId = id

  nextId: (id = @currentId++) ->
    id
