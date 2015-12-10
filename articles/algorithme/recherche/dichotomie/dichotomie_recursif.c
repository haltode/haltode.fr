#include <stdio.h>

#define TAILLE_MAX 1000

int tableau[TAILLE_MAX];
int taille;
int recherche;

int dichotomie(int debut, int fin)
{
   int milieu;
   milieu = (debut + fin) / 2;

   if(recherche > tableau[milieu])
      return dichotomie(milieu + 1, fin);
   else if(recherche < tableau[milieu])
      return dichotomie(debut, milieu - 1);
   else
      return milieu;
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);
   scanf("\n");

   scanf("%d\n", &recherche);

   printf("%d\n", dichotomie(0, taille - 1) + 1);

   return 0;
}
