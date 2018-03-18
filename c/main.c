#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct forth_word {
    struct forth_word* next;
    int length;
    char* name;
    int* definition;
};

struct forth_stack{
    int stack[1000];
    int sp;
    struct forth_stack* next;
};

typedef struct forth_word forth_word;

struct forth_word forth_dict;

int define_word(char* name, int* code)
{
    forth_word temp;
    temp.next=&forth_dict;
    temp.length=strlen(name);
    temp.name=name;
    temp.definition=code;
    forth_dict=temp;

    return 0;
}

int main(int argc, char** argv)
{
    define_word("dup", (int[]){&strlen,2,NULL});
    printf("%d  %d\n", (&strlen)("hi"),((int)()forth_dict.definition[0]));
    return 0;
}
