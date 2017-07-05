#include <stdio.h>

#define NB_OBJETS_MAX 1000

struct Objet {
   int poids;
   int importance;
};

struct Objet objets[NB_OBJETS_MAX];
int nb_objets;
int poids_max;

int max(int a, int b)
{
   if(a > b)
      return a;
   else
      return b;
}

int maximiser_importance(int index_objet, int poids_dispo)
{
   if(index_objet > nb_objets)
      return 0;

   struct Objet objet = objets[index_objet];
   int prend_pas_objet, prend_objet;

   /* Choix 1 */
   prend_pas_objet = maximiser_importance(index_objet + 1, poids_dispo);
   /* Choix 2 */
   if(objet.poids <= poids_dispo)
      prend_objet =  objet.importance + 
                     maximiser_importance(index_objet + 1, poids_dispo - objet.poids);
   else
      prend_objet = 0;

   return max(prend_objet, prend_pas_objet);
}

int main(void)
{
   int iObjet; 

   /* Récupère les données fournies en entrée */
   scanf("%d %d\n", &nb_objets, &poids_max);
   for(iObjet = 1; iObjet <= nb_objets; ++iObjet)
      scanf("%d %d\n", &objets[iObjet].poids, &objets[iObjet].importance);

   printf("%d\n", maximiser_importance(1, poids_max));

   return 0;
}
