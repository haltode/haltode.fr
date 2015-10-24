#include <stdio.h>

int tableau[] = {5, 8, 2, 9, 1, 3};
int taille = 6;

int formule(void)
{
   int ecart;

   ecart = 0;

   while(ecart < taille)
      ecart = 3 * ecart + 1;

   return ecart / 3;
}

void triShell(void)
{
   int ecart;
   int indexTab, index, temporaire;

   for(ecart = formule(); ecart > 0; ecart /= 3)
   {
      for(indexTab = ecart; indexTab < taille; ++indexTab)
      {
         temporaire = tableau[indexTab];
         index = indexTab;

         while((index > (ecart - 1)) && (tableau[index - ecart] > temporaire))
         { 
            tableau[index] = tableau[index - ecart];
            index -= ecart;
         }

         tableau[index] = temporaire;
      }
   }
}

int main(void)
{
   int index;

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   printf("\n\n");

   triShell();

   for(index = 0; index < taille; ++index)
      printf("%d ", tableau[index]);

   return 0;	
}
