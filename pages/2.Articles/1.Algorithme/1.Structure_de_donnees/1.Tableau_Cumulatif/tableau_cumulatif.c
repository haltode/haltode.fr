#include <stdio.h>

#define TAILLE_MAX 1000

int tableau[TAILLE_MAX];
int cumulatif[TAILLE_MAX];
int nbElement;

void initTab(void)
{
   int iEle;

   scanf("%d\n", &nbElement);
   for(iEle = 0; iEle < nbElement; ++iEle)
      scanf("%d ", &tableau[iEle]);
}

void initCumulatif(void)
{
   int iEle;
   int dernier;

   dernier = 0;
   for(iEle = 0; iEle < nbElement; ++iEle) {
      cumulatif[iEle] = tableau[iEle] + dernier;
      dernier = cumulatif[iEle];
   }
}

int somme(int debut, int fin)
{
   if(debut == 0)
      return cumulatif[fin];
   else
      return cumulatif[fin] - cumulatif[debut - 1];
}

int main(void)
{
   initTab();
   initCumulatif();

   printf("%d\n", somme(2, 5));
   printf("%d\n", somme(0, 3));
   printf("%d\n", somme(3, 4));
   printf("%d\n", somme(0, 5));

   return 0;
}
