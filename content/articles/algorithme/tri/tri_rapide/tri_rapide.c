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

void triRapide(int debut, int fin)
{
   int iTab;
   int dernierEmplacement;

   if(debut >= fin)
      return;

   echanger(debut, (debut + fin) / 2);
   dernierEmplacement = debut;

   for(iTab = debut + 1; iTab <= fin; ++iTab) {
      if(tableau[iTab] < tableau[debut]) {
         ++dernierEmplacement;
         echanger(dernierEmplacement, iTab);
      }
   }

   echanger(debut, dernierEmplacement);

   triRapide(debut, dernierEmplacement - 1);
   triRapide(dernierEmplacement + 1, fin);
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);

   triRapide(0, taille - 1);

   for(iTab = 0; iTab < taille; ++iTab)
      printf("%d ", tableau[iTab]);
   printf("\n");

   return 0;
}
