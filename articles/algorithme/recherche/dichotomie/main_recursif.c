#include <stdio.h>

int tableau[] = {1, 8, 15, 42, 99, 160, 380, 512, 678, 952, 1304, 7662};
int taille = 12;

int dichotomie(int debut, int milieu, int fin, int recherche)
{
   milieu = (debut + fin) / 2;

   if(tableau[milieu] < recherche)
      dichotomie(milieu + 1, milieu, fin, recherche);
   else if(tableau[milieu] > recherche)
      dichotomie(debut, milieu, milieu - 1, recherche);
   else
      return milieu;
}

int main(void)
{
   int emplacement;

   emplacement = dichotomie(0, taille / 2, taille - 1, 512);

   printf("Emplacement : %d\n", emplacement + 1);

   return 0;
}
