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

  describe 'should move to position', ->
    it "given data object", (done) ->
      gameObject.position(testData)
      result = gameObject.position()
      result["x"].should.equal testData.x
      result["y"].should.equal testData.y
      done()

    it "given x and y", (done) ->
      gameObject.position(testData.x, testData.y)
      result = gameObject.position()
      result["x"].should.equal testData.x
      result["y"].should.equal testData.y
      done()

  describe 'when retriving IDs from a provider', ->
    it 'should set its id', ->
      gameObject.retrieveId(new MockIdProvider(testData.id))
      gameObject.id().should.equal testData.id

    it 'should not care about duplicates', ->
      gameObject.retrieveId(new MockIdProvider(testData.id))
      gameObject1.retrieveId(new MockIdProvider(testData.id))
      gameObject.id().should.equal testData.id
      gameObject1.id().should.equal testData.id

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
