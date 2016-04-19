
{ expect } = require('chai')

{ GenericParser } = require './../src/generic-parser'

describe 'Generic Parser', ->

  it 'Work In Progress Test', ->

    parser = new GenericParser 'asdf'

    expect(parser).to.have.property('head').that.equals(0)

    parser.moveForward()
    expect(parser.head).to.equal(1)

    parser.backUp()

    parser.moveForward()
    expect(parser.current()).to.equal('d')

    parser.rollback()
    expect(parser.current()).to.equal('s')

