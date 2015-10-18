#include <stdio.h>
#include <stdlib.h>

typedef struct Pile Pile;
struct Pile
{
   int donnee;
   Pile *suivant;
};


void creerPile(Pile **pile);
void supprimerPile(Pile **pile);

void empiler(Pile **pile, const int donnee);
int depiler(Pile **pile);

void afficherPile(Pile **pile);

int estVidePile(Pile **pile);

int taillePile(Pile **pile);


void creerPile(Pile **pile)
{
   *pile = malloc(sizeof(Pile));
   *pile = NULL;
}

void supprimerPile(Pile **pile)
{
   while(!estVidePile(pile))
      depiler(pile);
}

void empiler(Pile **pile, const int donnee)
{
   Pile *nouvelElement;

   nouvelElement = malloc(sizeof(Pile));

   nouvelElement->donnee = donnee;
   nouvelElement->suivant = *pile;
   *pile = nouvelElement;
}

int depiler(Pile **pile)
{
   Pile *temp;
   int donneeSauvegardee;

   temp = *pile;
   donneeSauvegardee = (*pile)->donnee;
   *pile = temp->suivant; 

   free(temp);

   return donneeSauvegardee;
}

void afficherPile(Pile **pile)
{
   Pile *indexPile;

   for(indexPile = *pile; indexPile != NULL; indexPile = indexPile->suivant)
      printf("%d -> ", indexPile->donnee);

   printf("NULL\n");
}

int estVidePile(Pile **pile)
{
   if(*pile == NULL)
      return 1;
   else
      return 0;
}

int taillePile(Pile **pile)
{
   Pile *indexPile;
   int nbElement;

   for(indexPile = *pile, nbElement = 0; indexPile != NULL; indexPile = indexPile->suivant, ++nbElement)
      ;

   return nbElement;
}

int main(void)
{
   Pile *pile;

   creerPile(&pile);

   supprimerPile(&pile);

   return 0;
}
