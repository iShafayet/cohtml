
{ GenericParser } = require './generic-parser'

{ CohtmlNode, CohtmlTextNode } = require './cohtml-definition'

class CohtmlParser extends GenericParser

  constructor: (inputString, optionMap = {})->
    super inputString
    { indentCharacter } = optionMap
    @indentCharacter = indentCharacter or '  '
    @charset = 
      tag: CohtmlParser.CommonTokens.urlSafeBase64
      id: CohtmlParser.CommonTokens.urlSafeBase64
      class: CohtmlParser.CommonTokens.urlSafeBase64
      attribute: CohtmlParser.CommonTokens.urlSafeBase64
      ws: CohtmlParser.CommonTokens.whitespace
      equal: '='
      dquote: '"'
      pipe: '|'
      backtick: '`'
      newline: CohtmlParser.CommonTokens.newline

  ###
    Error Management
  ###

  throwError: (message)->
    ex = new Error message
    ex.name = 'CohtmlParserError'

    inputString = (@inputArray.join '')

    location = (@inputArray[0...@head]).join ''

    lineNumber = 1 + @countNewlines location
    
    offset = location.lastIndexOf '\n'
    index = inputString.indexOf '\n', (offset+1)
    line = (@inputArray[offset+1...index]).join ''
    # line = line.replace /\s/g, '~'

    charNumber = @head - offset - 1

    nearPointer = (if charNumber is 0 then '' else ((' ' for _ in [0...charNumber-1]).join '')) + '^'

    text = """
           CohtmlParserError: #{message}
           head: #{@head} (#{@current()})
           line: #{lineNumber}
           char: #{charNumber}
           near: <#{line}>
                  #{nearPointer}
           """
    ex.stack = text
    throw ex

  ###
    Utilities
  ###



  countNewlines: (string)->
    lineCount = 0
    offset = 0
    while (index = string.indexOf '\n', offset) > -1
      offset += index + 1
      lineCount += 1
    return lineCount

  ignoreWhitespace: ->
    @ignore @charset['ws']





  getIndentLevel: ->
    @backUp()
    foundIndentLevel = (@takeAll @indentCharacter).length / @indentCharacter.length
    @rollback()
    return foundIndentLevel

  ###
    Extraction
  ###

  extractScope: (indentLevel = 0, parentNode = null)->
    scope = []
    while node = @extractStatement indentLevel, parentNode
      scope.push node
    return scope

  extractStatement: (indentLevel, parentNode)->

    

    foundIndentLevel = @getIndentLevel()

    if foundIndentLevel is indentLevel
      @takeAll @indentCharacter
      if node = @extractNode indentLevel, parentNode
        return node
      else if node = @extractTextNode indentLevel, parentNode
        return node
      else
        if @isEof()
          return false
        else
          @throwError 'Expected CohtmlNode or CohtmlTextNode.'
    else
      return false

  extractTextNode: (indentLevel, parentNode)->
    if @take @charset['backtick']
      innerText = @takeAllUntil @charset['backtick']
      @take @charset['backtick']
      @ignoreWhitespace()

      node = new CohtmlTextNode parentNode, innerText

      @take @charset['newline']

      @backUp()
      childrenList = @extractScope (indentLevel + 1), node
      if childrenList.length isnt 0
        @rollback()
        return @throwError 'CohtmlTextNode can not contain children'
      @commit()

      return node
    else
      return false

  extractNode: (indentLevel, parentNode)->
    tag = @takeAll @charset['tag']
    return false unless tag

    id = null
    classList = []
    while shorthand = @take [ '$', '.' ]
      if shorthand is '$'
        unless id = @takeAll @charset['id']
          @throwError 'Expected ID after $ sign'
      else
        if className = @takeAll @charset['class']
          classList.push className
        else
          @throwError 'Expected ClassName after $ sign'

    @ignoreWhitespace()    

    attributeMap = {}
    while attribute = @takeAll @charset['attribute']
      @ignoreWhitespace()
      
      if @take @charset['equal']

        @ignoreWhitespace()
        if @take @charset['dquote']
          value = @takeAllUntil @charset['dquote']
          attributeMap[attribute] = value
          @take @charset['dquote']
          if value.length is 0
            @throwError 'Value of an attribute can not be empty'
        else
          @throwError 'Expected Double Quote after = sign'

      else
        attributeMap[attribute] = null
      @ignoreWhitespace()

    @ignoreWhitespace()

    innerText = null
    if @take @charset['pipe']
      innerText = @takeAllUntil @charset['newline']
    else 
      if @take @charset['backtick']
        innerText = @takeAllUntil @charset['backtick']
        @take @charset['backtick']
        @ignoreWhitespace()

    node = new CohtmlNode parentNode, tag, id, classList, attributeMap, innerText

    @take @charset['newline']

    node.childrenList = @extractScope (indentLevel + 1), node

    return node


@CohtmlParser = CohtmlParser