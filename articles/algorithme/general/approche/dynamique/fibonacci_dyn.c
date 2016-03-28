#include <stdio.h>

#define N_MAX 100000
#define PAS_CALCULE -1

unsigned long long resultat[N_MAX + 1];

unsigned long long fibonacci(int n)
{
   if(n <= 1)
      return n;
   if(resultat[n] != PAS_CALCULE)
      return resultat[n];

   resultat[n] = fibonacci(n - 1) + fibonacci(n - 2);
   return resultat[n];
}

int main(void)
{
   int n;
   int iRes;
   
   scanf("%d\n", &n);

   for(iRes = 0; iRes <= n; ++iRes)
      resultat[iRes] = PAS_CALCULE;

   printf("%lld\n", fibonacci(n));

   return 0;
}
