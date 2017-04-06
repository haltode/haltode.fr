#include <stdio.h>
#include <ctype.h>

#define TAILLE_MAX 1000

char message[TAILLE_MAX];
int cle;

void chiffrement(void)
{
   int iTab;

   for(iTab = 0; message[iTab] != '\0'; ++iTab) {
      if(isalpha(message[iTab])) {
         char typo;
         typo = (isupper(message[iTab])) ? 'A' : 'a';

         message[iTab] -= typo;
         message[iTab] = ((message[iTab] + cle) % 26 + 26) % 26;
         message[iTab] += typo;
      }
   }
}

void dechiffrement(void)
{
   int iTab;

   for(iTab = 0; message[iTab] != '\0'; ++iTab) {
      if(isalpha(message[iTab])) {
         char typo;
         typo = (isupper(message[iTab])) ? 'A' : 'a';

         message[iTab] -= typo;
         message[iTab] = ((message[iTab] - cle) % 26 + 26) % 26;
         message[iTab] += typo;
      }
   }
}

int main(void)
{
   scanf("%[^\n]s\n", message);
   scanf("%d\n", &cle);

   chiffrement();
   printf("%s\n", message);
   dechiffrement();
   printf("%s\n", message);

   return 0;
}
