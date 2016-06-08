
{ expect } = require('chai')

{ GenericParser } = require './../src/generic-parser'

describe 'GenericParser', ->

  describe 'constuctor', ->

    it 'expect it to throw error non-string is passed', ->
      fn = -> new GenericParser 4
      expect(fn).to.throw('Expected inputString to be a string')

    it 'expect it to throw error if empty string is passed', ->
      fn = -> new GenericParser ''
      expect(fn).to.throw('inputString can not be empty')

  describe '#current', ->

    it 'expect it to return current head', ->
      parser = new GenericParser '123'
      expect(parser.current()).to.equal('1')

    it 'expect it to return \'undefined\' if out of bound', ->
      parser = new GenericParser '123'
      parser.head = 3
      expect(parser.current()).to.equal(undefined)

  describe '#isEof', ->

    it 'expect it to return true if end of file reached', ->
      parser = new GenericParser '123'
      parser.head = 4
      expect(parser.isEof()).to.equal(true)

    it 'expect it to return false if end of file is not reached', ->
      parser = new GenericParser '123'
      parser.head = 2
      expect(parser.isEof()).to.equal(false)

  describe '#moveForward', ->

    it 'expect it to increment the head', ->
      parser = new GenericParser '123'
      fn = -> parser.moveForward()
      expect(fn).to.increase(parser, 'head')
      expect(parser.head).to.equal(1)

    it 'expect it to return true if not isEof', ->
      parser = new GenericParser '1'
      ret = parser.moveForward()
      expect(ret).to.equal(true)

    it 'expect it to return false if isEof', ->
      parser = new GenericParser '1'
      ret = parser.moveForward()
      ret = parser.moveForward()
      expect(ret).to.equal(false)

  describe '#backUp, #commit, #rollback', ->

    it 'combined use case scenario', ->

      parser = new GenericParser '123'

      parser.backUp()
      expect(parser.head).to.equal(0)

      parser.moveForward()
      expect(parser.head).to.equal(1)

      parser.rollback()
      expect(parser.head).to.equal(0)

      parser.moveForward()
      expect(parser.head).to.equal(1)

      parser.backUp()

      parser.moveForward()
      expect(parser.head).to.equal(2)

      parser.commit()
      expect(parser.head).to.equal(2)





