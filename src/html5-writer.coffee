
{ Html5Node, Html5TextNode, Html5CommentNode } = require './html5-definition'

class Html5Writer

  constructor: (options = {}) ->
    {
      indentCharacter
    } = options

    @indentCharacter = indentCharacter or '  '

  writeScope: (scope)->
    returnScope = ''
    for node in scope
      returnNode = @writeNode node
      returnScope += returnNode
    return returnScope

  writeNodePretty: (node, indentLevel = 0)->

    padding = (@indentCharacter for _ in [0...indentLevel]).join ''

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

        ## padding insertion at the closing tag
        if node.childrenList.length is 0

          if node.innerText and (node.innerText.indexOf '\n') > -1
            if (node.innerText.lastIndexOf '\n') is node.innerText.length - 1
              html += padding + '</' + tag + '>'
            else
              html += '\n' + padding + '</' + tag + '>'
          else
            html += '</' + tag + '>'

        else

          if node.childrenList.length is 1 and node.childrenList[0] instanceof Html5TextNode
            html += '</' + tag + '>'
          else
            html += '\n' + padding + '</' + tag + '>'

      html = '\n' + padding + html
      return html

    else if node instanceof Html5TextNode

      return node.innerText

    else if node instanceof Html5CommentNode

      return '<!-- ' + node.innerText + ' -->'

    else

      throw new Error 'Unsupported Node'

@Html5Writer = Html5Writer





