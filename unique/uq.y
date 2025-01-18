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

%}

%union {
    int integ;
    float flt;
    double dbl;
    int boolian;
    char chr;
    char* str;
    struct Variables* var;
    struct Val_types* types;
};

%token <str> TYPE 
%token <var> IDENT
%token ASSIGN SEMIC COLON LBRACKET RBRACKET
%token INFO_PRINT

%token <integ> INT
%token <chr> CHR
%token <flt> FLT
%token <dbl> DBL
%token <boolian> BOOL

%type <types> value

%%

start: parse_objects;

parse_objects:
    variables
    |
    commands
    ;

variables:
    variable
    ;

commands:
    var_com
    ;

var_com:
    var_info
    ;

variable:
    TYPE COLON IDENT SEMIC{
        $3->type = Define_type($1);
        
        Write_in_Output__Def_Var(ofp, $3);

    }
    | TYPE COLON IDENT ASSIGN value SEMIC{
        $3->type = Define_type($1);
        switch ($3->type) {
            case INT_T:
                $3->value.int_value = $5->values.integ;
                break;
            case FLOAT_T:
                $3->value.float_value = $5->values.flt;
                break;
            case CHAR_T:
                $3->value.char_value = $5->values.chr;
                break;
            case DOUBLE_T:
                $3->value.double_value = $5->values.dbl;
                break;
            case BOOL_T:
                $3->value.bool_value = $5->values.boolian;
                break;

            default:
                printf("Unknown variable type. %s", $3->name);
        }
        Write_in_Output__DefInit_Var(ofp, $3);
    }
    | IDENT ASSIGN IDENT SEMIC {
        Assign_to_another_var($1, $3);

        Write_in_Output__Redefine_Var(ofp, $1, $3);
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
            $$->values.chr = $1; 
    }
    ;

var_info:
    INFO_PRINT LBRACKET IDENT RBRACKET SEMIC {
        char* var_type = Define_type_for_write($3->type);
        if($3->type == BOOL_T)
            fprintf(ofp, "printf(\"name: %s\\nvalue: %d\\ntype: %s\\n\");\n", $3->name, $3->value.bool_value, var_type);
        else if(var_type == "float")
            fprintf(ofp, "printf(\"name: %s\\nvalue: %f\\ntype: %s\\n\");\n", $3->name, $3->value.float_value, var_type);
        else if(var_type == "double")
            fprintf(ofp, "printf(\"name: %s\\nvalue: %lf\\ntype: %s\\n\");\n", $3->name, $3->value.double_value, var_type);
        else if(var_type == "int")
            fprintf(ofp, "printf(\"name: %s\\nvalue: %d\\ntype: %s\\n\");\n", $3->name, $3->value.int_value, var_type);
        else if(var_type == "char")
            fprintf(ofp, "printf(\"name: %s\\nvalue: %c\\ntype: %s\\n\");\n", $3->name, $3->value.char_value, var_type);
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

    fprintf(ofp, "#include <stdio.h>\n#include <stdbool.h>\nint main(){\n");

    yyparse();

    fprintf(ofp, "return 0;\n}");

    fclose(ofp);
    fclose(ifp);
    
    return 0;
}