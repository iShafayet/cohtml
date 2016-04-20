
{ expect } = require('chai')

{ CohtmlParser } = require './../src/cohtml-parser'

{ CohtmlToHtml5Converter } = require './../src/cohtml-to-html5-converter'

{ Html5Writer } = require './../src/html5-writer'

fs = require 'fs'

describe 'Html5 Writer', ->

  it.only 'Work in progress', ->

    input = fs.readFileSync './test/sample-cohtml/work-in-progress.cohtml', 'utf8'

    parser = new CohtmlParser input

    scope = parser.extractScope()

    converter = new CohtmlToHtml5Converter

    html5Scope = converter.convert scope[0]

    writer = new Html5Writer

    console.log writer.write html5Scope

