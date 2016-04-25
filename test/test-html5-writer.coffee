
{ expect } = require('chai')

{ CohtmlParser } = require './../src/cohtml-parser'

{ CohtmlToHtml5Converter } = require './../src/cohtml-to-html5-converter'

{ Html5Writer } = require './../src/html5-writer'

{ Seetoken } =  require 'seetoken'

prettify = require 'pretty'

validateHtml5 = require 'html-validator'

fs = require 'fs'

describe 'Html5 Writer', ->

  write = ->

    input = fs.readFileSync './test/sample-cohtml/work-in-progress.cohtml', 'utf8'

    parser = new CohtmlParser input

    scope = parser.extractScope()

    converter = new CohtmlToHtml5Converter

    html5Scope = converter.convertScope scope

    # console.log (require 'util').inspect html5Scope, {depth:50, colors: true}

    writer = new Html5Writer

    html5 = writer.writeScope html5Scope

    return html5

  it 'Work in progress', ->

    html5 = write()

    html5 = prettify html5

    console.log html5

  it.skip 'Validation', (done)->

    html5 = write()

    validateHtml5 { format: 'json', data: html5 }, (err, res)->
      throw err if err
      if res.messages.length is 0
        done()
      else
        console.log messages
        throw new Error 'Invalid Html5 According to Validator'





