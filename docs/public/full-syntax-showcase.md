
**Cohtml**

```
!doctype html
html lang="en"
  head
    title | Hello World
    style type="text/css" `
      .container {
        background: #cccccc;
      }
    `
  body
    h1$title | Hello World
    div.container
      img src="myimage.png"
      p `lorem ipsum.`
    script type="text/javascript" `
      console.log('hello world.');
    `
```

**html**

```html
<!doctype html>
<html lang="en">
  <head>
    <title>Hello World</title>
    <style type="text/css">
      .container {
        background: #cccccc;
      }
    </style>
  </head>
  <body>
    <h1 id="title">Hello World</h1>
    <div class="container">
      <img src="myimage.png" />
      <p>lorem ipsum.</p>
    </div>
    <script type="text/javascript">
      console.log('hello world.');
    </script>
  </body>
</html>
```



