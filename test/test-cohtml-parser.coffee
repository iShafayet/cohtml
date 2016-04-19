
{ expect } = require('chai')

{ CohtmlParser } = require './../src/cohtml-parser'

fs = require 'fs'

describe 'Cohtml Parser', ->

  it 'Work in progress', ->

    input = fs.readFileSync './test/sample-cohtml/work-in-progress.cohtml', 'utf8'

    parser = new CohtmlParser input
