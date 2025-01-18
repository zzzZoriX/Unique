#ifndef VARIABLES_H
#define VARIABLES_H

#include "types.h"
// #include "parse_func.h"

int
Define_type_int(Types type){
    if(type == INT_T)
        return 1;
    else if(type == DOUBLE_T)
        return 2;
    else if(type == BOOL_T)
        return 3;
    else if(type == FLOAT_T)
        return 4;
    else if(type == CHAR_T)
        return 5;

    return 6;
}

/* 
переопределяет значение перменной значением другой перменной 
a = b

не готова
*/
void
Assign_to_another_var(Variables* redef_var, Variables* redef_val_var){
    if(Define_type_int(redef_var->type) != Define_type_int(redef_val_var->type)){
        fprintf(stderr, "Variables type don't match\n");
        printf("%d %d", redef_var->type, redef_val_var->type);
        return;
    }
    printf("%d %d\n", Define_type_int(redef_var->type), Define_type_int(redef_val_var->type));
    redef_var->value = redef_val_var->value;
}

#endif