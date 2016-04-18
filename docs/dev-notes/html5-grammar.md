
This file adheres to the [Backus–Naur Form](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form) and [Extended Backus–Naur Form](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_Form). Angular braces are replaced with Curly Braces due to the issues with Markdown preview.

```
{scope} ::= ({wsnl}{tag}*{wsnl})*
{tag} ::= <{tag-name}{wsnl}({tag-attribute}{wsnl}[={wsnl}{dq}{tag-attribute-value}{dq}{wsnl}]{wsnl})*{wsnl}(/{wsnl}>|>|[{wsnl}{scope}{wsnl}]</{ws}{tag-name}{wsnl}>{wsnl})
{wsnl} ::= ({ws}*{nl}*)*

```