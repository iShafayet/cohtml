
{ Html5Node, Html5TextNode } = require './html5-definition'

class Html5Writer

  constructor: (options = {}) ->
    {
      indentCharacter
    } = options

    @indentCharacter = indentCharacter or '\t'

  write: (node)->

    if node instanceof Html5Node

      signature = tag = '' + node.tag

      for attribute, value of node.attributeMap
        signature += ' ' + attribute
        if value
          signature += ' = "' + value + '"'

      if node.isSelfClosing
        html = '<' + signature + ' />'
      else if node.isNonClosing
        html = '<' + signature + '>'
      else
        html = '<' + signature + '>'

        if node.childrenList.length > 0
          for child in node.childrenList
            html += @write child
        else
          if node.innerText
            html += node.innerText

        html += '</' + tag + '>'

      return html

    else if node instanceof Html5TextNode

      return node.innerText

    else

      throw new Error 'Unsupported Node'

@Html5Writer = Html5Writer





