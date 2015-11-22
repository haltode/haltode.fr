#include <stdio.h>

#define NB_LIG_MAX 1000
#define NB_COL_MAX 1000

int tableau[NB_LIG_MAX][NB_COL_MAX];
int cumulatif[NB_LIG_MAX][NB_COL_MAX];
int nbLig, nbCol;

void initTab(void)
{
   int iLig, iCol;

   scanf("%d %d\n", &nbLig, &nbCol);
   for(iLig = 0; iLig < nbLig; ++iLig) {
      for(iCol = 0; iCol < nbCol; ++iCol)
         scanf("%d ", &tableau[iLig][iCol]);
      scanf("\n");
   }
}

void initCumulatif(void)
{
   int iLig, iCol;

   for(iLig = 0; iLig < nbLig; ++iLig) {
      for(iCol = 0; iCol < nbCol; ++iCol) {
         cumulatif[iLig][iCol] = tableau[iLig][iCol];

         if(iLig - 1 >= 0)
            cumulatif[iLig][iCol] += cumulatif[iLig - 1][iCol];
         if(iCol - 1 >= 0)
            cumulatif[iLig][iCol] += cumulatif[iLig][iCol - 1];
         if(iLig - 1 >= 0 && iCol - 1 >= 0)
            cumulatif[iLig][iCol] -= cumulatif[iLig - 1][iCol - 1];
      }
   }
}

int somme(int lig1, int col1, int lig2, int col2)
{
   int resultat;

   resultat = cumulatif[lig2][col2];

   if(col1 - 1 >= 0)
      resultat -= cumulatif[lig2][col1 - 1];
   if(lig1 - 1 >= 0)
      resultat -= cumulatif[lig1 - 1][col2];
   if(lig1 - 1 >= 0 && col1 - 1 >= 0)
      resultat += cumulatif[lig1 - 1][col1 - 1];

   return resultat;
}

int main(void)
{
   initTab();
   initCumulatif();

   printf("%d\n", somme(1, 1, 2, 2));
   printf("%d\n", somme(0, 0, 3, 3));
   printf("%d\n", somme(0, 0, 0, 3));
   printf("%d\n", somme(3, 1, 3, 3));

   return 0;
}
