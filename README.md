
`$ node node_modules/jison/lib/cli.js for.jison lex.jisonlex`
OK!

```
$ node for.js fortest.jsvar x = 1
  , y
  , w
for (var i
  , j = 1; x; 3) {
    a
    b
    3
}
```
OK!

`$ node node_modules/jison/lib/cli.js if.jison lex.jisonlex`
OK!

```
$ node if.js iftest.jsvar x = 1
  , y
  , w
if (1) 
{
    if (2) 
        if (c) 
            r
        else 
        {
            b
            a
        }
    else 
        c
    b
}
```
OK!

```
$ node node_modules/jison/lib/cli.js combined.jison lex.jisonlex 
Conflict in grammar: multiple actions possible when lookahead token is ELSE in state 36
- reduce by rule: stmt -> closed_stmt
- shift token (then go to state 40)

States with conflicts:
State 36
  closed_stmt -> IF LPAREN expr RPAREN closed_stmt .ELSE closed_stmt #lookaheads= SEMICOLON LBRACE IDENTIFIER NUMBER VAR FOR IF ENDOFFILE RBRACE ELSE
  non_closed_stmt -> IF LPAREN expr RPAREN closed_stmt .ELSE non_closed_stmt #lookaheads= SEMICOLON LBRACE IDENTIFIER NUMBER VAR FOR IF ENDOFFILE RBRACE ELSE
  stmt -> closed_stmt . #lookaheads= ENDOFFILE IF FOR VAR NUMBER IDENTIFIER LBRACE SEMICOLON RBRACE ELSE
```
FAIL!


http://stackoverflow.com/questions/26026881/jison-conflict-in-grammar-when-if-else-and-for-statements-ara-combined