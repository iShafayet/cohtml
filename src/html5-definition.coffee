
@selfClosingHtml5TagList = [ 'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr' ]

@nonClosingHtml5TagList = [ '!doctype' ]

class Html5Node

  constructor: (@parent = null, @tag = null, @attributeMap = {}, @innerText = null)->
    @childrenList = []
    @isSelfClosing = false
    @isNonClosing = false
    return

class Html5TextNode

  constructor: (@parent = null, @innerText = null)->
    return

class Html5CommentNode

  constructor: (@parent = null, @innerText = null)->
    return

@Html5Node = Html5Node
@Html5TextNode = Html5TextNode
@Html5CommentNode = Html5CommentNode
