#include <stdio.h>

int tableau[] = {6, 1, 9, 3};
int taille = 4;

void echanger(int index1, int index2)
{
   int temporaire;

   temporaire = tableau[index1];
   tableau[index1] = tableau[index2];
   tableau[index2] = temporaire;
}

void triSelection(void)
{
   int parcoursTab, parcoursElement;
   int min;

   for(parcoursTab = 0; parcoursTab < taille; ++parcoursTab)
   {  
      min = parcoursTab;

      for(parcoursElement = min + 1; parcoursElement < taille; ++parcoursElement)
         if(tableau[parcoursElement] < tableau[min])
            min = parcoursElement;

      if(min != parcoursTab)
         echanger(parcoursTab, min);
   }
}

int main(void)
{
   int index;

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   printf("\n\n");

   triSelection();

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   return 0;
}
