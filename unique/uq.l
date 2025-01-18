%{

#include <string.h>
#include <stdlib.h>
#include "uq.tab.h"

#include "./include/types.h"

%}

%option noyywrap

%%

"int"|"char"|"boolian"|"float"|"double"     { yylval.str = strdup(yytext); return TYPE; }

"print_info"                                { return INFO_PRINT; }

[0-9]+                                      { yylval.integ = atoi(yytext); return INT; }
[0-9]+\.[0-9]+                              { yylval.dbl = atof(yytext); return DBL; }
[0-9]+"f"                                   { yylval.flt = atof(yytext); return FLT; }
[0-9]+\.[0-9]+"f"                           { yylval.flt = atof(yytext); return FLT; }
"true"|"false"                              { yylval.boolian = (strcmp(yytext, "true") == 0); return BOOL; }
'.[^']*'                                     { 
                                                if(yytext[2] == '\'' && yytext[0] != '\0'){
                                                    yylval.chr = yytext[1]; 
                                                    return CHR; 
                                                }
                                            }

"="                                         { return ASSIGN; }
";"                                         { return SEMIC; }
":"                                         { return COLON; }
"("                                         { return LBRACKET; }
")"                                         { return RBRACKET; }

[a-zA-Z_][a-zA-Z0-9_]*                      { 
                                                yylval.var = malloc(sizeof(Variables));
                                                yylval.var->name = strdup(yytext); 
                                                return IDENT; 
                                            } 

[ \t\n]                                     ; // nothing

.                                           printf("Unknown symbol \"%s\"\n", yytext);

%%