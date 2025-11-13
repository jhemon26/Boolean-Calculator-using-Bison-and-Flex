%{/* Standard input output, library and manipulation functions*/
#include <stdio.h>         
#include <stdlib.h>
#include <string.h>

extern int yylex(void);       /* Calling the lexer function */
int yyerror(const char *message);   /* Calling the parser error function */
%}


%union {                     
    int bool_val;
}

%token <bool_val> TRUE FALSE
%token AND OR NOT
%type <bool_val> expression
%%

input:

  | input line
  ;

line:
    expression '\n'    { printf("%s\n", $1 ? "TRUE" : "FALSE"); }     
  ;

expression:
    TRUE            { $$ = $1; }         /* Return the true value */
  | FALSE           { $$ = $1; }         /* Return the false value */
  | expression expression AND   { $$ = $1 && $2; }   /* Return logical and of two expression */
  | expression expression OR    { $$ = $1 || $2; }   /* Return logical or of two expression */
  | expression NOT        { $$ = !$1; }        /* Negate the expression */
  ;

%%

int yyerror(const char *message) {            /* Calling the error function */
    fprintf(stderr, "Error: Invalid input Please type the correct one\n");
    return 0;
}

int main(void) {                        /* main funciton that gives user instruction and calls the parser */
  printf("\n");
  printf("Enter a boolean expression: Ex: -> TRUE FALSE & / tRuE FaLsE | \n");
  printf("The sign for AND(&), OR(|), NOT(') \n");
  printf("->> \n");
    return yyparse();
}
