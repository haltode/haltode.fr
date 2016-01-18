#include <stdio.h>

#define NB_NOEUD_MAX 1000

int tas[NB_NOEUD_MAX];
int nbElement;

void echanger(int a, int b)
{
   int c;

   c = tas[a];
   tas[a] = tas[b];
   tas[b] = c;
}

int max(int a, int b)
{
   if(tas[a] > tas[b])
      return a;
   else
      return b;
}

void inserer(int valeur)
{
   int noeud, pere;

   ++nbElement;
   noeud = nbElement;
   tas[nbElement] = valeur;

   pere = noeud / 2;
   while(pere != 0 && 
         tas[noeud] > tas[pere]) {
      echanger(noeud, pere);

      noeud = pere;
      pere = noeud / 2;
   }
}

int extraire(void)
{
   int racine;
   int noeud, gauche, droit, fils;

   racine = tas[1];

   tas[1] = tas[nbElement];
   --nbElement;

   noeud = 1;
   gauche = 2;
   droit = 3;

   while(gauche <= nbElement &&
         (tas[noeud] < tas[gauche] || tas[noeud] < tas[droit])) {
      fils = max(gauche, droit);
      echanger(noeud, fils);

      noeud = fils;
      gauche = 2 * noeud;
      droit = 2 * noeud + 1;
   }

   return racine;
}

int estPuissanceDeux(int x)
{
   return (x & (x - 1)) == 0;
}

void afficher(void)
{
   int iEle;
   for(iEle = 1; iEle <= nbElement; ++iEle) {
      printf("%d ", tas[iEle]);
      if(estPuissanceDeux(iEle + 1))
         printf("\n");
   }
   
   printf("\n");
}

int main(void)
{
   inserer(12);
   inserer(9);
   inserer(1);
   inserer(42);
   inserer(10);
   inserer(27);
   inserer(3);
   inserer(5);
   inserer(4);
   inserer(6);
   inserer(3);
   inserer(8);
   afficher();
   printf("%d\n", extraire());
   afficher();

   return 0;
}
