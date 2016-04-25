# NOTICE!
This project is under development and in no way is ready for production use. Use at your own risk.

# cohtml
Cohtml is a declarative markup language with ruby/coffee-script like syntax that transpiles to and from Html.

```
!doctype html
html lang="en"
  head
    title | Cohtml Demo
  body (margin:0px)
    h1 | Cohtml Demo
    img src="logo.png" (height:24px;width:24px;)
    p
      `Cohtml is a `
      b | excellent
      `alternative to html`
```

# docs

[Documentation (Syntax, Api, Tools, Extensions)](docs/public)

[Notes For Developers](docs/dev-notes)
