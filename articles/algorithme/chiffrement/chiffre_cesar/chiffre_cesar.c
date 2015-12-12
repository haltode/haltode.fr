#include <stdio.h>
#include <ctype.h>

char message[] = "Linux";
int cle = 2;

void chiffrement(void)
{
   int indexTab;

   for(indexTab = 0; message[indexTab] != '\0'; ++indexTab)
   {
      if(isupper(message[indexTab]))
      {
         message[indexTab] -= 'A';
         message[indexTab] = ((message[indexTab] + cle) % 26 + 26) % 26;
         message[indexTab] += 'A';
      }
      else if(islower(message[indexTab]))
      {
         message[indexTab] -= 'a';
         message[indexTab] = ((message[indexTab] + cle) % 26 + 26) % 26;
         message[indexTab] += 'a';
      }
   }
}

void dechiffrement(void)
{
   int indexTab;

   for(indexTab = 0; message[indexTab] != '\0'; ++indexTab)
   {
      if(isupper(message[indexTab]))
      {
         message[indexTab] -= 'A';
         message[indexTab] = ((message[indexTab] - cle) % 26 + 26) % 26;
         message[indexTab] += 'A';
      }
      else if(islower(message[indexTab]))
      {
         message[indexTab] -= 'a';
         message[indexTab] = ((message[indexTab] - cle) % 26 + 26) % 26;
         message[indexTab] += 'a';
      }
   }
}

int main(void)
{
   printf("%s\n", message);

   chiffrement();
   printf("%s\n", message);

   dechiffrement();
   printf("%s\n", message);

   return 0;
}
