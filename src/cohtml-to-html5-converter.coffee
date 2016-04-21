
{ CohtmlNode, CohtmlTextNode, CohtmlCommentNode } = require './cohtml-definition'

{ Html5Node, Html5TextNode, Html5CommentNode, nonClosingHtml5TagList, selfClosingHtml5TagList } = require './html5-definition'

class CohtmlToHtml5Converter

  constructor: ->

  convertScope: (scope)->
    returnScope = []
    for node in scope
      returnNode = @convertNode node
      returnScope.push returnNode
    return returnScope

  convertNode: (node, parentHtml5Node = null)->
    if node instanceof CohtmlNode

      attributeMap = {}
      for attribute, value of node.attributeMap
        attributeMap[attribute] = value

      if node.id
        attributeMap['id'] = node.id

      if node.classList.length isnt 0
        unless 'class' of attributeMap
          attributeMap['class'] = ''
        if attributeMap['class'].length isnt 0
          attributeMap['class'] += ' '
        attributeMap['class'] += (node.classList).join ' '

      currentHtml5Node = new Html5Node parentHtml5Node, node.tag, attributeMap, node.innerText

      if currentHtml5Node.tag in nonClosingHtml5TagList
        currentHtml5Node.isNonClosing = true

      if currentHtml5Node.tag in selfClosingHtml5TagList
        currentHtml5Node.isSelfClosing = true

    else if node instanceof CohtmlTextNode
      currentHtml5Node = new Html5TextNode parentHtml5Node, node.innerText

    else if node instanceof CohtmlCommentNode
      currentHtml5Node = new Html5CommentNode parentHtml5Node, node.innerText

    else
      throw new Error 'Unknown type of node provided.'

    if parentHtml5Node
      parentHtml5Node.childrenList.push currentHtml5Node

    if node.childrenList
      for childNode in node.childrenList
        childHtml5Node = @convertNode childNode, currentHtml5Node

    return currentHtml5Node

@CohtmlToHtml5Converter = CohtmlToHtml5Converter
