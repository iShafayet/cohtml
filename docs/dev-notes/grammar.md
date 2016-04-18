
This file adheres to the [Backus–Naur Form](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form) and [Extended Backus–Naur Form](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_Form). Angular braces are replaced with Curly Braces due to the issues with Markdown preview.



```

{statement} ::= {indent}*({tag}|{text-node}){ws}{eolc}

{tag} ::= {tag-head}{ws}{tag-tail}[{scope}]

{tag-head} ::= {tag-name}[${tag-id}][(.{tag-class})+]

{tag-name} ::= {identifier}

{tag-id} ::= {identifier}

{tag-class} ::= {identifier}

{tag-tail} ::= ({tag-attribute}[="{tag-attribute-value}"])*[|{inline-text}]

{tag-attribute} ::= {identifier}

{tag-attribute-value} ::= Anything but "

{inline-text} ::= Anything but {eolc}

{text-node} ::= `{text-node-value}`

{text-node-value} ::= Anything but `

{identifier} ::= {alphanumeric}+[{alphanumeric}*[-*{alphanumeric}*]]

{alphanumeric} ::= ((A|B|...|Z)*(a|b|...|z)*(0|1|...|9)*)*

{eolc} ::= End of Line Character

{indent} ::= Two white spaces or a tab character. Depending on the first indent encountered in the input

{ws} ::= ({s}*{t}*)*

{s} ::= A Space Character

{t} ::= A Tab Character


```