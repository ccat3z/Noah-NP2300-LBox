#include <stdio.h>

int main (int argc,char *argv[])
{
    if (argc < 3)
    {
        printf("Usage:pluschar [char] [num]");
        return 0;
    }
    printf ("%c",argv[1][0]+atoi(argv[2])) ;
    return 0;
}