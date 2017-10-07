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

void triSelection(void)
{
   int iElement, iTab;
   int min;

   for(iElement = 0; iElement < taille; ++iElement) {
      min = iElement;

      for(iTab = iElement + 1; iTab < taille; ++iTab)
         if(tableau[iTab] < tableau[min])
            min = iTab;

      if(min != iElement)
         echanger(iElement, min);
   }
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);

   triSelection();

   for(iTab = 0; iTab < taille; ++iTab)
      printf("%d ", tableau[iTab]);
   printf("\n");

   return 0;
}
