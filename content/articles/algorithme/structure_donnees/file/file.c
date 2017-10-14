#include <stdio.h>
#include <stdlib.h>

typedef struct Noeud Noeud;
struct Noeud 
{
   int donnee;
   Noeud *suivant;
   Noeud *precedent;
};

typedef struct File File;
struct File
{
   Noeud *debut;
   Noeud *fin;
};

int estVide(File *file);

void creerFile(File *file)
{
   file->debut = NULL;
   file->fin = NULL;
}

void supprimerFile(File *file)
{
   Noeud *iFile;

   for(iFile = file->fin; iFile != NULL; ) {
      Noeud *temp;

      temp = iFile->suivant;
      free(iFile);
      iFile = temp;
   }
}

void enfiler(File *file, int donnee)
{
   Noeud *nouveau;

   nouveau = malloc(sizeof(Noeud));
   nouveau->suivant = file->fin;
   nouveau->precedent = NULL;
   nouveau->donnee = donnee;

   if(estVide(file)) {
      file->debut = file->fin = nouveau;
      return;
   }
   else {
      file->fin->precedent = nouveau;
      file->fin = nouveau;
   }
}

int defiler(File *file)
{
   Noeud *temp;
   int donnee;

   temp = file->debut->precedent;
   donnee = file->debut->donnee;
   free(file->debut);
   file->debut = temp;
   file->debut->suivant = NULL;

   return donnee;
}

int estVide(File *file)
{
   if(file->debut == NULL && file->fin == NULL)
      return 1;
   else
      return 0;
}

int main(void)
{
   File file;

   creerFile(&file);

   enfiler(&file, 42);
   // 42
   enfiler(&file, 9);
   // 9 42

   int retour = defiler(&file);
   // retour = 42

   supprimerFile(&file);

   return 0;
}
