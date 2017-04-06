#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

#define TAILLE_MAX 10000
#define NB_POSSIBILITE_MAX 10000

char message[TAILLE_MAX];
int tailleMessage;

int nbPossibilite[NB_POSSIBILITE_MAX];
int possibiliteMax;

int chercherOccurrence(char chaine[], int taille, int debut)
{
   int iDebut;

   for(iDebut = debut; iDebut < tailleMessage - taille + 1; ++iDebut) {
      int iTab, iChaine;

      iTab = iDebut;
      iChaine = 0;
      while(iTab < tailleMessage - taille + 1 &&
            chaine[iChaine] == message[iTab]) {
         ++iTab;
         ++iChaine;
      }

      if(iChaine == taille)
         return iDebut;
   }

   return -1;
}

void ajouterTaillePossible(int ecart)
{
   int iDiv;

   for(iDiv = 2; iDiv <= ecart; ++iDiv) {
      if(ecart % iDiv == 0) {
         ++nbPossibilite[iDiv];
         if(nbPossibilite[iDiv] > nbPossibilite[possibiliteMax])
            possibiliteMax = iDiv;
      }
   }
}

void testKasiski(void)
{
   int iTaille, iDebut;
   bool trouve;

   iTaille = 3;
   trouve = true;

   while(trouve) {
      trouve = false;

      for(iDebut = 0; iDebut < tailleMessage - iTaille + 1; ++iDebut) {
         char chaine[iTaille + 1];
         int iTab;
         int occurrence;

         for(iTab = 0; iTab < iTaille; ++iTab)
            chaine[iTab] = message[iDebut + iTab];
         chaine[iTab] = '\0';

         occurrence = chercherOccurrence(chaine, iTaille, iDebut + iTaille);
         if(occurrence != -1) {
            int ecart;

            ecart =  occurrence - iDebut;
            trouve = true;

            //printf("%s %d\n", chaine, ecart);

            ajouterTaillePossible(ecart);
         }
      }

      ++iTaille;
   }
}

int main(void)
{
   scanf("%s\n", message);
   tailleMessage = strlen(message);

   possibiliteMax = 0;
   testKasiski();

   /*int iDiv;
   for(iDiv = 0; iDiv < NB_POSSIBILITE_MAX; ++iDiv)
      if(nbPossibilite[iDiv] != 0)
         printf("%d : %d\n", iDiv, nbPossibilite[iDiv]);*/

   printf("%d\n", possibiliteMax);

   return 0;
}
