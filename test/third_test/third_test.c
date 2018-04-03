// Third test written in C to include 28 MIPS instructions

#include <stdio.h>

extern int puts(const char *str);

int third_test(int x)
{
   x *= 10;
   x /= 10;
   x -= 10;
   x += 10;

   if ( x % 10 == 0) {
     int y = 2;
   }
   else {
     int y = 1;
   }

   for (int i=0; i<y; i++) {
     x += i;
   }

   return x;

}

int main(void)
{
    int test_output = third_test(10);
    puts("Result is:");
    puts(test_output); // output should be
    puts("\n");
}
