#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define NB_LETTRE_ALPHABET 26
#define TAILLE_MAX 500

const char baseLettrePlusUtilisee[NB_LETTRE_ALPHABET] =
{
   'e', 'a', 'i', 's', 't', 'n', 'r', 'u', 'l', 'o', 'd', 'm', 'p','c', 'v', 'q', 
   'g', 'b', 'f', 'j', 'h', 'z', 'x', 'y', 'k', 'w'
};

char message[] = "Hj yjcyj jxy ozxyj qf utzw atzx rtsywjw vzj q'fsfqdxj kwjvzjsynjqqj jxy ywjx zynqj xzw ij qtslx yjcyjx jy wjxyj knfgqj, atzx utzaje qj atnw js yjxyfsy hj uwtlwfrrj !";
char messageDechiffre[TAILLE_MAX];
int cleSupposee[NB_LETTRE_ALPHABET];
int cle;

void dechiffrement(void)
{
   int indexTab;

   for(indexTab = 0; messageDechiffre[indexTab] != '\0'; ++indexTab)
   {
      if(isupper(messageDechiffre[indexTab]))
         messageDechiffre[indexTab] = ((messageDechiffre[indexTab] - 'A' - cle) % 26 + 26) % 26 + 'A';
      else if(islower(messageDechiffre[indexTab]))
         messageDechiffre[indexTab] = ((messageDechiffre[indexTab] - 'a' - cle) % 26 + 26) % 26 + 'a';
   }
}

void preparerMessage(void)
{
   int indexTab;

   for(indexTab = 0; message[indexTab] != '\0'; ++indexTab)
      message[indexTab] = tolower(message[indexTab]);
}

void determinerOccurrenceMot(int occurrence[NB_LETTRE_ALPHABET])
{
   int indexTab;

   for(indexTab = 0; indexTab < NB_LETTRE_ALPHABET; ++indexTab)
      occurrence[indexTab] = 0;

   preparerMessage();

   for(indexTab = 0; message[indexTab] != '\0'; ++indexTab)
      if(islower(message[indexTab]))
         ++occurrence[message[indexTab] - 'a'];
}

void determinerClePossible(int occurrence[NB_LETTRE_ALPHABET])
{
   int indexBase;

   for(indexBase = 0; indexBase < NB_LETTRE_ALPHABET; ++indexBase)
   {
      int indexTab;
      int indexMax, maximum;

      maximum = -1;

      for(indexTab = 0; indexTab < NB_LETTRE_ALPHABET; ++indexTab)
      {
         if(occurrence[indexTab] > maximum)
         {
            maximum = occurrence[indexTab];
            indexMax = indexTab;
         }	
      }

      occurrence[indexMax] = -1;

      cleSupposee[indexBase] = baseLettrePlusUtilisee[indexBase] - (indexMax + 'a');

      if(cleSupposee[indexBase] < 0)
         cleSupposee[indexBase] = -cleSupposee[indexBase];
   }
}

void analyseFrequentielle(void)
{
   int occurrence[NB_LETTRE_ALPHABET];

   determinerOccurrenceMot(occurrence);
   determinerClePossible(occurrence);
}

int main(void)
{
   int indexTab;

   strcpy(messageDechiffre, message);

   analyseFrequentielle();

   for(indexTab = 0; indexTab < NB_LETTRE_ALPHABET; ++indexTab)
      printf("%d ", cleSupposee[indexTab]);

   printf("\n\n");

   cle = cleSupposee[0];
   dechiffrement();
   printf("Message dechiffre avec la 1ere proposition de cle (%d) : \n\n%s\n", cleSupposee[0], messageDechiffre);

   return 0;
}
