Plus court chemin
=================
algo/structure/graphe/

Publié le : 09/01/2016  
*Modifié le : 13/03/2016*

## Introduction

Comment votre GPS peut-il connaître le plus court chemin entre Paris et Grenoble aussi facilement ? De manière générale, on peut se demander comment calculer l'itinéraire entre deux points donnés d'une carte de telle sorte que la distance soit minimale ? On pourrait aller encore plus loin dans la généralisation, en représentant notre carte comme un [graphe](/algo/structure/graphe.html) et en transformant la question en : quel est le plus court chemin entre un nœud A et B dans un graphe pondéré ?

Il existe différentes manières de répondre à cette question, et la réponse varie souvent en fonction du graphe donné en entrée de notre algorithme (pondéré positivement, négativement, dense, creux, etc.). Savoir reconnaître un problème de plus court chemin est donc important, et utiliser le bon algorithme l'est encore plus. Ces algorithmes ne se limitent pas à la création d'un simple GPS rudimentaire, mais peuvent aller bien plus loin et servent de base à de nombreuses autres applications.

## Dijkstra

### Principe

L'algorithme de Dijkstra est sans doute l'un des algorithmes de plus court chemin le plus connu. Ce dernier se base sur le [parcours en largeur](/algo/structure/graphe/parcours.html#le-parcours-en-largeur) afin de trouver le plus court chemin dans un graphe pondéré **positivement** (ce point est très important, mais nous en reviendrons plus en détails après). On sait qu'un parcours en largeur permet de trouver le plus court chemin sur un graphe non pondéré (où on associe chaque arc avec une longueur arbitraire de 1 unité) et qu'il utilise une file pour stocker les éléments afin de les parcourir profondeur par profondeur. L'algorithme de Dijkstra s'appuie sur la même idée, sauf qu'il ne va pas utiliser une simple file (car tous les arcs n'ont pas la même pondération) mais une [file à priorité](/algo/structure/file.html#file-à-priorité). Cette dernière permet de toujours avoir le nœud avec la distance minimale par rapport au départ en tête de file, et garantie alors qu'on a trouvé le plus court chemin lorsqu'on atteint le nœud de sortie.

### Exemple

Soit le graphe suivant :

![Exemple de graphe pondéré positivement](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/exemple_graphe_dijkstra.png)

On a en bleu le nœud de départ, et en vert le nœud d'arrivée. Ici, on peut facilement trouver le plus court chemin à la main : 1, 3, 4, 6 (pour un coût total de 7 unités).

### Pseudo-code

Le pseudo-code de l'algorithme de Dijkstra est donc identique à celui du parcours en profondeur, sauf qu'on utilise une file à priorité au lieu d'une file, afin d'organiser les éléments en fonction de leur distance au nœud de départ :

```nohighlight
Dijkstra (départ, arrivée) :

   départ.distance = 0
   Enfiler le nœud de départ

   Tant que la file à priorité n'est pas vide
      Défiler le nœud au début de la file

      Si c'est le nœud d'arrivée
         Retourner nœud.distance

      Marquer le nœud comme visité
      Pour chaque voisin du nœud
         Si le voisin n'est pas visité
            voisin.distance = nœud.distance + arc
            Enfiler le voisin
```

### Complexité

### Implémentation

Une implémentation en C++ (pour avoir [`priority_queue`](http://www.cplusplus.com/reference/queue/priority_queue/)) de cet algorithme :

[INSERT]
dijkstra.cpp

Le graphe d'entrée :

[INSERT]
test01.in

Et le plus court chemin en sortie :

[INSERT]
test01.out

La structure du code est identique à celle du parcours en profondeur, on doit juste utiliser une structure afin de représenter nos nœuds (du graphe, et de notre file) et aussi décrire l'opérateur `<` pour que l'implémentation de la `priority_queue` puisse fonctionner correctement en fonction de la variable `distance` de chacun des nœuds.

### Cas d'utilisation

## Ford-Bellman

## A* ?

## Floyd-Warshall ?

## Conclusion
