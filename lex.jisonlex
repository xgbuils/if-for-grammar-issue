/* test.jisonlex */
   
digit                       [0-9]
id                          [$_a-zA-Z][\w$]*
string                      ['](\\['"]|[^'])*[']|["](\\['"]|[^"])*["]
comment                     //[^\n]*|/\*([^*]|\*[^/])*\*/

%%

{string}                    return 'STRING';
"if"                        return 'IF';
"else"                      return 'ELSE';
"for"                       return 'FOR';
"var"                       return 'VAR';
"="                         return 'ASSIGN';
","                         return 'COMMA';
"{"                         return 'LBRACE';
"}"                         return 'RBRACE';
"("                         return 'LPAREN';
")"                         return 'RPAREN';
";"                         return 'SEMICOLON';
\s+                         /* skip whitespace */
{digit}+                    return 'NUMBER';
{id}                        return 'IDENTIFIER';
"."                         throw 'Illegal character';
<<EOF>>                     return 'ENDOFFILE';