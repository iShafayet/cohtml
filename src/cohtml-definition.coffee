
class CohtmlNode

  constructor: (@parent = null, @tag = null, @id = null, @classList = [], @attributeMap = {})->
    @innerText = null
    @childrenList = []
    return

class CohtmlTextNode

  constructor: (@parent = null, @innerText = null)->
    return

@CohtmlNode = CohtmlNode
@CohtmlTextNode = CohtmlTextNode





  
