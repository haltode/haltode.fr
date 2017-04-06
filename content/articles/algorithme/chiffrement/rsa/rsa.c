#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#define TAILLE_MAX 1000

unsigned long long message[TAILLE_MAX];
int taille;
// Clé
int p, q;
int n;
int m;
int e, d;

int PGCD(int a, int b)
{
   int r;

   while(b != 0) {
      r = a % b;
      a = b;
      b = r;
   }

   return a;
}

int euclideEtendu(int a, int b)
{
   int r0, r1;
   int s0, s1;
   int t0, t1;
   int i;
   int q, r, s, t;

   r0 = a;
   s0 = 1;
   t0 = 0;

   r1 = b;
   s1 = 0;
   t1 = 1;

   r = 42;
   for(i = 2; r != 0; ++i) {
      q = r0 / r1;
      r = r0 - q * r1;
      s = s0 - q * s1;
      t = t0 - q * t1;

      r0 = r1;
      r1 = r;
      s0 = s1;
      s1 = s;
      t0 = t1;
      t1 = t;
   }

   return s0;
}

void clePublique(void)
{
   static int premier[] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 
      47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 
      131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199,
      211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283,
      293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383,
      389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467,
      479, 487, 491, 499, 503, 509, 521, 523, 541};

   /*do
     {
     p = premier[rand() % 100];
     q = premier[rand() % 100];

     } while(p == q);*/

   p = 61;
   q = 137;

   n = p * q;
   m = (p - 1) * (q - 1);

   for(e = 2; PGCD(e, m) != 1; ++e)
      ;
}

void clePrivee(void)
{
   d = euclideEtendu(e, m);
   while(d < 0)
      d += m;
}

void chiffrement(void)
{
   int iMessage, iExp;
   int lettre;

   for(iMessage = 0; iMessage < taille; ++iMessage) {
      // Exponentiation modulaire
      lettre = message[iMessage];
      message[iMessage] = 1;
      for(iExp = 1; iExp <= e; ++iExp)
         message[iMessage] = (message[iMessage] * lettre) % n;
   }
}

void dechiffrement(void)
{
   int iMessage, iExp;
   int lettre;

   for(iMessage = 0; iMessage < taille; ++iMessage) {
      // Exponentiation modulaire
      lettre = message[iMessage];
      message[iMessage] = 1;
      for(iExp = 1; iExp <= d; ++iExp)
         message[iMessage] = (message[iMessage] * lettre) % n;
   }
}

int main(void)
{
   char iCar;
   int iMessage;

   // Lit le message et le transforme en nombre 
   iMessage = 0;
   do
   {
      scanf("%c", &iCar);
      if(iCar != '\n') {
         message[iMessage] = (unsigned long long)iCar;
         ++iMessage;
      }
   } while(iCar != '\n');
   taille = iMessage;

   // Génère le couple de clé
   srand(time(NULL));
   clePublique();
   clePrivee();

   printf("Cle publique : %d %d\n", n, e);
   printf("Cle privee : %d %d\n", n, d);

   // Chiffre le message et l'affiche comme une suite de nombre
   chiffrement();
   for(iMessage = 0; iMessage < taille; ++iMessage)
      printf("%llu ", message[iMessage]);
   printf("\n");

   // Déchiffre le message et l'affiche comme une chaîne
   dechiffrement();
   for(iMessage = 0; iMessage < taille; ++iMessage)
      printf("%c", (char)message[iMessage]);
   printf("\n");

   return 0;
}
