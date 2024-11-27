    /* calculator #1 */
%{
    #include "calcu.tab.h"
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

[a-z]       {
                yylval = *yytext - 'a';
                return VARIABLE;
                }

[1-9][0-9]* {
                yylval = atoi(yytext);
                return INTEGER;
            }

[-+()=/*\n]     { return *yytext; }

[ \t]   ;       /* skip whitespace */

.               yyerror("Caracter invalido!");

%%

int yywrap(void) {
    return 1;
}
