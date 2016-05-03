# NOTICE!
This project is under development and in no way is ready for production use. Use at your own risk.

# Cohtml
Cohtml is a declarative markup language with ruby/coffee-script like syntax that transpiles to and from Html.

```coffee-script
!doctype html
html lang="en"
  head
    title | Cohtml Demo
  body (margin:0px)
    h1$myTitle.heading | Cohtml Demo
    img src="logo.png" (height:24px;width:24px;)
    p.info
      `Cohtml is an `
      b | excellent
      `alternative to html`
```

# Try Online

[cohtml.xyz](https://cohtml.xyz/try-online) (Coming Soon) Convert any html to cohtml and vice-versa without breaking a sweat.

# Documentation

[Documentation (Syntax, Api, Tools, Extensions)](docs/public)

[Notes For Developers](docs/dev-notes)

Common Tools & Extensions

* [Sublime Text 3 Language Support](..) (Coming Soon)
* [Atom Language Support](..) (Coming Soon)
* [gulp Plugin](..) (Coming Soon) 
* [conveyance Plugin](..) (Coming Soon)

# License

[MIT License](LICENSE)

