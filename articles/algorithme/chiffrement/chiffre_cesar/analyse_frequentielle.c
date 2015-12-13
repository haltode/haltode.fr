#include <stdio.h>
#include <ctype.h>

#define TAILLE_MAX 1000
#define NB_LETTRE 26

char message[TAILLE_MAX];
int cle;

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

void analyseFrequentielle(void)
{
   int occurrence[NB_LETTRE];
   int iLettre, iMax;

   for(iLettre = 0; iLettre < NB_LETTRE; ++iLettre)
      occurrence[iLettre] = 0;
   for(iLettre = 0; message[iLettre] != '\0'; ++iLettre) {
      if(isalpha(message[iLettre])) {
         char typo;
         typo = (isupper(message[iLettre])) ? 'A' : 'a';
         ++occurrence[message[iLettre] - typo];
      }
   }


   iMax = 0;
   for(iLettre = 0; iLettre < NB_LETTRE; ++iLettre)
      if(occurrence[iLettre] > occurrence[iMax])
         iMax = iLettre;

   cle = 'e' - (iMax + 'a');
   if(cle < 0)
      cle = -cle;
}

int main(void)
{
   scanf("%[^\n]s\n", message);

   analyseFrequentielle();
   dechiffrement();
   printf("Cle de %d : \n\n%s\n", cle, message);

   return 0;
}
