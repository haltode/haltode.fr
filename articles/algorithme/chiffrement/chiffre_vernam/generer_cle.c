#include <stdio.h>
#include <ctype.h>
#include <time.h>
#include <stdlib.h>

#define TAILLE_MAX 1000

char message[TAILLE_MAX];
char cle[TAILLE_MAX];

int main(void)
{
   int iCle, iLettre;

   scanf("%[^\n]s\n", message);
  
   srand(time(NULL));
   iCle = 0;

   for(iLettre = 0; message[iLettre] != '\0'; ++iLettre) {
      if(isalpha(message[iLettre])) {
         cle[iCle] = (rand() % 26) + 'a';
         ++iCle;
      }
   } 
   cle[iCle] = '\0';
   
   printf("%s\n", cle);

   return 0;
}
