
class Html5Node

  constructor: (@parent = null, @tag = null, @attributeMap = {}, @innerText = null, @childrenList = [])->
  	@isSelfClosing = false
  	@isNonClosing = false
    return

class Html5TextNode

  constructor: (@parent = null, @innerText = null)->
    return

@Html5Node = Html5Node
@Html5TextNode = Html5TextNode





  
