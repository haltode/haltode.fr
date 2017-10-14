#include <stdio.h>

#define TAILLE_MAX 1000

int tableau[TAILLE_MAX];
int taille;
int recherche;

int dichotomie(void)
{
   int debut, milieu, fin;

   debut = 0;
   fin = taille - 1;

   do
   {
      milieu = (debut + fin) / 2;

      if(recherche > tableau[milieu])
         debut = milieu + 1;
      else if(recherche < tableau[milieu])
         fin = milieu - 1;
      else
         return milieu;

   } while(tableau[milieu] != recherche);

   return -1;
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);
   scanf("\n");

   scanf("%d\n", &recherche);

   printf("%d\n", dichotomie() + 1);

   return 0;
}
