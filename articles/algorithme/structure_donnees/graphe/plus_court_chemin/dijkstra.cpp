#include <cstdio>
#include <vector>
#include <queue>
using namespace std;

struct Noeud
{
   int index;
   int distance;

   bool operator < (const Noeud &autre) const
   {
      if(distance < autre.distance)
         return false;
      else
         return true;
   }
};

const int NB_NOEUD_MAX = 1000;

vector <Noeud> voisin[NB_NOEUD_MAX];
bool dejaVu[NB_NOEUD_MAX];

int dijkstra(int depart, int arrivee)
{
   priority_queue <Noeud> file;
   Noeud initial, actuel;
   int iVoisin;

   initial.index = depart;
   initial.distance = 0;

   file.push(initial);
   while(!file.empty()) {
      actuel = file.top();
      file.pop();

      if(actuel.index == arrivee)
         return actuel.distance;
      if(dejaVu[actuel.index])
         continue;

      dejaVu[actuel.index] = true;
      for(iVoisin = 0; iVoisin < voisin[actuel.index].size(); ++iVoisin) {
         if(!dejaVu[voisin[actuel.index][iVoisin].index]) {
            Noeud nouveau;
            nouveau.index = voisin[actuel.index][iVoisin].index;
            nouveau.distance =   actuel.distance +
                                 voisin[actuel.index][iVoisin].distance;
            file.push(nouveau);
         }
      }
   }

   return -1;
}

int main(void)
{
   int nbArc;
   int iArc;

   scanf("%d\n", &nbArc);

   for(iArc = 0; iArc < nbArc; ++iArc) {
      int noeud1, noeud2, distance;
      Noeud nouveau;
      scanf("%d %d %d\n", &noeud1, &noeud2, &distance);
      nouveau.distance = distance;

      nouveau.index = noeud2;
      voisin[noeud1].push_back(nouveau);
      nouveau.index = noeud1;
      voisin[noeud2].push_back(nouveau);
   }

   printf("%d\n", dijkstra(1, 6));

   return 0;
}
