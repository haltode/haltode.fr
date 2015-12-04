#include <stdio.h>

int tableau[] = {9, 2, 7, 1};
int taille = 4;

void triInsertion(void)
{
   int parcoursTab;

   for (parcoursTab = 0; parcoursTab < taille; ++parcoursTab)
   {
      int nbAinsere = tableau[parcoursTab];
      int position;

      for(position = parcoursTab; position > 0 && nbAinsere < tableau[position - 1]; --position)
         tableau[position] = tableau[position - 1];

      tableau[position] = nbAinsere;
   }
}

int main(void)
{
   int index;

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   printf("\n\n");

   triInsertion();

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   return 0;
}
