Plus court chemin
=================
algo/structure/graphe/

Publié le : 09/01/2016  
*Modifié le : 09/01/2016*

## Introduction

Comment votre GPS peut-il connaître le plus court chemin entre Paris et Grenoble aussi facilement ? De manière générale, on peut se demander comment calculer l'itinéraire entre deux points donnés d'une carte de telle sorte que la distance soit minimale ? On pourrait aller encore plus loin dans la généralisation, en représentant notre carte comme un [graphe](/algo/structure/graphe.html) et en transformant la question en : Quel est le plus court chemin entre un nœud A et B dans un graphe pondéré ?

Il existe différentes manières de répondre à cette question, et la réponse varie souvent en fonction du graphe donné en entrée de notre algorithme (pondéré positivement, négativement, dense, creux, etc.). Savoir reconnaître un problème de plus court chemin est donc important, et utiliser le bon algorithme l'est encore plus. Ces algorithmes ne se limitent pas à la création d'un simple GPS rudimentaire, mais peuvent aller bien plus loin et servent de base à de nombreuses autres applications.

## Dijkstra

### Principe

L'algorithme de Dijkstra est sans doute l'un des algorithmes de plus court chemin le plus connu. Ce dernier se base sur le [parcours en largeur](/algo/structure/graphe/parcours.html#le-parcours-en-largeur) afin de trouver le plus court chemin dans un graphe pondéré **positivement** (ce point est très important, mais nous en reviendrons plus en détails après). On sait que ce type de parcours permet de trouver le plus court chemin sur un graphe non pondéré (où on associe chaque arc avec une longueur arbitraire de 1 unité) et qu'il utilise une file pour stocker les éléments afin de les parcourir profondeur par profondeur. L'algorithme de Dijkstra s'appuie sur la même idée excepté qu'il ne va pas utiliser une simple file car tous les arcs n'ont pas la même pondération, mais une [file à priorité](/algo/structure/file.html#file-à-priorité). Cette dernière permet de toujours avoir le nœud avec la distance minimale par rapport au départ en tête de file, et garantit alors lorsqu'on atteint notre nœud de sortie qu'on a trouvé le plus court chemin.

### Exemple

Soit le graphe suivant :

![Exemple de graphe pondéré positivement](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/exemple_graphe_dijkstra.png)

### Pseudo-code

Le pseudo-code de l'algorithme de Dijkstra est donc identique à celui du parcours en profondeur, sauf qu'on utilise une file à priorité au lieu d'une file, qui va organiser les éléments en fonction de leur distance au nœud de départ :

```nohighlight
Dijkstra (depart) :

   depart.ditance = 0
   Enfiler le nœud de départ

   Tant que la file à priorité n'est pas vide
      Défiler le nœud au début de la file

      Si c'est le nœud d'arrivée
         Retourner noeud.distance

      Marquer le nœud comme visité
      Pour chaque voisin du nœud
         Si le voisin n'est pas visité
            voisin.distance = noeud.distance + arc
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

### Cas d'utilisation

## Ford-Bellman

## A* ?

## Floyd-Warshall ?

## Conclusion
