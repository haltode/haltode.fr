#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define TAILLE_MAX 10000

char message[TAILLE_MAX];
char cle[TAILLE_MAX];
int tailleCle;

void chiffrement(void)
{
   int iTab, iCle;

   for(iTab = 0, iCle = 0; message[iTab] != '\0'; ++iTab) {
      if(isalpha(message[iTab])) {
         char typo, lettreCle;
         typo = (isupper(message[iTab])) ? 'A' : 'a';
         lettreCle = tolower(cle[iCle]) - 'a';
         iCle = (iCle + 1) % tailleCle;

         message[iTab] -= typo;
         message[iTab] = ((message[iTab] + lettreCle) % 26 + 26) % 26;
         message[iTab] += typo;
      }
   }
}

void dechiffrement(void)
{
   int iTab, iCle;

   for(iTab = 0, iCle = 0; message[iTab] != '\0'; ++iTab) {
      if(isalpha(message[iTab])) {
         char typo, lettreCle;
         typo = (isupper(message[iTab])) ? 'A' : 'a';
         lettreCle = tolower(cle[iCle]) - 'a';
         iCle = (iCle + 1) % tailleCle;

         message[iTab] -= typo;
         message[iTab] = ((message[iTab] - lettreCle) % 26 + 26) % 26;
         message[iTab] += typo;
      }
   }
}

void viderBuffer(void)
{
   int c;
   c = 0;
   while(c != '\n' && c != EOF)
      c = getchar();
}

int main(void)
{
   scanf("%[^\n]s\n", message);
   viderBuffer();
   scanf("%[^\n]s\n", cle);
   tailleCle = strlen(cle);

   chiffrement();
   printf("%s\n", message);
   dechiffrement();
   printf("%s\n", message);

   return 0;
}
