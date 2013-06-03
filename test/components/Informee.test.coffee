Informer = require "#{process.cwd()}/.app/components/Informer"
Informee = require "#{process.cwd()}/.app/components/Informee"

describe 'Informee', ->

  informee = null
  informers = []

  beforeEach ->
    informee = new Informee()
    informers = []
    informers.push(new Informer())
    informers.push(new Informer())
    informers.push(new Informer())
    informers.push(new Informer())

  describe 'should inform', ->
    it 'given an informer', ->
      informee.informFrom informers[0]
      informee.informedBy(informers[0]).should.be.true
      informers[0].informs(informee).should.be.true

    it 'given an array of informers', ->
      informee.informFrom informers
      for informer in informers
        informer.informs(informee).should.be.true
        informee.informedBy(informer).should.be.true

  describe 'should not inform others', ->
    it 'given a informer', ->
      informee.informFrom informers[0]
      informee.informedBy(informers[1]).should.be.false
      informers[1].informs(informee).should.be.false

    it 'given an array of informers', ->
      informing = informers[0..1]
      informee.informFrom informing
      for informer in informers
        if informer in informing
          informer.informs(informee).should.be.true
          informee.informedBy(informer).should.be.true
        else
          informer.informs(informee).should.be.false
          informee.informedBy(informer).should.be.false

  describe 'when uninforming from informers', ->
    informing = []
    notInforming = []

    beforeEach ->
      informing = informers[0..1]
      notInforming = informers[2..]
      informee.informFrom informing

    describe 'given an informer', ->
      it 'that it is informed by it should uninform them', ->
        informee.informedBy(informing[0]).should.be.true
        informing[0].informs(informee).should.be.true
        informee.uninformFrom(informing[0])
        informee.informedBy(informing[0]).should.be.false
        informing[0].informs(informee).should.be.false

      it 'that is is not informed by it should not error', ->
        informee.informedBy(notInforming[0]).should.be.false
        notInforming[0].informs(informee).should.be.false
        informee.uninformFrom(notInforming[0])
        informee.informedBy(notInforming[0]).should.be.false
        notInforming[0].informs(informee).should.be.false

    describe 'given an array of informers', ->
      it 'that it is informed by it should uninform from them', ->
        for informer in informing
          informer.informs(informee).should.be.true
          informee.informedBy(informer).should.be.true
        informee.uninformFrom(informing)
        for informer in informing
          informer.informs(informee).should.be.false
          informee.informedBy(informer).should.be.false

      it 'that is is not informed by should not error', ->
        for informer in notInforming
          informer.informs(informee).should.be.false
          informee.informedBy(informer).should.be.false
        informee.uninformFrom(notInforming)
        for informer in notInforming
          informer.informs(informee).should.be.false
          informee.informedBy(informer).should.be.false


