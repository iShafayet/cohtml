
class GenericParser
  
  constructor: (inputString)->

    unless typeof inputString is 'string'
      throw new Error "Expected inputString to be a string"

    @inputArray = inputString.split ''
    @head = 0
    @headStack = []

  pushHead: ->
    @headStack.push @head
    return

  popHead: ->
    @head = @headStack.pop()
    return

  current: ->
    return @inputArray[@head]

  moveForward: ->
    @head += 1
    return

  

  















@GenericParser = GenericParser
