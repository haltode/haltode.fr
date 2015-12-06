#include <cstdio>
#include <vector>
#include <queue>
using namespace std;

const int NB_NOEUD_MAX = 1000;

vector <int> graphe[NB_NOEUD_MAX];
bool dejaVu[NB_NOEUD_MAX];

void BFS(int debut)
{
   queue <int> file;
   int actuel;
   int iVoisin;

   file.push(debut);

   while(!file.empty()) {
      actuel = file.front();
      file.pop();

      printf("%d\n", actuel);

      dejaVu[actuel] = true;

      for(iVoisin = 0; iVoisin < graphe[actuel].size(); ++iVoisin)
         if(!dejaVu[graphe[actuel][iVoisin]])
            file.push(graphe[actuel][iVoisin]);
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

   BFS(1);

   return 0;
}
