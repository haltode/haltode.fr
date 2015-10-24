#include <stdio.h> 

int tableau[] = {5, 1, 3, 8, 9, 6};
int taille = 6;

void fusion(int debut, int milieu, int fin)
{
   int A[milieu - debut + 1];
   int B[fin - milieu];
   int indexTab, indexA, indexB;

   for(indexA = 0, indexTab = debut; indexTab <= milieu; ++indexA, ++indexTab)
      A[indexA] = tableau[indexTab];
   for(indexB = 0, indexTab = milieu + 1; indexTab <= fin; ++indexB, ++indexTab)
      B[indexB] = tableau[indexTab];

   indexA = 0;
   indexB = 0;

   for(indexTab = debut; indexTab <= fin; ++indexTab)
   {
      if(indexA == milieu - debut + 1)
      {
         tableau[indexTab] = B[indexB];
         ++indexB;
      }
      else if(indexB == fin - milieu)
      {
         tableau[indexTab] = A[indexA];
         ++indexA;
      }
      else if(A[indexA] <= B[indexB])
      {
         tableau[indexTab] = A[indexA];
         ++indexA;
      }
      else
      {
         tableau[indexTab] = B[indexB];
         ++indexB;
      }
   }
}

void triFusionRecursif(int debut, int fin)
{
   if(debut != fin)
   {
      int milieu = (debut + fin) / 2;

      triFusionRecursif(debut, milieu);
      triFusionRecursif(milieu + 1, fin);

      fusion(debut, milieu, fin); 
   }
}

void triFusion(void)
{
   triFusionRecursif(0, taille - 1);
}

int main(void)
{
   int index;

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   printf("\n\n");

   triFusion();

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);
   printf("\n");

   return 0;
}
