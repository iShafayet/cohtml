
{ GenericParser } = require './generic-parser'

{ Html5Node, Html5TextNode, Html5CommentNode, nonClosingHtml5TagList, selfClosingHtml5TagList } = require './html5-definition'

class Html5Parser extends GenericParser

  constructor: (inputString, optionMap = {})->
    super inputString
    { indentCharacter } = optionMap
    @indentCharacter = indentCharacter or '  '
    @charset = 
      tag: [].concat ['!'], Html5Parser.CommonTokens.urlSafeBase64
      attribute: [].concat ['$', '?'], Html5Parser.CommonTokens.urlSafeBase64
      equal: '='
      dquote: '"'
      slash: '/'
      newline: Html5Parser.CommonTokens.newline
      whitespaceAndNewline: [].concat Html5Parser.CommonTokens.newline, Html5Parser.CommonTokens.whitespace
      angularBraceStart: '<'
      angularBraceEnd: '>'

  ###
    Error Management
  ###

  throwError: (message)->
    ex = new Error message
    ex.name = 'HtmlParserError'

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
           HtmlParserError: #{message}
           head: #{@head} (#{@current()})
           line: #{lineNumber}
           char: #{charNumber}
           near: |#{line}|
                  #{nearPointer}
           """
    ex.stack = text
    throw ex

  takeOrThrowError: (stringArray, message)->
    if (char = @take stringArray)
      return char
    else
      return @throwError message

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

  ignoreWhitespaceAndNewline: ->
    @ignore @charset['whitespaceAndNewline']

  ###
    Extraction
  ###

  extractScope: (parentNode = null)->
    scope = []
    while node = @extractStatement parentNode
      scope.push node
    return scope

  extractStatement: (parentNode)->

    @ignoreWhitespaceAndNewline()

    if node = @extractNode parentNode
      return node

    else
      return false

  extractNode: (parentNode)->

    return false unless @take @charset['angularBraceStart']

    @ignoreWhitespaceAndNewline()
    tag = @takeAllUntil ([].concat @charset['whitespaceAndNewline'], @charset['angularBraceEnd'])

    @ignoreWhitespaceAndNewline()
    attributeMap = {}
    while attribute = @takeAll @charset['attribute']

      @ignoreWhitespaceAndNewline()
      if @take @charset['equal']

        @ignoreWhitespaceAndNewline()
        if @take @charset['dquote']
          value = @takeAllUntil @charset['dquote']
          attributeMap[attribute] = value
          @take @charset['dquote']
        else
          @throwError 'Expected Double Quote after = sign'

      else
        attributeMap[attribute] = null
      @ignoreWhitespaceAndNewline()

    @ignoreWhitespaceAndNewline()
    node = new Html5Node parentNode, tag, attributeMap

    console.log node

    if tag in nonClosingHtml5TagList
      unless @take @charset['angularBraceEnd']
        @throwError 'Expected > at the end of non-closing tag ' + tag
      node.isNonClosing = true
      return node

    if @take @charset['slash']
      @ignoreWhitespaceAndNewline()
      unless @take @charset['angularBraceEnd']
        @throwError 'Expected > at the end of self closing tag' + tag + ' after /'
      node.isSelfClosing = true
      return node

    if tag in selfClosingHtml5TagList
      unless @take @charset['angularBraceEnd']
        @throwError 'Expected > at the end of tag ' + tag
      node.isSelfClosing = true
      return node

    unless @take @charset['angularBraceEnd']
      @throwError 'Expected > at the end of tag ' + tag

    node.childrenList = @extractScope node

    @ignoreWhitespaceAndNewline()

    unless @take @charset['angularBraceStart']
      @throwError 'Expected <'

    @ignoreWhitespaceAndNewline()

    unless @take @charset['slash']
      @throwError 'Expected /'

    @ignoreWhitespaceAndNewline()

    unless @take tag
      @throwError 'Expected ' + tag

    @ignoreWhitespaceAndNewline()

    unless @take @charset['angularBraceEnd']
      @throwError 'Expected >'

    return node


@Html5Parser = Html5Parser