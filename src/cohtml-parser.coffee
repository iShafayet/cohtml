
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
    location = (@inputArray[0...@head]).join ''
    lineCount = @countNewlines location
    text = """
           CohtmlParserError: #{message}
           head: #{@head}
           line: #{lineCount}
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

  ensureIndent: (indentLevel)->
    indentString = (@indentCharacter for _ in [0...indentLevel]).join ''
    if indentString is '' or @take indentString
      return true
    else
      @throwError 'Inconsistent Indent.'

  ###
    Extraction
  ###

  extractScope: (indentLevel = 0, parentNode = null)->
    scope = []
    while node = @extractStatement indentLevel, parentNode
      scope.push node
    return scope

  extractStatement: (indentLevel, parentNode)->
    @ensureIndent indentLevel
    if node = @extractNode indentLevel, parentNode
      return node
    else if node = @extractTextNode parentNode
      return node
    else
      @ignoreWhitespace()
      if @isEof()
        return false
      else
        @throwError 'Expected CohtmlNode or CohtmlTextNode.'

  extractTextNode: (parentNode)->

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

    innerText = null
    if @take @charset['pipe']
      innerText = @takeAllUntil @charset['newline']
      @ignoreWhitespace()
    else 
      if @take @charset['backtick']
        innerText = @takeAllUntil @charset['backtick']
        @ignoreWhitespace()

    node = new CohtmlNode parentNode, tag, id, classList, attributeMap, innerText

    @take @charset['newline']

    childrenList = @extractScope (indentLevel + 1), node


@CohtmlParser = CohtmlParser