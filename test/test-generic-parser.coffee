
{ expect } = require('chai')

{ GenericParser } = require './../src/generic-parser'

describe.only 'GenericParser', ->

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





