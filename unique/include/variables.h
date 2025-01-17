#ifndef VARIABLES_H
#define VARIABLES_H

#include "types.h"


/* создает перменную */
Variables
Define_variable(const char* TYPE, char* name){
    Variables new_var;

    if(TYPE == "int")
        new_var.type = INT_T;
    else if(TYPE == "boolian")
        new_var.type = BOOL_T;
    else if(TYPE == "float")
        new_var.type = FLOAT_T;
    else if(TYPE == "double")
        new_var.type = DOUBLE_T;
    else if(TYPE == "char")
        new_var.type = CHAR_T;

    new_var.name = name;

    return new_var;
}

#endif