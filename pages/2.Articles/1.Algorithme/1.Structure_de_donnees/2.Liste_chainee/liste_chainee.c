#include <stdio.h>
#include <stdlib.h>

typedef struct Noeud Noeud;
struct Noeud
{
   Noeud *suivant;
   int donnee;
};

typedef Noeud *Liste;

void creerListe(Liste *liste)
{
   *liste = NULL;
}

void supprimerListe(Liste *liste)
{
   Noeud *iListe;

   for(iListe = *liste; iListe != NULL; ) {
      Noeud *temp;

      temp = iListe->suivant;
      free(iListe);
      iListe = temp;
   }
}

void ajouterTete(Liste *liste, int donnee)
{
   Noeud *nouveau;

   nouveau = malloc(sizeof(Noeud));
   nouveau->suivant = *liste;
   nouveau->donnee = donnee;

   *liste = nouveau;
}

void ajouterFin(Liste *liste, int donnee)
{
   Noeud *nouveau;
   Noeud *iListe;

   nouveau = malloc(sizeof(Noeud));
   nouveau->suivant = NULL;
   nouveau->donnee = donnee;

   for(iListe = *liste; iListe->suivant != NULL; iListe = iListe->suivant)
      ;

   iListe->suivant = nouveau;
}

void ajouterElement(Liste *liste, int donnee, int index)
{
   Noeud *nouveau;
   Noeud *iListe;
   int iEle;
   
   iListe = *liste;
   for(iEle = 0; iEle < index - 1; ++iEle)
      iListe = iListe->suivant;

   nouveau = malloc(sizeof(Noeud));
   nouveau->suivant = iListe->suivant;
   nouveau->donnee = donnee;

   iListe->suivant = nouveau;
}

void supprimerTete(Liste *liste)
{
   Noeud *temp;

   temp = (*liste)->suivant;
   free(*liste);
   *liste = temp;
}

void supprimerFin(Liste *liste)
{
   Noeud *iListe;

   for(iListe = *liste; iListe->suivant->suivant != NULL; iListe = iListe->suivant)
      ;

   free(iListe->suivant); 
   iListe->suivant = NULL;
}

void supprimerElement(Liste *liste, int index)
{
   Noeud *iListe;
   int iEle;

   iListe = *liste;
   for(iEle = 0; iEle < index - 1; ++iEle)
      iListe = iListe->suivant;

   Noeud *temp;
   temp = iListe->suivant;
   iListe->suivant = temp->suivant;
   free(temp);
}

int estVide(Liste *liste)
{
   if(*liste == NULL)
      return 1;
   else
      return 0;
}

int main(void)
{
   Liste liste;

   creerListe(&liste);
   
   printf("%d\n", estVide(&liste));
   // 1

   ajouterTete(&liste, 42);
   // 42
   ajouterTete(&liste, 2);
   // 2 42
   ajouterFin(&liste, 69);
   // 2 42 69
   ajouterElement(&liste, 7, 2);
   // 2 42 7 69 

   supprimerTete(&liste);
   // 42 7 69
   supprimerFin(&liste);
   // 42 7
   ajouterFin(&liste, 2);
   supprimerElement(&liste, 1);
   // 42 2

   printf("%d\n", estVide(&liste));
   // 0

   supprimerListe(&liste);

   return 0;
}
