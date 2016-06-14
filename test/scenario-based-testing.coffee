
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

  it 'Scenario 5. Single Character Testing with two attribute', ->

    input = fs.readFileSync './test/scenarios/scenario-5-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-5-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 6. Link adding  ', ->

    input = fs.readFileSync './test/scenarios/scenario-6-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-6-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 7. Attribute with a space at the first ', ->

    input = fs.readFileSync './test/scenarios/scenario-7-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-7-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 8. Two attribute with a space at the second ', ->

    input = fs.readFileSync './test/scenarios/scenario-8-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-8-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 9. Two attribute with two space ', ->

    input = fs.readFileSync './test/scenarios/scenario-9-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-9-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 10. Attribute with a space at the last ', ->

    input = fs.readFileSync './test/scenarios/scenario-10-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-10-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 11. Attribute with a space at the first and a space in the last ', ->

    input = fs.readFileSync './test/scenarios/scenario-11-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-11-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 12. Attribute with two space at the last of every attribute', ->

    input = fs.readFileSync './test/scenarios/scenario-12-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-12-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 13. Attribute with two space at the first and last of the first attribute and one space on the last of the second attribute ', ->

    input = fs.readFileSync './test/scenarios/scenario-13-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-13-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 14. Attribute with two space at the first and last of the first attribute and one space on the first of the second attribute ', ->

    input = fs.readFileSync './test/scenarios/scenario-14-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-14-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 15. Attribute with two space at the first and last of the first attribute and two space on the first and last of the second attribute ', ->

    input = fs.readFileSync './test/scenarios/scenario-15-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-15-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 16. child and parent', ->

    input = fs.readFileSync './test/scenarios/scenario-16-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-16-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 17. Child with attribute in the parent', ->

    input = fs.readFileSync './test/scenarios/scenario-17-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-17-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 18. Child with attribute in the child', ->

    input = fs.readFileSync './test/scenarios/scenario-18-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-18-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)

  it 'Scenario 19. Two attribute in the parent tag', ->

    input = fs.readFileSync './test/scenarios/scenario-19-input.cohtml', 'utf8'
    # console.log input
    output = toHtml5 input
    # console.log output
    expectedOutput = fs.readFileSync './test/scenarios/scenario-19-expected.html', 'utf8'
    # console.log expectedOutput
    expect(output).to.equal(expectedOutput)