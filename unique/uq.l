%{

#include <string.h>
#include "uq.tab.h"

%}

%option noyywrap

%%

"int"|"char"|"boolian"|"float"|"double"     { yylval.str = strdup(yytext); return TYPE; }

[0-9]+                                      { yylval.integ = atoi(yytext); return INT; }
[0-9]+\.[0-9]+                              { yylval.flt = atof(yytext); return FLT; }
// дабл будет добавлен позже
"true"|"false"                              { yylval.boolian = (strcmp(yytext, "true") == 0); return BOOL; }
'.'                                         { yylval.str = strdup(yytext); return CHR; }

"="                                         { return ASSIG; }
";"                                         { return SEMIC; }
":"                                         { return COLON; }

[a-zA-Z_][a-zA-Z0-9_]*                      { yylval.str = strdup(yytext); return IDENT; } 

[ \t\n]                                     ; // nothing

.                                           printf("Unknown symbol \"%s\"\n", yytext);

%%
