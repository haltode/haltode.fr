#include <stdio.h>
#include <stdlib.h>

typedef struct Noeud Noeud;
struct Noeud
{
   Noeud *suivant;
   int donnee;
};

typedef Noeud *Pile;

void creerPile(Pile *pile)
{
   *pile = NULL;
}

void supprimerPile(Pile *pile)
{
   Noeud *iPile;

   for(iPile = *pile; iPile != NULL; ) {
      Noeud *temp;

      temp = iPile->suivant;
      free(iPile);
      iPile = temp;
   }
}

void empiler(Pile *pile, int donnee)
{
   Noeud *nouveau;

   nouveau = malloc(sizeof(Noeud));
   nouveau->suivant = *pile;
   nouveau->donnee = donnee;

   *pile = nouveau;
}

int depiler(Pile *pile)
{
   Noeud *temp;
   int donnee;

   temp = (*pile)->suivant;
   donnee = (*pile)->donnee;
   free(*pile);
   *pile = temp;

   return donnee;
}

int estVide(Pile *pile)
{
   if(*pile == NULL)
      return 1;
   else
      return 0;
}

int main(void)
{
   Pile pile;

   creerPile(&pile);

   empiler(&pile, 42);
   // 42
   empiler(&pile, 9);
   // 9
   // 42

   int retour = depiler(&pile);
   // retour = 9

   supprimerPile(&pile);

   return 0;
}
