#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define TAILLE_MAX 1000

int main(void)
{
   char message[TAILLE_MAX];
   char hexa[TAILLE_MAX * 2];
   char caractere[8];
   int iMessage, ihexa;

   scanf("%[^\n]s\n", message);

   // Transformation du message en une chaîne représentant notre nombre hexadécimal
   for(iMessage = 0; message[iMessage] != '\0'; ++iMessage) {
      sprintf(caractere, "%x", message[iMessage]);
      strcat(hexa, caractere);
   }
   printf("0x%s\n", hexa);

   // Transformation en une chaîne de caractère lisible
   for(ihexa = 0; hexa[ihexa] != '\0'; ihexa += 2) {
      char lettre[3];
      lettre[0] = hexa[ihexa];
      lettre[1] = hexa[ihexa + 1];
      lettre[2] = '\0';

      printf("%c", (int)strtoul(lettre, NULL, 16));
   }
   printf("\n");

   return 0;
}
