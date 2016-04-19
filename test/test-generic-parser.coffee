
{ expect } = require('chai')

{ GenericParser } = require './../src/generic-parser'

describe 'Generic Parser', ->

  it 'ignore, take, takeAll, takeAllUntil', ->

    input = 'fffffffffffffffffTTTTTTTTTTTTTTTTTTTTTTTTTTcefyvfh4fci46cfh48fc84hcf4f874hc3hhc!hfyuysfhsfdsf'
    
    parser = new GenericParser input

    parser.ignore [ 'f', 'g' ]

    val = parser.takeAll 'T'
    expect(val).to.equal('TTTTTTTTTTTTTTTTTTTTTTTTTT')

    val = parser.takeAllUntil '!'
    expect(val).to.equal('cefyvfh4fci46cfh48fc84hcf4f874hc3hhc')

    val = parser.take '!'
    expect(val).to.equal('!')

  it 'collectUntilFalse', ->

    input = 'fffff rrrerrrem Something</a>'

    parser = new GenericParser input

    val = parser.takeIfChar 'f'
    expect(val).to.equal('f')

    val = parser.collectUntilFalse => parser.takeIfChar 'f'
    expect(val).to.equal('ffff')

  it 'takeUntilInCharArray, takeUntilInStringArray', ->

    input = 'fffffrggggggggq'

    parser = new GenericParser input

    val = parser.takeUntilInCharArray [ 'r', 'q' ]
    expect(val).to.equal('fffff')

    parser.moveForward()

    val = parser.takeUntilInCharArray [ 'r', 'q' ]
    expect(val).to.equal('gggggggg')

    input = 'fffkiffkioggggggggqte'

    parser = new GenericParser input

    val = parser.takeUntilInStringArray [ 'kio', 'qte' ]
    expect(val).to.equal('fffkiff')

    parser.moveForward() for i in [0...3]

    val = parser.takeUntilInStringArray [  'kio', 'qte' ]
    expect(val).to.equal('gggggggg')


  it 'takeUnlessChar, takeUntilChar, takeUntilString', ->

    input = 'fffff rrrerrrem Something</a>'

    parser = new GenericParser input

    val = parser.takeUnlessChar ' '
    expect(val).to.equal('f')

    val = parser.takeUnlessChar 'f'
    expect(val).to.equal(false)

    val = parser.takeUntilChar ' '
    expect(val).to.equal('ffff')

    val = parser.takeUntilChar ' '
    expect(val).to.equal('')

    val = parser.takeUntilString 'em'
    expect(val).to.equal(' rrrerrr')

    val = parser.takeUntilString ' '
    expect(val).to.equal('em')

    val = parser.takeUntilString '</a>'
    expect(val).to.equal(' Something')

  it 'takeIfChar, takeIfString, takeIfInCharArray, takeIfInStringArray', ->

    input = '<a>Something</a>'

    parser = new GenericParser input

    val = parser.takeIfChar 'a'
    expect(val).to.equal(false)

    val = parser.takeIfChar '<'
    expect(val).to.equal('<')

    val = parser.takeIfString '<'
    expect(val).to.equal(false)

    val = parser.takeIfString 'a>'
    expect(val).to.equal('a>')

    val = parser.takeIfInCharArray [ 'n', 'm', 's' ]
    expect(val).to.equal(false)

    val = parser.takeIfInCharArray [ 'n', 'm', 'S' ]
    expect(val).to.equal('S')

    val = parser.takeIfInStringArray [ 'omk', 'omw', 'sdw' ]
    expect(val).to.equal(false)

    val = parser.takeIfInStringArray [ 'omk', 'ome', 'sdw' ]
    expect(val).to.equal('ome')


  it 'backUp, commit, moveForward, rollback', ->

    parser = new GenericParser 'asdf'

    expect(parser).to.have.property('head').that.equals(0)

    parser.moveForward()
    expect(parser.head).to.equal(1)

    parser.backUp()

    parser.moveForward()
    expect(parser.current()).to.equal('d')

    parser.rollback()
    expect(parser.current()).to.equal('s')



