    /* test.jison */
    
    %{
        function toText(arr) {
            var text = ''
    
            var indent = 0
            var beforeEndLine = false
            for (var i in arr) {
                if (typeof arr[i] === 'string') {
                    if (beforeEndLine) {
                        for(var j = 0; j < indent; ++j)
                            text += '    '
                    }
                    text += arr[i]
                    beforeEndLine = false
                } else if(arr[i] === 0) {
                    if (!beforeEndLine) {
                        text += '\n'
                        beforeEndLine = true
                    }
                } else if(arr[i] === 1) {
                    ++indent
                } else if(arr[i] === -1) {
                    --indent
                } else {
                    text += '@@@ERROR@@@'
                }
            }
            return text
        }
        
    %}
    
    %right ASSIGN
    
    %%
    
    pgm
        : stmts ENDOFFILE
            {$$ = $1; console.log(toText($$))}
        ;
    
    stmts
        : stmt semicolon stmts
            {$$ = $1.concat([0], $3)}
        |
            {$$ = []}
        ;

    stmt
        : FOR LPAREN varlist_decl SEMICOLON expr SEMICOLON expr RPAREN stmt
            {$$ = ['for ('].concat($3, ['; '], $5, ['; '], $7, [') '], $9)}
        | varlist_decl 
            {$$ = $1}
        | expr
            {$$ = $1}
        | LBRACE stmts RBRACE
            {$$ = ['{', 0, 1].concat($2, [0, -1, '}'])}
        ;
    
    varlist_decl
        : init_varlist_decl rest_varlist_decl
            {$$ = $1.concat($2)}
        ;
    
    init_varlist_decl
        : VAR identifier ASSIGN expr
            {$$ = ['var ', $2, ' = '].concat($4)}
        | VAR identifier
            {$$ = ['var ', $2]}
        ;
    
    rest_varlist_decl
        : COMMA identifier ASSIGN expr rest_varlist_decl
            {$$ = [0, '  , ', $2, ' = '].concat($4, $5)}
        | COMMA identifier rest_varlist_decl
            {$$ = [0, '  , ', $2].concat($3);}
        |
            {$$ = [];}
        ;
    
    expr
        : NUMBER
            {$$ = [yytext]}
        | identifier
            {$$ = [$1]}
        ;
    
    identifier
        : IDENTIFIER
            {$$ = yytext}
        ;
    
    semicolon
        : SEMICOLON
        |
        ;