#include <stdio.h>

int tableau[] = {1, 8, 7, 3, 4};
int taille = 5;

void echanger(int index1, int index2)
{
   int temporaire;

   temporaire = tableau[index1];
   tableau[index1] = tableau[index2];
   tableau[index2] = temporaire;
}

void triBulles(void)
{
   int nbParcours;
   int parcoursTab;

   for (nbParcours = 0; nbParcours < taille; ++nbParcours)
      for (parcoursTab = 0; parcoursTab < taille - 1; ++parcoursTab)
         if (tableau[parcoursTab] > tableau[parcoursTab + 1])
            echanger(parcoursTab, parcoursTab + 1);   
}

int main(void)
{
   int index;

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   printf("\n\n");

   triBulles();

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   return 0;
}
