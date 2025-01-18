#ifndef PARSE_FUNC_H
#define PARSE_FUNC_H

#include <string.h>
#include <stdio.h>

#include "types.h"
#include "variables.h"


//--------------------------

/* определяет тип перменной или другого объекта */
Types
Define_type(const char* type){
    if(strcmp(type, "int") == 0)
        return INT_T;
    else if(strcmp(type, "double") == 0)
        return DOUBLE_T;
    else if(strcmp(type, "float") == 0)
        return FLOAT_T;
    else if(strcmp(type, "boolian") == 0)
        return BOOL_T;
    else if(strcmp(type, "char") == 0)
        return CHAR_T;
}


/* определяет тип для его записи в выходной файл */
char*
Define_type_for_write(Types type){
    if(type == INT_T)
        return "int";
    else if(type == DOUBLE_T)
        return "double";
    else if(type == BOOL_T)
        return "int";
    else if(type == FLOAT_T)
        return "float";
    else if(type == CHAR_T)
        return "char";

    return NULL;
}


/* заносит в выходной файл объявление перменной */
void
Write_in_Output__Def_Var(FILE* ofp, Variables* var){
    char* type = Define_type_for_write(var->type);
    fprintf(ofp, "%s %s;\n", type, var->name);
}

/* заносит в выходной файл определение с инициализацией перменной */
void
Write_in_Output__DefInit_Var(FILE* ofp, Variables* var){
    char* type = Define_type_for_write(var->type);

    if(type == "int")
        fprintf(ofp, "%s %s = %d;\n", type, var->name, var->value.int_value);
        
    else if(type == "boolian")
        fprintf(ofp, "%s %s = %d;\n", type, var->name, var->value.bool_value);
        
    else if(type == "float"){
        if(Is_int(var->value.float_value))
            fprintf(ofp, "int %s = %d;\n", var->name, (int)var->value.float_value);
        else
            fprintf(ofp, "%s %s = %f;\n", type, var->name, var->value.float_value);
    }
    else if(type == "double")
        fprintf(ofp, "%s %s = %f;\n", type, var->name, var->value.double_value);
        
    else if(type == "char")
        fprintf(ofp, "%s %s = '%c';\n", type, var->name, var->value.char_value);
}

/* заносит в выходной файл переопределение значения перменной */
void
Write_in_Output__Redefine_Var(FILE* ofp, Variables* first_var, Variables* second_var){
    fprintf(ofp, "%s = %s;\n", first_var->name, second_var->name);
}

#endif