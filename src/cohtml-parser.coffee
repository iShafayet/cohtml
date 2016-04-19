
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

@CohtmlParser = CohtmlParser