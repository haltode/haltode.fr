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

int importance_max[NB_OBJETS_MAX][POIDS_MAX];

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
   /* On vérifie qu'on n'a pas déjà calculé ce résultat */
   if(importance_max[index_objet][poids_dispo] != PAS_CALCULE)
      return importance_max[index_objet][poids_dispo];

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

   /* On garde en mémoire le résultat avant de le retourner */
   importance_max[index_objet][poids_dispo] = max(prend_objet, prend_pas_objet);
   return importance_max[index_objet][poids_dispo];
}

int main(void)
{
   int iObjet, iPoids; 

   /* Récupère les données fournies en entrée */
   scanf("%d %d\n", &nb_objets, &poids_max);
   for(iObjet = 1; iObjet <= nb_objets; ++iObjet)
      scanf("%d %d\n", &objets[iObjet].poids, &objets[iObjet].importance);

   /* Initialise notre tableau de résultats */
   for(iObjet = 1; iObjet <= nb_objets; ++iObjet)
      for(iPoids = 0; iPoids <= poids_max; ++iPoids)
         importance_max[iObjet][iPoids] = PAS_CALCULE;

   printf("%d\n", maximiser_importance(1, poids_max));

   return 0;
}
