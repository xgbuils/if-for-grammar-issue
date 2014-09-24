    /* test.jison */
    
    %{
        function toText(arr) {
            var text = ''
            var wait = 7
    
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
        : closed_stmt
            {$$ = $1}
        | non_closed_stmt
            {$$ = $1}
        ;
    
    closed_stmt
        : IF LPAREN expr RPAREN closed_stmt ELSE closed_stmt
            {$$ = ['if ('].concat($3, [') ', 0 , 1], $5, [0, -1, 'else ', 0, 1], $7, [0, -1])}
        /*| FOR LPAREN varlist_decl SEMICOLON expr SEMICOLON expr RPAREN stmt
            {$$ = ['for ('].concat($3, ['; '], $5, ['; '], $7, [') '], $9)}*/
        | varlist_decl 
            {$$ = $1}
        | expr
            {$$ = $1}
        | LBRACE stmts RBRACE
            {$$ = [-1, '{', 0, 1].concat($2, [0, -1, '}', 1])}
        ;

    non_closed_stmt
        : IF LPAREN expr RPAREN stmt
            {$$ = ['if ('].concat($3, [') ', 0, 1], $5, [0, -1])}
        | IF LPAREN expr RPAREN closed_stmt ELSE non_closed_stmt
            {$$ = ['if ('].concat($3, [') ', 0, 1], $5, [0, -1, 'else ', 0, 1], $7, [0, -1])}
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