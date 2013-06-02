GameObject = require "#{process.cwd()}/.app/components/GameObject"

describe 'GameObject', ->

  gameObject = null

  beforeEach ->
    gameObject = new GameObject

  testData =
    x: 5
    y: 10

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
