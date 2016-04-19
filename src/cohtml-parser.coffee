
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

@CohtmlParser = CohtmlParser