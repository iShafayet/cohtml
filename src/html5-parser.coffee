
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

  extractScope: ->
  	return ''


@Html5Parser = Html5Parser