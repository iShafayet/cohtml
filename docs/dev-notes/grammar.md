
This file adheres to the [Backus–Naur Form](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form) and [Extended Backus–Naur Form](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_Form). Angular braces are replaced with Curly Braces due to the issues with Markdown preview.



```

{eolc} ::= End of Line Character

{indent} ::= Two white spaces or a tab character. Depending on the first indent encountered in the input

{s} ::= A Space Character

{t} ::= A Tab Character

{ws} ::= ({s}*{t}*)*

{statement} ::= {indent}*{tag}{eolc}

{tag} ::= {tag-head}{ws}{tag-tail}

{tag-head} ::= {tag-name}|


```