#include <stdio.h>

int tableau[] = {1, 8, 15, 42, 99, 160, 380, 512, 678, 952, 1304, 7662};
int taille = 12;

int dichotomie(int recherche)
{
   int debut, milieu, fin;

   debut = 0;
   fin = taille - 1;

   do
   {

      milieu = (debut + fin) / 2;

      if(tableau[milieu] < recherche)
         debut = milieu + 1;
      else if(tableau[milieu] > recherche)
         fin = milieu - 1;
      else
         return milieu;

   } while(tableau[milieu] != recherche);
}

int main(void)
{
   int emplacement;

   emplacement = dichotomie(512);

   printf("Emplacement : %d\n", emplacement + 1);

   return 0;
}
