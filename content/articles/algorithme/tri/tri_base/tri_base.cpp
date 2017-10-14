#include <cstdio>
#include <cmath>
#include <queue>
using namespace std;

const int TAILLE_MAX = 1000;

int tableau[TAILLE_MAX];
int taille;

int nbChiffreMax(void)
{
   int max;
   int iTab;

   max = tableau[0];
   for(iTab = 1; iTab < taille; ++iTab)
      if(tableau[iTab] > max)
         max = tableau[iTab];

   return floor(log10(max)) + 1;
}

void trier(int iExp)
{
   queue <int> effectif[10];
   int iTab, iChiffre, iFile;
   int chiffre;
   int nbFile;

   for(iTab = 0; iTab < taille; ++iTab) {
      chiffre = (tableau[iTab] / iExp) % 10;
      effectif[chiffre].push(tableau[iTab]);
   }

   iTab = 0;
   for(iChiffre = 0; iChiffre < 10; ++iChiffre) {
      nbFile = effectif[iChiffre].size();
      for(iFile = 0; iFile < nbFile; ++iFile) {
         tableau[iTab] = effectif[iChiffre].front(); 
         effectif[iChiffre].pop();
         ++iTab;
      }
   }
}

void triBase(void)
{
   int nbChiffre;
   int iChiffre, iExp;

   nbChiffre = nbChiffreMax();
   for(iChiffre = 0, iExp = 1; iChiffre < nbChiffre; ++iChiffre, iExp *= 10)
      trier(iExp);
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);

   triBase();

   for(iTab = 0; iTab < taille; ++iTab)
      printf("%d ", tableau[iTab]);
   printf("\n");

   return 0;
}
