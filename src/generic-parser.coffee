
class GenericParser
  
  constructor: (inputString)->

    unless typeof inputString is 'string'
      throw new Error "Expected inputString to be a string"

    @inputArray = inputString.split ''
    @head = 0
    @headStack = []

  ###
    Basic Mechanism
  ###

  backUp: ->
    @headStack.push @head
    return

  commit: ->
    @headStack.pop()
    return

  rollback: ->
    @head = @headStack.pop()
    return

  current: ->
    return @inputArray[@head]

  moveForward: ->
    @head += 1
    return

  ###
    Utilities
  ###

  collectUntilFalse: (fn)->
    returnString = ''
    while string = fn()
      returnString += string
    return returnString

  ###
    Known Length Token Extraction
  ###

  takeIfChar: (char)->
    if @current() is char
      @moveForward()
      return char
    else
      return false

  takeIfString: (string)->
    @backUp()
    for char in string.split ''
      unless @takeIfChar char
        @rollback()
        return false
    @commit()
    return string

  takeIfInCharArray: (charArray)->
    @backUp()
    for char in charArray
      if @takeIfChar char
        @commit()
        return char
    @rollback()
    return false

  takeIfInStringArray: (stringArray)->
    @backUp()
    for string in stringArray
      if @takeIfString string
        @commit()
        return string
    @rollback()
    return false

  takeUnlessChar: (char)->
    unless (cur = @current()) is char
      @moveForward()
      return cur
    return false

  ###
    Variable Length Token Extraction
  ###

  takeUntilChar: (char)->
    string = ''
    while takenChar = @takeUnlessChar char
      string += takenChar
    return string

  takeUntilString: (string)->
    returnString = ''
    loop
      @backUp()
      if @takeIfString string
        @rollback()
        return returnString
      else
        returnString += @current()
        @moveForward()

  takeUntilInCharArray: (charArray)->
    returnString = ''
    loop
      if @current() in charArray
        return returnString
      else
        returnString += @current()
        @moveForward()

  takeUntilInStringArray: (stringArray)->
    returnString = ''
    loop
      @backUp()
      if @takeIfInStringArray stringArray
        @rollback()
        return returnString
      else
        returnString += @current()
        @moveForward()

  ###
    Common Tokens
  ###

  @CommonTokens: do ->
    unixNewline = '\n'
    windowsNewline = '\r\n'
    newline = ['\n', '\r\n']
    space = ' '
    tab = '\t'
    whitespace = [' ', '\t']
    alphabetSmall = 'abcdefghijklmnopqrstuvwzyz'.split ''
    alphabetCapital = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split ''
    alpha = [].concat alphabetCapital, alphabetSmall
    numeric = '0123456789'.split ''
    alphanumeric = [].concat alpha, numeric
    base64 = [].concat alphanumeric, [ '+', '/' ] ## NOTE: RFC 4648 Spec
    urlSafeBase64 = [].concat alphanumeric, [ '-', '_' ] 
    return {
      unixNewline
      windowsNewline
      newline
      space
      tab
      whitespace
      alphabetSmall
      alphabetCapital
      alpha
      numeric
      alphanumeric
      base64
      urlSafeBase64
    }

  ###
    Common Extraction Methods
  ###

  ignore: (stringArray)->
    if typeof stringArray is 'string'
      stringArray = [stringArray]
    parser.collectUntilFalse => parser.takeIfInStringArray stringArray
    return

  takeAll: (stringArray)->
    if typeof stringArray is 'string'
      stringArray = [stringArray]
    return parser.collectUntilFalse => parser.takeIfInStringArray stringArray


@GenericParser = GenericParser
