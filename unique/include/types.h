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
typedef struct Variables{
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
    union{
        int integ;
        char* str;
        float flt;
        double dbl;
        int boolian;
    } values;
} Val_types;

#endif