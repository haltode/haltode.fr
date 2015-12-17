#include <stdio.h>

#define TAILLE_MAX 10000
#define LONG_CLE_MAX 100

char message[TAILLE_MAX];
int longueurCle;

char decoupe[LONG_CLE_MAX][TAILLE_MAX];
int iDecoupe[LONG_CLE_MAX];

int frequence[LONG_CLE_MAX][26];
int frequenceMax[LONG_CLE_MAX];

char cle[LONG_CLE_MAX];

void decouperMessage(void)
{
   int iTab, iLettre, iCle;

   for(iTab = 0; message[iTab] != '\0'; ++iTab) {
      iLettre = iTab % longueurCle;
      decoupe[iLettre][iDecoupe[iLettre]] = message[iTab];
      ++iDecoupe[iLettre];
   }

   for(iCle = 0; iCle < longueurCle; ++iCle) {
      printf("%d : ", iCle + 1);
      for(iTab = 0; iTab < iDecoupe[iCle]; ++iTab)
         printf("%c", decoupe[iCle][iTab]);
      printf("\n");
   }

   printf("\n");
}

void analyseFreq(void)
{
   int iCle, iTab, iLettre;

   for(iCle = 0; iCle < longueurCle; ++iCle) {
      for(iTab = 0; iTab < iDecoupe[iCle]; ++iTab) {
         iLettre = decoupe[iCle][iTab] - 'a';

         ++frequence[iCle][iLettre];
         if(frequence[iCle][iLettre] > frequence[iCle][frequenceMax[iCle]])
            frequenceMax[iCle] = iLettre;
      }
   }

   for(iCle = 0; iCle < longueurCle; ++iCle)
      printf("%d : %c\n", iCle + 1, frequenceMax[iCle] + 'a');

   printf("\n");
}

void deduireCle(void)
{
   int iCle;

   for(iCle = 0; iCle < longueurCle; ++iCle) {
      cle[iCle] = (frequenceMax[iCle] + 'a') - ('e' - 'a');
      if(cle[iCle] < 'a')
         cle[iCle] += 26;
   }

   cle[iCle] = '\0';
}

int main(void)
{
   scanf("%s\n", message);
   scanf("%d\n", &longueurCle);

   decouperMessage();
   analyseFreq();
   deduireCle();

   printf("%s\n", cle);

   return 0;
}
