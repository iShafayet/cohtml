# Syntax

**Cohtml** is just html with a cleaner, terser syntax.

### Tags

**Rules**

* no angular braces
* one tag per line
* no closing tags, indentation based scope.
* children have one extra indentation than their parent.

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

**Rules**

* attributes are written exactly like in html 
* There is a shorthand for IDs. Anything after a dollar (`$`) sign until a space or dot is considered an ID.
* There is a shorthand for Classes. Anything after a dot (`.`) sign until a space or dot or dollar sign is considered a class. Multiple classes are supported.
* If using both the shorthand and class attribute, the resulting value will be concatenated.

**Cohtml**
```
div
div$myId
div.myclass
div.myclass1.myclass2$myId
div.myclass1.myclass2.myclass3
div style="color:red"
div$myId.myclass1.myclass2 style="color:red"
div.myclass1 class="myclass2"
```

**HTML**
```html
<div></div>
<div id="myId"></div>
<div class="myclass"></div>
<div class="myclass1 myclass2" id="myId"></div>
<div class="myclass1 myclass2 myclass3"></div>
<div style="color: red"></div>
<div id="myId" class="myclass1 myclass2" style="color: red"></div>
<div class="myclass2 myclass1"></div>
```

### Inner Text

**Rules**

* Anything after a tag and a pipe (`|`) and a single space sign is considered innertext. Pipe denoted inner text is a single line inner text. Note that the single space after the pipe sign is required and does not appear in generated html.
* Multiline inner texts can be inserted using backticks.
* Standalone inner texts using backticks is supported.
* Standalone triple backticks can be used to insert inner text that preserve newline and whitespace.
* Note that a tag can not contain both inner children and inline inner text. Use the standalone inner text instead.

**Cohtml**
```
p.class1 | Some text
p.class1 `Line1
Line2
`
p.class1
  `line`
  `line2`
p.class1
  `my name`
  ` is`
  b
    `dan.`
p.class1
  `line1
   line2`
p.class1
  ```line1
   line2```
```

**HTML**
```html
<p class="class1">Some text</p>
<p class="class1">Line1Line2</p>
<p class="class1">my name is<b>dan</b></p>
<p class="class1">Line1Line2</p>
<p class="class1">Line1<br>&nbsp;&nbsp;&nbsp;Line2</p>

```

### Shorthand for inline styles

**Rules**

* Inline styles can be written using braces `(` `)`. There can be only one inline style for an element. The braces must be written *after* any other attributes and *before* any inner text.
* If using both the `style` attribute and shorthand, the content inside the braces will be appended at the end.
**Cohtml**
```
div (color:red;)
div (color:red;) | inner text here
div$myId.myclass1.myclass2 some-attribute="someValue" (color:red;)
div style="color:blue;" (color:red;)
```

**HTML**
```html
<div style="color:red;"></div>
<div style="color:red;">inner text here</div>
<div id="myId" class="myclass1 myclass2" some-attribute="someValue" style="color: red"></div>
<div style="color:blue;color:red;"></div>
```


### Full Syntax Showcase

[This File](full-syntax-showcase.md) contains a demo `cohtml` document that showcases all features of the cohtml language. Great for quick reference.



