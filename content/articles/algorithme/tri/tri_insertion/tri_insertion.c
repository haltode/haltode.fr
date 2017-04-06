#include <stdio.h>

#define TAILLE_MAX 1000

int tableau[TAILLE_MAX];
int taille;

void triInsertion(void)
{
   int iTab;

   for(iTab = 0; iTab < taille; ++iTab) {
      int aInserer;
      int position;

      aInserer = tableau[iTab];

      position = iTab;
      while(position > 0 && aInserer < tableau[position - 1]) {
         tableau[position] = tableau[position - 1];
         --position;
      }

      tableau[position] = aInserer;
   }
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);

   triInsertion();

   for(iTab = 0; iTab < taille; ++iTab)
      printf("%d ", tableau[iTab]);
   printf("\n");

   return 0;
}
