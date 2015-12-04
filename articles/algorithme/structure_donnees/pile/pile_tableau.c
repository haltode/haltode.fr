#include <stdio.h>

#define TAILLE_MAX 256

int pile[TAILLE_MAX];
int PP;

void creerPile(void)
{
   PP = 0;
}

void empiler(int donnee)
{
   pile[PP] = donnee;
   ++PP;
}

int depiler(void)
{
   --PP;
   return pile[PP];
}

int estVidePile(void)
{
   if(PP == 0)
      return 1;
   else
      return 0;
}

int main(void)
{
   creerPile();

   empiler(42);
   // 42
   empiler(9);
   // 9
   // 42

   int retour = depiler();
   // retour = 9

   return 0;
}
