#include <stdio.h>
#include <ctype.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define TAILLE_MAX 1000
#define NB_CLE_MAX 1000

char message[TAILLE_MAX];
char cle[TAILLE_MAX];

char utilisee[NB_CLE_MAX][TAILLE_MAX];
int nbCle;

void initCleUtilisee(void)
{
   FILE *fichierCle;

   fichierCle = fopen("cle_utilisee.txt", "r");

   nbCle = 0;
   while(fscanf(fichierCle, "%s\n", utilisee[nbCle]) != EOF)
      ++nbCle;

   fclose(fichierCle);
}

bool estDejaUtilisee(void)
{
   int iCle;

   for(iCle = 0; iCle < nbCle; ++iCle)
      if(strcmp(cle, utilisee[iCle]) == 0)
         return true;

   return false;
}

void creerCle(void)
{
   int iCle, iLettre;

   do
   {
      iCle = 0;

      for(iLettre = 0; message[iLettre] != '\0'; ++iLettre) {
         if(isalpha(message[iLettre])) {
            cle[iCle] = (rand() % 26) + 'a';
            ++iCle;
         }
      } 

      cle[iCle] = '\0';

   } while(estDejaUtilisee());
}

void ajouterCle(void)
{
   FILE *fichierCle;

   fichierCle = fopen("cle_utilisee.txt", "a");
   fprintf(fichierCle, "%s\n", cle);
   fclose(fichierCle);
}

int main(void)
{
   scanf("%[^\n]s\n", message);

   srand(time(NULL));

   initCleUtilisee();
   creerCle();

   printf("%s\n", cle);
   ajouterCle();

   return 0;
}
