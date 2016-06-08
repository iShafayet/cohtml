
{ expect } = require('chai')

{ CohtmlParser } = require './../src/cohtml-parser'

fs = require 'fs'

describe 'Cohtml Parser', ->

  it 'Work in progress', ->

    input = fs.readFileSync './test/sample-cohtml/work-in-progress.cohtml', 'utf8'

    parser = new CohtmlParser input

    scope = parser.extractScope()

    # console.log (require 'util').inspect scope, {depth:50, colors: true}

