
class CohtmlNode

  constructor: (@parent = null, @name = null, @id = null, @classList = [], @attributeMap = {})->
    @innerText = null
    @childrenList = []
    return

class CohtmlTextNode

  constructor: (@innerText = null)->
    return

@CohtmlNode = CohtmlNode
@CohtmlTextNode = CohtmlTextNode





  
