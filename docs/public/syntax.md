# Syntax

**Cohtml** is just html with a cleaner, terser syntax.

### Tags

**rules**

* no angular braces
* one tag per line
* no closing tags, indentation based scope.
* children have one extra indentation than his parents.

**HTML**
```html
<!doctype html>
<html lang="en">
  <head>
    <title>Hello World</title>
  </head>
  <body>
    <div>Simple Text</div>
    <img src="myimage.png">
  </body>
</html>
```

**Cohtml**
```
!doctype html
html lang="en"
  head
    title | Hello World
  body
    div | Simple Text
    img src="myimage.png"
```


### Attributes, ID and Class Shorthands

**rules**

* attributes are written exactly like in html 
* There is a shorthand for IDs. Anything after a dollar ($) sign is considered an ID.
* There is a shorthand for Classes. Anything after a dot (.) sign is considered a class. Multiple classes are supported

**HTML**
```html
<div></div>
<div id="myId"></div>
<div class="myclass"></div>
<div class="myclass1 myclass2" id="myId"></div>
<div class="myclass1 myclass2 myclass3"></div>
<div style="color: red"></div>
<div id="myId" class="myclass1 myclass2" style="color: red"></div>
```

**Cohtml**
```
div
div$myId
div.myclass
div.myclass1.myclass2$myId
div.myclass1.myclass2.myclass3
div style="color:red"
div$myId.myclass1.myclass2 style="color:red"
```
