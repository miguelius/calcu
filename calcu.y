%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char *);
    int yylex(void);

    int tabla[26];
%}

%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

program:
        program statement '\n'
        | /* NULL */
        ;

statement:
        expression                      { printf("%d\n", $1); }
        | VARIABLE '=' expression       { tabla[$1] = $3; }
        ;

expression:
        INTEGER                         /* default action { $$ = $1; }*/
        | VARIABLE                      { $$ = tabla[$1]; }
        | expression '+' expression     { $$ = $1 + $3; }
        | expression '-' expression     { $$ = $1 - $3; }
        | expression '*' expression     { $$ = $1 * $3; }
        | expression '/' expression     { $$ = $1 / $3; }
        | '-' expression %prec UMINUS   { $$ = -$2;}
        | '(' expression ')'            { $$ = $2; }
        ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
}
