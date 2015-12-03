#include <cstdio>
#include <vector>
#include <stack>
using namespace std;

const int NB_NOEUD_MAX = 1000;

vector <int> graphe[NB_NOEUD_MAX];
bool dejaVu[NB_NOEUD_MAX];

void DFS(int debut)
{
   stack <int> pile;
   int actuel;
   int iVoisin;

   pile.push(debut);

   while(!pile.empty()) {
      actuel = pile.top();
      pile.pop();

      printf("%d\n", actuel);

      dejaVu[actuel] = true;

      for(iVoisin = 0; iVoisin < graphe[actuel].size(); ++iVoisin)
         if(!dejaVu[graphe[actuel][iVoisin]])
            pile.push(graphe[actuel][iVoisin]);
   }
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
