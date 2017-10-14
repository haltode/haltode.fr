#include <cstdio>
#include <vector>
using namespace std;

const int NB_NOEUD_MAX = 1000;

vector <int> graphe[NB_NOEUD_MAX];
bool dejaVu[NB_NOEUD_MAX];

void DFS(int noeud)
{
   printf("%d\n", noeud);

   dejaVu[noeud] = true;

   int iVoisin;
   for(iVoisin = 0; iVoisin < graphe[noeud].size(); ++iVoisin)
      if(!dejaVu[graphe[noeud][iVoisin]])
         DFS(graphe[noeud][iVoisin]);
}

int main(void)
{
   int nbArc;
   int iArc;

   scanf("%d\n", &nbArc);
   for(iArc = 0; iArc < nbArc; ++iArc) {
      int noeud1, noeud2;       
      scanf("%d %d\n", &noeud1, &noeud2);
      graphe[noeud1].push_back(noeud2);
   }
   
   DFS(1);

   return 0;
}
