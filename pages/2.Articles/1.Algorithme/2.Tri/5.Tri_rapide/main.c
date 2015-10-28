#include <stdio.h>

int tableau[] = {5, 9, 7, 3, 8};
int taille = 5;

void echanger(int index1, int index2)
{
   int temporaire;

   temporaire = tableau[index1];
   tableau[index1] = tableau[index2];
   tableau[index2] = temporaire;
}

void triRapide(int debut, int fin)
{
   int indexTab;
   int dernierEmplacement;

   if(debut >= fin)
      return;

   echanger(debut, (debut + fin) / 2);
   dernierEmplacement = debut;

   for(indexTab = debut + 1; indexTab <= fin; ++indexTab)
   {
      if(tableau[indexTab] < tableau[debut])
      {
         ++dernierEmplacement;
         echanger(dernierEmplacement, indexTab);
      }
   }

   echanger(debut, dernierEmplacement);

   triRapide(debut, dernierEmplacement - 1);
   triRapide(dernierEmplacement + 1, fin);
}

int main(void)
{
   int index;

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   printf("\n\n");

   triRapide(0, taille - 1);

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   return 0;
}
