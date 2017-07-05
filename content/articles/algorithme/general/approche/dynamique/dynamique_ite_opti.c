#include <stdio.h>

#define NB_OBJETS_MAX 1000
#define POIDS_MAX 1000

#define PAS_CALCULE -1

struct Objet {
   int poids;
   int importance;
};

struct Objet objets[NB_OBJETS_MAX];
int nb_objets;
int poids_max;

int importance_max[2][POIDS_MAX];

int max(int a, int b)
{
   if(a > b)
      return a;
   else
      return b;
}

int maximiser_importance(void)
{
   int iObjet, iPoids;

   /* Résolution des cas de bases */
   for(iPoids = 0; iPoids <= poids_max; ++iPoids)
      importance_max[0][iPoids] = 0;

   /* On remplit toutes les cases du tableau */
   for(iObjet = 1; iObjet <= nb_objets; ++iObjet) {
      for(iPoids = 0; iPoids <= poids_max; ++iPoids) {
         struct Objet objet = objets[iObjet];
         int prend_pas_objet, prend_objet;

         /* Choix 1 */
         prend_pas_objet = importance_max[(iObjet - 1) % 2][iPoids];
         /* Choix 2 */
         if(objet.poids <= iPoids)
            prend_objet =  objet.importance +
                           importance_max[(iObjet - 1) % 2][iPoids - objet.poids];
         else
            prend_objet = 0;

         importance_max[iObjet % 2][iPoids] = max(prend_objet, prend_pas_objet);
      }
   }

   return importance_max[nb_objets % 2][poids_max];
}

int main(void)
{
   int iObjet; 

   /* Récupère les données fournies en entrée */
   scanf("%d %d\n", &nb_objets, &poids_max);
   for(iObjet = 1; iObjet <= nb_objets; ++iObjet)
      scanf("%d %d\n", &objets[iObjet].poids, &objets[iObjet].importance);

   printf("%d\n", maximiser_importance());

   return 0;
}
