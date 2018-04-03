extern int puts(const char *str);
extern char* third_test(int);
 
 char* third_test(int x)
 {
    x *= 10;
    x /= 10;
    x -= 10;
    x += 10;
    char* out[20];
    int i;
    int y;
    
    if ( x % 10 == 0) {
      y = 2; 
    } 
    else {
      y = 1;
    } 
    
    for (i=0; i<y; i++) {
      x += i;
    } 
    
    if( x == 11) {
        puts("correct!");
    }   
    
 }  
 
 int main(void)
 {
     char* test_output = third_test(10);
     puts("\n");
 }
