
{ expect } = require('chai')

{ CohtmlParser } = require './../src/cohtml-parser'

{ CohtmlToHtml5Converter } = require './../src/cohtml-to-html5-converter'

{ Html5Writer } = require './../src/html5-writer'

{ Seetoken } =  require 'seetoken'

prettify = require 'pretty'

validateHtml5 = require 'html-validator'

fs = require 'fs'

describe.only 'Scenario Based Tests', ->

  toHtml5 = (cohtmlCode)->
    parser = new CohtmlParser cohtmlCode
    scope = parser.extractScope()
    converter = new CohtmlToHtml5Converter
    html5Scope = converter.convertScope scope
    writer = new Html5Writer
    html5 = writer.writeScope html5Scope
    return html5

  it 'Scenario 1. Describe...', ->

    input = fs.readFileSync './test/scenarios/scenario-1-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-1-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)
    
  it 'Scenario 2. Single Character Testing', ->

    input = fs.readFileSync './test/scenarios/scenario-2-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-2-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 3. Single Character Testing with empty line at first', ->

    input = fs.readFileSync './test/scenarios/scenario-3-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-3-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)
  
  it 'Scenario 4. Single Character Testing with an attribute', ->

    input = fs.readFileSync './test/scenarios/scenario-4-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-4-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)