#include <cstdio>
#include <vector>
using namespace std;

struct Arc
{
   int noeud1;
   int noeud2;
   int poids;
};

const int NB_NOEUD_MAX = 1000;
const int INFINI       = 1000000000;

vector <Arc> arcs;
int nbNoeud, nbArc;

void bellmanFord(int depart, int arrivee)
{
   int plusCourtChemin[NB_NOEUD_MAX];
   int iEtape, iArc;
   int iNoeud;
   bool modification;

   for(iNoeud = 0; iNoeud < NB_NOEUD_MAX; ++iNoeud)
      plusCourtChemin[iNoeud] = INFINI;
   plusCourtChemin[arrivee] = 0;

   modification = false;
   for(iEtape = 0; iEtape <= nbNoeud; ++iEtape) {
      modification = false;
      for(iArc = 0; iArc < arcs.size(); ++iArc) {
         int noeud1, noeud2;
         int cheminVoisin;
         noeud1 = arcs[iArc].noeud1;
         noeud2 = arcs[iArc].noeud2;
         cheminVoisin = arcs[iArc].poids + plusCourtChemin[noeud2];
         if(cheminVoisin < plusCourtChemin[noeud1]) {
            plusCourtChemin[noeud1] = cheminVoisin;
            modification = true;
         }
      }
   }

   if(modification)
      printf("Cycle ameliorant !\n");
   else
      printf("%d\n", plusCourtChemin[depart]);
}

int main(void)
{
   int depart, arrivee;
   int iArc;

   scanf("%d %d\n", &depart, &arrivee);
   scanf("%d %d\n", &nbNoeud, &nbArc);

   for(iArc = 0; iArc < nbArc; ++iArc) {
      Arc nouveau;
      scanf("%d %d %d\n", &nouveau.noeud1, &nouveau.noeud2, &nouveau.poids);
      arcs.push_back(nouveau);
   }

   bellmanFord(depart, arrivee);
   return 0;
}
