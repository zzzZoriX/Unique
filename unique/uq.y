%{

#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdlib.h>

#include "./include/types.h"
#include "./include/parse_func.h"
#include "./include/variables.h"

int yylex();
int yyerror(const char* err_m);

FILE* ofp;

extern FILE* yyin;

extern int Total_var_count;
extern Variables All_vars[200];

%}

%union {
    int integ;
    float flt;
    double dbl;
    int boolian;
    char* str;
    struct Val_types* types;
};

%token <str> TYPE IDENT
%token ASSIG SEMIC COLON

%token <integ> INT
%token <str> CHR
%token <flt> FLT
%token <dbl> DBL
%token <boolian> BOOL

%type <types> value

%%

variables: /* nothing */
    | variables init_variable
    ;

init_variable:
    TYPE COLON IDENT SEMIC{
        printf("%s : %s ;\n", $1, $3);
        All_vars[Total_var_count].name = strdup($3);
        All_vars[Total_var_count].type = Define_type($1);
        
        Write_in_Output__Def_Var(ofp, All_vars[Total_var_count]);
        
        ++Total_var_count;

    }
    | TYPE COLON IDENT ASSIG value SEMIC{
        All_vars[Total_var_count].name = strdup($3);
        All_vars[Total_var_count].type = Define_type($1);
        switch (All_vars[Total_var_count].type) {
            case INT_T:
                All_vars[Total_var_count].value.int_value = $5->values.integ;
                break;
            case FLOAT_T:
                All_vars[Total_var_count].value.float_value = $5->values.flt;
                break;
            case CHAR_T:
                All_vars[Total_var_count].value.char_value = $5->values.str;
                break;
            case DOUBLE_T:
                All_vars[Total_var_count].value.double_value = $5->values.dbl;
                break;
            case BOOL_T:
                All_vars[Total_var_count].value.bool_value = $5->values.boolian;
                break;

            default:
                printf("Unknown variable type. %s", $3);
        }
        Write_in_Output__DefInit_Var(ofp, All_vars[Total_var_count]);

        ++Total_var_count;
    }
    ;

value:
    INT { 
            $$ = malloc(sizeof(struct Val_types));
            $$->values.integ = $1; 
    }
    | FLT { 
            $$ = malloc(sizeof(struct Val_types));
            $$->values.flt = $1; 
    }
    | DBL { 
            $$ = malloc(sizeof(struct Val_types));
            $$->values.dbl = $1; 
    }
    | BOOL { 
            $$ = malloc(sizeof(struct Val_types));
            $$->values.boolian = $1; 
    }
    | CHR { 
            $$ = malloc(sizeof(struct Val_types));
            $$->values.str = strdup($1); 
    }
    ;

%%

int yyerror(const char* err_m){
    fprintf(stderr, "Error: %s\n", err_m);
    return 0;
}

int main(int argc, char** argv){
    
    if(argc < 3){
        printf("correct use: %s <input_file> <output_file>", argv[0]);
        return 1;
    }

    ofp = fopen(argv[2], "w");
    if(!ofp){
        perror("Error occured while opening output file!");
        return 1;
    }
    FILE* ifp = fopen(argv[1], "r");
    if(!ifp){
        perror("Error occured while opening input file!");
        return 1;
    }

    yyin = ifp;

    fprintf(ofp, "#include <stdio.h>\n#include \"./include/types.h\"\n\nint main(){\n\n");

    yyparse();

    fprintf(ofp, "  return 0;\n}");

    fclose(ofp);
    fclose(ifp);

    for(int i = 0; i < Total_var_count; ++i){
        free(All_vars[i].name);
    }
    
    return 0;
}