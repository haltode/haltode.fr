#include <stdio.h>

unsigned long long fibonacci(int n)
{
   if(n <= 1)
      return n;
   return fibonacci(n - 1) + fibonacci(n - 2);
}

int main(void)
{
   int n;
   
   scanf("%d\n", &n);
   printf("%lld\n", fibonacci(n));

   return 0;
}
