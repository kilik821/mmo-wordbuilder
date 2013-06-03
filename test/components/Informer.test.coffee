Informer = require "#{process.cwd()}/.app/components/Informer"
Informee = require "#{process.cwd()}/.app/components/Informee"

describe 'Informer', ->

  informer = null
  informees = []

  beforeEach ->
    informer = new Informer()
    informees = []
    informees.push(new Informee())
    informees.push(new Informee())
    informees.push(new Informee())
    informees.push(new Informee())

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
      informing = informees[0..1]
      informer.inform informing
      for informee in informees
        if informee in informing
          informer.informs(informee).should.be.true
          informee.informedBy(informer).should.be.true
        else
          informer.informs(informee).should.be.false
          informee.informedBy(informer).should.be.false

  describe 'when uninforming parties', ->
    informing = []
    notInforming = []
    beforeEach ->
      informing = informees[0..1]
      notInforming = informees[2..]
      informer.inform informing
    describe 'given a party', ->
      it 'that it informs it should uninform them', ->
        informer.informs(informing[0]).should.be.true
        informing[0].informedBy(informer).should.be.true
        informer.uninform(informing[0])
        informer.informs(informing[0]).should.be.false
        informing[0].informedBy(informer).should.be.false

      it 'that is does not inform should not error', ->
        informer.informs(notInforming[0]).should.be.false
        notInforming[0].informedBy(informer).should.be.false
        informer.uninform(notInforming[0])
        informer.informs(notInforming[0]).should.be.false
        notInforming[0].informedBy(informer).should.be.false

    describe 'given an array of parties', ->
      it 'that it informs it should uninform them', ->
        for informee in informing
          informer.informs(informee).should.be.true
          informee.informedBy(informer).should.be.true
        informer.uninform(informing)
        for informee in informing
          informer.informs(informee).should.be.false
          informee.informedBy(informer).should.be.false

      it 'that is does not inform should not error', ->
        for informee in notInforming
          informer.informs(informee).should.be.false
          informee.informedBy(informer).should.be.false
        informer.uninform(notInforming)
        for informee in notInforming
          informer.informs(informee).should.be.false
          informee.informedBy(informer).should.be.false

