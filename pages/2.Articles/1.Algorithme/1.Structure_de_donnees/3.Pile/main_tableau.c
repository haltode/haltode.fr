#include <stdio.h>

#define TAILLE_PILE 256

void initialiserPile(void);

void empiler(const int donnee);
int depiler(void);

void afficherPile(void);

int estVidePile(void);

int taillePile(void);


int pile[TAILLE_PILE];
int SP;

void initialiserPile(void)
{
	SP = 0;
}

void empiler(const int donnee)
{
	pile[SP] = donnee;
	++SP;
}

int depiler(void)
{
	--SP;
	return pile[SP];
}

void afficherPile(void)
{
	int indexPile;

	for(indexPile = 0; indexPile < SP; ++indexPile)
		printf("%d -> ", pile[indexPile]);

	printf("NULL\n");
}

int estVidePile(void)
{
	if(SP == 0)
		return 1;
	else
		return 0;
}

int taillePile(void)
{
	return SP;
}

int main(void)
{
	initialiserPile();

	return 0;
}
