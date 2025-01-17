#ifndef TYPES_H
#define TYPES_H

#include <string.h>


/* перечисления всех типов */
typedef enum{
    INT_T,
    CHAR_T,
    BOOL_T,
    DOUBLE_T,
    FLOAT_T
} Types;

/* структура перменной */
typedef struct{
    char* name;
    Types type;
    union{
        int int_value;
        int bool_value;
        char* char_value;
        double double_value;
        float float_value;
    } value;
} Variables;

/* для "val" в файле uq.y */
typedef struct Val_types{
    //enum { INT, CHR, FLT, DBL, BOOL } type;
    union{
        int integ;
        char* str;
        float flt;
        double dbl;
        int boolian;
    } values;
} Val_types;


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

#endif