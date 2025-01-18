#ifndef TYPES_H
#define TYPES_H

#include <string.h>
#include <stdio.h>
#include <stdint.h>


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
        char char_value;
        double double_value;
        float float_value;
    } value;
} Variables;

/* для "val" в файле uq.y */
typedef struct Val_types{
    union{
        int integ;
        char chr;
        float flt;
        double dbl;
        int boolian;
    } values;
} Val_types;


/*
взято с https://ru.stackoverflow.com/questions/1296923/%D0%BA%D0%B0%D0%BA-%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%B8%D1%82%D1%8C-%D1%86%D0%B5%D0%BB%D0%BE%D0%B5-%D0%BB%D0%B8-%D1%87%D0%B8%D1%81%D0%BB%D0%BE-%D1%8F%D0%B7%D1%8B%D0%BA-%D1%81%D0%B8
*/
static inline int Is_int ( double d ) {
    return d == (double)(int64_t)d ;
}

#endif