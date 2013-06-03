Informer = require "#{process.cwd()}/.app/components/Informer"
Informee = require "#{process.cwd()}/.app/components/Informee"

describe 'Informer', ->

  informer = null
  informees = []
  testData = {}

  beforeEach ->
    informer = new Informer()
    informer.name = 'Informer'
    informees = []
    i = new Informee()
    i.name = "Informee0"
    informees.push(i)
    i = new Informee()
    i.name = "Informee1"
    informees.push(i)
    i = new Informee()
    i.name = "Informee2"
    informees.push(i)
    i = new Informee()
    i.name = "Informee3"
    informees.push(i)
#    informees.push(new Informee())
#    informees.push(new Informee())
#    informees.push(new Informee())

  describe 'should inform interested parties', ->
    it 'given an party', ->
      informer.inform informees[0]
      informer.informs(informees[0]).should.be.true
      informees[0].informedBy(informer).should.be.true

    it 'given an array of parties', ->
      informer.inform informees
      for informee in informees
        informer.informs(informee).should.be.true
        informee.informedBy(informer).should.be.true

  describe 'should not inform uninterested parties', ->
    it 'given a party', ->
      informer.inform(informees[0])
      informer.informs(informees[1]).should.be.false
      informees[1].informedBy(informer).should.be.false

    it 'given an array of parties', ->
      informing = informees[0..2]
      informer.inform informing
      for informee in informees
        if informee in informing
          informer.informs(informee).should.be.true
          informee.informedBy(informer).should.be.true
        else
          informer.informs(informee).should.be.false
          informee.informedBy(informer).should.be.false
