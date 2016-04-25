
{ expect } = require('chai')

{ Html5Parser } = require './../src/html5-parser'

fs = require 'fs'

describe 'Html5 Parser', ->

  it 'Work in progress', ->

    input = fs.readFileSync './test/sample-cohtml/work-in-progress.html', 'utf8'

    parser = new Html5Parser input

    scope = parser.extractScope()

    console.log (require 'util').inspect scope, {depth:50, colors: true}

