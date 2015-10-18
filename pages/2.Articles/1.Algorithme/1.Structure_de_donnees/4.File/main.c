#include <stdio.h>
#include <stdlib.h>

typedef struct File File;
struct File
{
	int donnee;
	File *suivant;
};


void creerFile(File **file);
void supprimerFile(File **file);

void enfiler(File **file, const int donnee);
int defiler(File **file);

void afficherFile(File **file);

int estVideFile(File **file);

int tailleFile(File **file);


void creerFile(File **file)
{
	*file = malloc(sizeof(File));
	*file = NULL;
}

void supprimerFile(File **file)
{
	File *indexFile;

	for(indexFile = *file; indexFile != NULL; )
	{
		File *temp;

		temp = indexFile->suivant;
		free(indexFile);
		indexFile = temp;
	}
}

void enfiler(File **file, const int donnee)
{
	File *nouvelElement;

	nouvelElement = malloc(sizeof(File));

	nouvelElement->donnee = donnee;
	nouvelElement->suivant = *file;
	*file = nouvelElement;
}

int defiler(File **file)
{
	int donneeSauvegardee;
	File *indexFile;

	if(tailleFile(file) == 1)
	{
		donneeSauvegardee = (*file)->donnee;
		*file = NULL;
	}
	else
	{
		for(indexFile = *file; indexFile->suivant->suivant != NULL; indexFile = indexFile->suivant)
			;

		donneeSauvegardee = indexFile->suivant->donnee;
		indexFile->suivant = NULL;
		free(indexFile->suivant);
	}	

	return donneeSauvegardee;
}

void afficherFile(File **file)
{
	File *indexFile;

	for(indexFile = *file; indexFile != NULL; indexFile = indexFile->suivant)
		printf("%d -> ", indexFile->donnee);

	printf("NULL\n");
}

int estVideFile(File **file)
{
	if(*file == NULL)
		return 1;
	else
		return 0;
}

int tailleFile(File **file)
{
	File *indexFile;
	int nbElement;

	for(indexFile = *file, nbElement = 0; indexFile != NULL; indexFile = indexFile->suivant, ++nbElement)
		;

	return nbElement;
}

int main(void)
{
	File *file;

	creerFile(&file);

	supprimerFile(&file);

	return 0;
}
