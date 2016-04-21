
{ Html5Node, Html5TextNode, Html5CommentNode } = require './html5-definition'

class Html5Writer

  constructor: ->

  writeScope: (scope)->
    returnScope = ''
    for node in scope
      returnNode = @writeNode node
      returnScope += returnNode
    return returnScope

  writeNode: (node, indentLevel = 0)->

    if node instanceof Html5Node

      signature = tag = '' + node.tag

      for attribute, value of node.attributeMap
        signature += ' ' + attribute
        if value
          signature += '="' + value + '"'

      if node.isNonClosing
        html = '<' + signature + '>'
        if node.childrenList.length > 0
          for child in node.childrenList
            html += @writeNode child, (indentLevel + 0)
        return html

      if node.isSelfClosing
        html = '<' + signature + ' />'
      else
        html = '<' + signature + '>'

        if node.childrenList.length > 0
          for child in node.childrenList
            html += @writeNode child, (indentLevel + 1)
        else
          if node.innerText
            html += node.innerText

        html += '</' + tag + '>'

      return html

    else if node instanceof Html5TextNode

      innerText = node.innerText
      if node.preserveWhitespaceAndNewlines
        innerText = innerText.replace /\r\n/g, '<br>'
        innerText = innerText.replace /\n/g, '<br>'
        innerText = innerText.replace /[ ]/g, '&nbsp;'

        
      return innerText

    else if node instanceof Html5CommentNode

      return '<!-- ' + node.innerText + ' -->'

    else

      throw new Error 'Unsupported Node'

@Html5Writer = Html5Writer





