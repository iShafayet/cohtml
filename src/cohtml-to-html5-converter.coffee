
{ CohtmlNode, CohtmlTextNode } = require './cohtml-definition'

{ Html5Node, Html5TextNode, nonClosingHtml5TagList, selfClosingHtml5TagList } = require './html5-definition'

class CohtmlToHtml5Converter

  constructor: ->

  convert: (node, parentHtml5Node = null)->
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
      currentHtml5Node = new Html5Node parentHtml5Node, node.innerText

    else
      throw new Error 'Unknown type of node provided.'

    if parentHtml5Node
      parentHtml5Node.childrenList.push currentHtml5Node

    if node.childrenList
      for childNode in node.childrenList
        childHtml5Node = @convert childNode, currentHtml5Node

    return currentHtml5Node

@CohtmlToHtml5Converter = CohtmlToHtml5Converter
