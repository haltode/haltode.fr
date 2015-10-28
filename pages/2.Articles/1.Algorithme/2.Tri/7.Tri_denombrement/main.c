#include <stdio.h>
#include <stdlib.h>

int tableau[] = {8, 6, 1, 3, 8, 1, 1};
int taille = 7;

void triParDenombrement(void)
{
   int indexTab, indexTabTrie;

   int max;
   int *effectif;

   max = -42;

   for(indexTab = 0; indexTab < taille; ++indexTab)
      if(tableau[indexTab] > max)
         max = tableau[indexTab];

   effectif = calloc(max + 1, sizeof(int));

   for(indexTab = 0; indexTab < taille; ++indexTab)
      ++effectif[tableau[indexTab]];

   for(indexTab = 0, indexTabTrie = 0; indexTab <= max; ++indexTab)
   {
      if(effectif[indexTab] != 0)
      {
         int index;

         for(index = 0; index < effectif[indexTab]; ++index)
         {
            tableau[indexTabTrie] = indexTab;
            ++indexTabTrie;
         }
      }
   }

   free(effectif);
}

int main(void)
{
   int index;

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   printf("\n\n");

   triParDenombrement();

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   return 0;
}
