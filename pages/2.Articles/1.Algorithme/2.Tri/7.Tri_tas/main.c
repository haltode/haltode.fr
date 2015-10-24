#include <stdio.h>

int tableau[] = {1, 9, 3, 7, 6, 1, 4};
int longueur = 7;
int taille;

void echanger(int index1, int index2)
{
   int temporaire;

   temporaire = tableau[index1];
   tableau[index1] = tableau[index2];
   tableau[index2] = temporaire;
}

int gauche(int index)
{
   return 2 * index + 1;
}

int droite(int index)
{
   return 2 * index + 2;
}

void entasser(int index)
{
   int enfantGauche;
   int enfantDroite;
   int max;

   enfantGauche = gauche(index);
   enfantDroite = droite(index);

   if(enfantGauche <= taille && tableau[enfantGauche] > tableau[index])
      max = enfantGauche;
   else
      max = index;
   if(enfantDroite <= taille && tableau[enfantDroite] > tableau[max])
      max = enfantDroite;

   if(max != index)
   {
      echanger(index, max);
      entasser(max);
   }
}

void construireTasMax(void)
{
   int indexTas;

   taille = longueur - 1;

   for(indexTas = longueur / 2; indexTas >= 0; --indexTas)
      entasser(indexTas);
}

void triParTas(void)
{
   int indexTab;

   construireTasMax();

   for(indexTab = longueur - 1; indexTab != 0; --indexTab)
   {
      echanger(0, indexTab);
      --taille;
      entasser(0);
   }
}

int main(void)
{
   int index;

   for(index = 0; index < longueur; ++index)
      printf("%d ", tableau[index]);

   printf("\n\n");

   triParTas();

   for(index = 0; index < longueur; ++index)
      printf("%d ", tableau[index]);

   return 0;
}
