# Syntax

**Cohtml** is just html with a cleaner, terser syntax.

### Tags

rules - 

* no angular braces
* one tag per line
* no closing tags, indentation based scope.

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
