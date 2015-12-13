#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define TAILLE_MAX 1000

char message[TAILLE_MAX];
char copie[TAILLE_MAX];

void dechiffrement(int cle)
{
   int iTab;

   for(iTab = 0; copie[iTab] != '\0'; ++iTab) {
      if(isalpha(copie[iTab])) {
         char typo;
         typo = (isupper(copie[iTab])) ? 'A' : 'a';

         copie[iTab] -= typo;
         copie[iTab] = ((copie[iTab] - cle) % 26 + 26) % 26;
         copie[iTab] += typo;
      }
   }
}

void forceBrute(void)
{
   int iCle;
   for(iCle = 1; iCle < 26; ++iCle) {
      strcpy(copie, message);
      dechiffrement(iCle);
      printf("Cle de %d : %s\n", iCle, copie);
   }
}

int main(void)
{
   scanf("%[^\n]s\n", message);

   forceBrute();

   return 0;
}
