#include <cstdio>
#include <queue>
using namespace std;

const int TAILLE_MAX = 1000;

int tableau[TAILLE_MAX];
int taille;

priority_queue <int> tas;

void construireTasMax(void)
{
   int iTab;
   for(iTab = 0; iTab < taille; ++iTab)
      tas.push(tableau[iTab]);
}

void triTas(void)
{
   int iTab;

   construireTasMax();

   for(iTab = taille - 1; iTab != 0; --iTab) {
      tableau[iTab] = tas.top();
      tas.pop();
   }
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);

   triTas();

   for(iTab = 0; iTab < taille; ++iTab)
      printf("%d ", tableau[iTab]);
   printf("\n");

   return 0;
}
