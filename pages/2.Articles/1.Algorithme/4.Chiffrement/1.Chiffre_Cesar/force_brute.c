#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define TAILLE_MAX 500

const char message[] = "Nkpwz";
char copie[TAILLE_MAX];
int cle;

void dechiffrement(void)
{
   int indexTab;

   for(indexTab = 0; copie[indexTab] != '\0'; ++indexTab)
   {
      if(isupper(copie[indexTab]))
         copie[indexTab] = ((copie[indexTab] - 'A' - cle) % 26 + 26) % 26 + 'A';
      else if(islower(copie[indexTab]))
         copie[indexTab] = ((copie[indexTab] - 'a' - cle) % 26 + 26) % 26 + 'a';
   }
}

void forceBrute(void)
{
   for(cle = 1; cle < 26; ++cle)
   {
      strcpy(copie, message);
      dechiffrement();
      printf("Pour une cle de %d : %s\n", cle, copie);
   }
}

int main(void)
{
   forceBrute();

   return 0;
}
