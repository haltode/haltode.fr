#include <stdio.h>
#include <stdlib.h>

typedef struct Liste Liste;
struct Liste
{
	int donnee;
	Liste *suivant;
};


void creerListe(Liste **liste);
void supprimerListe(Liste **liste);

void ajouterEnTeteListe(Liste **liste, const int donnee);
void ajouterEnFinListe(Liste **liste, const int donnee);
void ajouterIndexListe(Liste **liste, const int donnee, const int indexNouveauElement);

void supprimerEnTeteListe(Liste **liste);
void supprimerEnFinListe(Liste **liste);
void supprimerIndexListe(Liste **liste, const int indexNouveauElement);

void afficherListe(Liste **liste);

int estVideListe(Liste **liste);

int tailleListe(Liste **liste);


void creerListe(Liste **liste)
{
	*liste = malloc(sizeof(Liste));
	*liste = NULL;
}

void supprimerListe(Liste **liste)
{
	Liste *indexListe;

	for(indexListe = *liste; indexListe != NULL; )
	{
		Liste *temp;

		temp = indexListe->suivant;
		free(indexListe);
		indexListe = temp;
	}
}

void ajouterEnTeteListe(Liste **liste, const int donnee)
{
	Liste *nouveauElement;

	nouveauElement = malloc(sizeof(Liste));

	nouveauElement->donnee = donnee;
	nouveauElement->suivant = *liste;
	*liste = nouveauElement;
}

void ajouterEnFinListe(Liste **liste, const int donnee)
{
	Liste *nouveauElement;
	Liste *indexListe;

	nouveauElement = malloc(sizeof(Liste));

	nouveauElement->donnee = donnee;
	nouveauElement->suivant = NULL;

	for(indexListe = *liste; indexListe->suivant != NULL; indexListe = indexListe->suivant)
		;

	indexListe->suivant = nouveauElement;
}

void ajouterIndexListe(Liste **liste, const int donnee, const int indexNouveauElement)
{
	Liste *nouveauElement;
	Liste *indexListe;
	int indexElement;

	nouveauElement = malloc(sizeof(Liste));

	nouveauElement->donnee = donnee;

	for(indexListe = *liste, indexElement = 0; indexElement < indexNouveauElement - 1; indexListe = indexListe->suivant, ++indexElement)
		;

	nouveauElement->suivant = indexListe->suivant;
	indexListe->suivant = nouveauElement;
}

void supprimerEnTeteListe(Liste **liste)
{
	Liste *temp;

	temp = *liste;
	*liste = temp->suivant; 

	free(temp);
}

void supprimerEnFinListe(Liste **liste)
{
	Liste *indexListe;

	for(indexListe = *liste; indexListe->suivant->suivant != NULL; indexListe = indexListe->suivant)
		;

	free(indexListe->suivant);
	indexListe->suivant = NULL;
}

void supprimerIndexListe(Liste **liste, const int indexNouveauElement)
{
	Liste *indexListe;
	int indexElement;

	for(indexListe = *liste, indexElement = 0; indexElement < indexNouveauElement - 1; indexListe = indexListe->suivant, ++indexElement)
		;

	free(indexListe->suivant);
	indexListe->suivant = indexListe->suivant->suivant;
}

void afficherListe(Liste **liste)
{
	Liste *indexListe;

	for(indexListe = *liste; indexListe != NULL; indexListe = indexListe->suivant)
		printf("%d -> ", indexListe->donnee);

	printf("NULL\n");
}

int estVideListe(Liste **liste)
{
	if(*liste == NULL)
		return 1;
	else
		return 0;
}

int tailleListe(Liste **liste)
{
	Liste *indexListe;
	int nbElement;

	for(indexListe = *liste, nbElement = 0; indexListe != NULL; indexListe = indexListe->suivant, ++nbElement)
		;

	return nbElement;
}

int main(void)
{
	Liste *liste;

	creerListe(&liste);

	supprimerListe(&liste);

	return 0;
}
