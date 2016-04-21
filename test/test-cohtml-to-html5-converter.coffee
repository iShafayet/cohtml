
{ expect } = require('chai')

{ CohtmlParser } = require './../src/cohtml-parser'

{ CohtmlToHtml5Converter } = require './../src/cohtml-to-html5-converter'

fs = require 'fs'

describe 'Cohtml To Html5 Converter', ->

  it 'Work in progress', ->

    input = fs.readFileSync './test/sample-cohtml/work-in-progress.cohtml', 'utf8'

    parser = new CohtmlParser input

    scope = parser.extractScope()

    converter = new CohtmlToHtml5Converter

    html5Scope = converter.convertScope scope

    console.log (require 'util').inspect html5Scope, {depth:50, colors: true}

