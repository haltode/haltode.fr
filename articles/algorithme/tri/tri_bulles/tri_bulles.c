#include <stdio.h>

#define TAILLE_MAX 1000

int tableau[TAILLE_MAX];
int taille;

void echanger(int index1, int index2)
{
   int temp;

   temp = tableau[index1];
   tableau[index1] = tableau[index2];
   tableau[index2] = temp;
}

void triBulles(void)
{
   int iElement, iTab;

   for(iElement = 0; iElement < taille; ++iElement)
      for(iTab = 0; iTab < taille - 1; ++iTab)
         if(tableau[iTab] > tableau[iTab + 1])
            echanger(iTab, iTab + 1);
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);

   triBulles();

   for(iTab = 0; iTab < taille; ++iTab)
      printf("%d ", tableau[iTab]);
   printf("\n");

   return 0;
}
