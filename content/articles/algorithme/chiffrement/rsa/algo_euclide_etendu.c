#include <stdio.h>

void euclideEtendu(int a, int b)
{
   int r0, r1;
   int s0, s1;
   int t0, t1;
   int i;
   int q, r, s, t;

   r0 = a;
   s0 = 1;
   t0 = 0;

   r1 = b;
   s1 = 0;
   t1 = 1;

   r = 42;
   for(i = 2; r != 0; ++i) {
      q = r0 / r1;
      r = r0 - q * r1;
      s = s0 - q * s1;
      t = t0 - q * t1;

      r0 = r1;
      r1 = r;
      s0 = s1;
      s1 = s;
      t0 = t1;
      t1 = t;
   }

   printf("x = %d\n", s0);
   printf("y = %d\n", t0);
}

int main(void)
{
   int a, b;
   scanf("%d %d\n", &a, &b);

   euclideEtendu(a, b);   

   return 0;
}
