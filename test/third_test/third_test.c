// Third test written in C to include 28 MIPS instructions

#include <stdio.h>

extern int puts(const char *str);

int third_test(int x)
{
   if ( n == 0 )
      return 0;
   else if ( n == 1 )
      return 1;
   else
      return ( fibonacci(n-1) + fibonacci(n-2) );
}

int main(void)
{
    int test_output = third_test(10);
    puts("Result is:");
    puts(test_output);
    puts("\n");
}
