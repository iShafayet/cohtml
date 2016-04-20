
{ expect } = require('chai')

{ CohtmlParser } = require './../src/cohtml-parser'

{ CohtmlToHtml5Converter } = require './../src/cohtml-to-html5-converter'

{ Html5Writer } = require './../src/html5-writer'

{ Seetoken } =  require 'seetoken'

fs = require 'fs'

describe 'Html5 Writer', ->

  it.only 'Work in progress', ->

    input = fs.readFileSync './test/sample-cohtml/work-in-progress.cohtml', 'utf8'

    parser = new CohtmlParser input

    scope = parser.extractScope()

    converter = new CohtmlToHtml5Converter

    html5Scope = converter.convert scope[0]

    # console.log (require 'util').inspect html5Scope, {depth:50, colors: true}

    writer = new Html5Writer

    html5 = writer.write html5Scope

    console.log html5

    # console.log Seetoken.tokenize html5, { color: true }


