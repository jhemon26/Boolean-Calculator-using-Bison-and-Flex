%{
#include "boolcalc.tab.h"           /* Include the token definitions */
#include <string.h>                 /* Include the string functions */                
#include <ctype.h>                  /* Include the character functions */

int yyerror(const char *message);   /* Declare the error function */
%}

%%
[tT][rR][uU][eE]      { yylval.bool_val = 1; return TRUE; }   /* If match TRUE, return TRUE as token */
[fF][aA][lL][sS][eE]  { yylval.bool_val = 0; return FALSE; }  /* If match FALSE, return FALSE as token */

"&"                   { return AND; }  /* If match &, return AND as token */
"|"                   { return OR; }   /* If match |, return OR as token */
"'"                   { return NOT; }  /* If match "'", return NOT as token */

[ \t]+               ;                 /* Ignore whitespace */
\n                   { return '\n'; }  /* If match newline, return newline as token */

.                    { yyerror("incorrect character"); }  /* here if no match found then error fucn */
%%

int yywrap() {       /* Function to wrap up the lexer*/
    return 1;        /* Returning 1 instead of 0 to indicate the end of the input */
}   
