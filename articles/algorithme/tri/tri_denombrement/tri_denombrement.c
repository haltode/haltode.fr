#include <stdio.h>
#include <stdlib.h>

#define TAILLE_MAX 1000

int tableau[TAILLE_MAX];
int taille;

void triDenombrement(void)
{
   int iTab, iEffectif;
   int max;
   int *effectif;

   max = -42;
   for(iTab = 0; iTab < taille; ++iTab)
      if(tableau[iTab] > max)
         max = tableau[iTab];

   effectif = calloc(max + 1, sizeof(int));

   for(iTab = 0; iTab < taille; ++iTab)
      ++effectif[tableau[iTab]];

   for(iEffectif = 0, iTab = 0; iEffectif <= max; ++iEffectif) {
      int iCopie;
      for(iCopie = 0; iCopie < effectif[iEffectif]; ++iCopie) {
         tableau[iTab] = iEffectif;
         ++iTab;
      }
   }

   free(effectif);
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);

   triDenombrement();

   for(iTab = 0; iTab < taille; ++iTab)
      printf("%d ", tableau[iTab]);
   printf("\n");

   return 0;
}
