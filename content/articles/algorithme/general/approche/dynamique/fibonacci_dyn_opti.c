#include <stdio.h>

#define PAS_CALCULE -1

unsigned long long fibonacci(int n)
{
   unsigned long long prochain, actuel, dernier;
   int iTerme;

   actuel = 1;
   dernier = 0;

   for(iTerme = 2; iTerme <= n; ++iTerme) {
      prochain = actuel + dernier;

      dernier = actuel;
      actuel = prochain;
   }

   return actuel;
}

int main(void)
{
   int n;
   
   scanf("%d\n", &n);
   if(n == 0)
      printf("0\n");
   else
      printf("%lld\n", fibonacci(n));

   return 0;
}
