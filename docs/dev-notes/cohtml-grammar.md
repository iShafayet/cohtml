
This file adheres to the [Backus–Naur Form](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form) and [Extended Backus–Naur Form](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_Form). Angular braces are replaced with Curly Braces due to the issues with Markdown preview.


```
{scope} ::= {statement}*

{statement} ::= {indent}*({tag}|{text-node}){ws}({eolc}|{eofc})

{tag} ::= {tag-head}{ws}{tag-tail}[{scope}]

{tag-head} ::= {tag-name}[${tag-id}][(.{tag-class})+]

{tag-name} ::= {identifier}

{tag-id} ::= {identifier}

{tag-class} ::= {identifier}

{tag-tail} ::= ({tag-attribute}[={dq}{tag-attribute-value}{dq}]{ws})*[|{inline-text}]

{tag-attribute} ::= {identifier}

{tag-attribute-value} ::= Anything but {dq}

{inline-text} ::= Anything but {eolc}

{text-node} ::= {backtick}{text-node-value}{backtick}

{text-node-value} ::= Anything but {backtick}

{identifier} ::= {alphanumeric}+[{alphanumeric}*[-*{alphanumeric}*]]

{alphanumeric} ::= ((A|B|...|Z)*(a|b|...|z)*(0|1|...|9)*)*

{dq} ::= Double Quote Character (")

{backtick} ::= Backtick Character (`)

{eolc} ::= End of Line Character

{eofc} ::= End of File (Pseudo-)Character

{indent} ::= Two white spaces or a tab character. Depending on the first indent encountered in the input

{ws} ::= ({s}*{t}*)*

{s} ::= A Space Character

{t} ::= A Tab Character

```

Note: Indent of a child must be one {indent} greater than that of it's parent. I was unable to express this in Context Free Grammer. There is an issue regarding this.

