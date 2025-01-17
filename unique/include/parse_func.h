#ifndef PARSE_FUNC_H
#define PARSE_FUNC_H

#include <string.h>
#include <stdio.h>

#include "types.h"


/* для информации про все переменные */
int Total_var_count = 0;
Variables All_vars[200];

/* ищет переменную по имени */
Variables*
Find_var(const char* name){
    for(int i = 0; i < sizeof(All_vars); ++i){
        if(All_vars[i].name == name){
            return &All_vars[i];
        }
    }
}

/* определяет тип для его записи в выходной файл */
char*
Define_type_for_write(Types type){
    if(type == INT_T)
        return "int";
    else if(type == DOUBLE_T)
        return "double";
    else if(type == BOOL_T)
        return "boolian";
    else if(type == FLOAT_T)
        return "float";
    else if(type == CHAR_T)
        return "char";

    return NULL;
}


/* заносит в выходной файл объявление перменной */
void
Write_in_Output__Def_Var(FILE* ofp, Variables var){
    char* type = Define_type_for_write(var.type);
    fprintf(ofp, "  %s %s;\n", type, var.name);
}

void
Write_in_Output__DefInit_Var(FILE* ofp, Variables var){
    char* type = Define_type_for_write(var.type);

    if(type == "int")
        fprintf(ofp, "  %s %s = %d;\n", type, var.name, var.value.int_value);
        
    else if(type == "boolian")
        fprintf(ofp, "  %s %s = %d;\n", type, var.name, var.value.bool_value);
        
    else if(type == "float")
        fprintf(ofp, "  %s %s = %f;\n", type, var.name, var.value.float_value);
        
    else if(type == "double")
        fprintf(ofp, "  %s %s = %f;\n", type, var.name, var.value.double_value);
        
    else if(type == "char")
        fprintf(ofp, "  %s %s = %c;\n", type, var.name, var.value.char_value);
}

#endif