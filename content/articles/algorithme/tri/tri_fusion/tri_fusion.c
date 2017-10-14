#include <stdio.h> 

#define TAILLE_MAX 1000

int tableau[TAILLE_MAX];
int taille;

void fusion(int debut, int milieu, int fin)
{
   int A[milieu - debut + 1];
   int B[fin - milieu];
   int iTab, indexA, indexB;

   for(indexA = 0, iTab = debut; iTab <= milieu; ++indexA, ++iTab)
      A[indexA] = tableau[iTab];
   for(indexB = 0, iTab = milieu + 1; iTab <= fin; ++indexB, ++iTab)
      B[indexB] = tableau[iTab];

   indexA = 0;
   indexB = 0;

   for(iTab = debut; iTab <= fin; ++iTab) {
      if(indexA == milieu - debut + 1) {
         tableau[iTab] = B[indexB];
         ++indexB;
      }
      else if(indexB == fin - milieu) {
         tableau[iTab] = A[indexA];
         ++indexA;
      }
      else if(A[indexA] <= B[indexB]) {
         tableau[iTab] = A[indexA];
         ++indexA;
      }
      else {
         tableau[iTab] = B[indexB];
         ++indexB;
      }
   }
}

void triFusion(int debut, int fin)
{
   if(debut != fin) {
      int milieu = (debut + fin) / 2;

      triFusion(debut, milieu);
      triFusion(milieu + 1, fin);

      fusion(debut, milieu, fin); 
   }
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);

   triFusion(0, taille - 1);

   for(iTab = 0; iTab < taille; ++iTab)
      printf("%d ", tableau[iTab]);
   printf("\n");

   return 0;
}
