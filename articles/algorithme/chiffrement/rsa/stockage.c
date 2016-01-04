#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define TAILLE_MAX 1000

int main(void)
{
   char message[TAILLE_MAX];
   char octet[TAILLE_MAX * 2];
   char caractere[8];
   int iMessage, iOctet;

   scanf("%[^\n]s\n", message);

   // Transformation du message en une chaîne d'octets
   for(iMessage = 0; message[iMessage] != '\0'; ++iMessage) {
      sprintf(caractere, "%x", message[iMessage]);
      strcat(octet, caractere);
   }
   printf("%s\n", octet);

   // Transformation en une chaîne de caractère
   for(iOctet = 0; octet[iOctet] != '\0'; iOctet += 2) {
      char hex[3];
      hex[0] = octet[iOctet];
      hex[1] = octet[iOctet + 1];
      hex[2] = '\0';

      printf("%c", (int)strtoul(hex, NULL, 16));
   }
   printf("\n");

   return 0;
}
