Graphe
======
algo/structure/

Publié le : 20/06/2015  
*Modifié le :*

## Introduction

Un graphe est une structure de données incontournable en algorithmie. On utilise les graphes dans de nombreux problèmes de la vie de tous les jours, comme par exemple dans le métro, en utilisant le GPS, ou bien en naviguant sur Internet.

## Principe d'un graphe

On peut définir un graphe comme étant un ensemble de *nœuds* (ou de sommets) étant reliés par des 
*arcs* (ou des arêtes).

![Exemple de graphe](/static/img/algo/structure/graphe/graphe_exemple.png)

## Vocabulaire

Si deux nœuds sont reliés par un arc, on dit qu'ils sont *voisins*.

Le *degré entrant* d'un nœud correspond au nombre d'arcs arrivant sur ce nœud, il en est de même pour le *degré sortant* correspondant alors au nombre d'arcs sortant du nœud.

Un graphe peut avoir de nombreuses caractéristiques différentes, en voici une liste non exhaustive.

### Orienté/non orienté

Un graphe est dit *orienté* si ses arcs ont un sens (représenté par une flèche), comme par exemple ce graphe :

![Graphe orienté](/static/img/algo/structure/graphe/graphe_oriente.png)

En revanche on dit d'un graphe qu'il est *non orienté* si aucun sens n'est attribué à ses arcs :

![Graphe non orienté](/static/img/algo/structure/graphe/graphe_non_oriente.png)

Dans ce cas précis, on peut donc parcourir les arcs dans les deux sens.

### Pondéré/non pondéré

Un graphe est *pondéré* si ses arcs ont un *poids* :

![Graphe pondéré](/static/img/algo/structure/graphe/graphe_pondere.png)

Dans cet exemple on utilise le graphe pour représenter une carte routière avec comme pondération la distance séparant deux villes.

### Cyclique/acyclique

Un graphe est *cyclique* s'il contient des cycles (un chemin finissant là où il a commencé) :

![Graphe cyclique](/static/img/algo/structure/graphe/graphe_cyclique.png)

Un graphe qui ne contient aucun cycle est donc caractérisé d'*acyclique* :

![Graphe acyclique](/static/img/algo/structure/graphe/graphe_acyclique.png)

### Dense/creux

On peut dire d'un graphe qu'il est *dense* si le nombre d'arcs est proche du nombre maximum possible de ce graphe :

![Graphe dense](/static/img/algo/structure/graphe/graphe_dense.png)

Lorsque le nombre d'arcs est faible, on parle d'un graphe *creux* :

![Graphe creux](/static/img/algo/structure/graphe/graphe_creux.png)

## Implémentation

On peut implémenter un graphe de différentes façons.

### Matrice d'adjacence

Une matrice d'adjacence est comme son nom l'indique un tableau 2D qui permet de représenter des arcs entre deux nœuds. On peut utiliser un tableau 2D de booléen (`true` = arc, `false` = pas d'arc), ou bien un tableau 2D d'entier (ou de flottant) qui permet alors de stocker les pondérations des arcs (*X* = pondération de l'arc, 0 = par d'arc).

Voici un exemple de matrice d'adjacence (j'ai utilisé le tout premier graphe de l'article pour construire la matrice) :

![Exemple de matrice d'adjacence](/static/img/algo/structure/graphe/exemple_matrice_adjacence.png)

Rien de bien compliqué pour l'implémenter :

```c
int graphe[NB_NOEUD_MAX][NB_NOEUD_MAX];
```

Encore une fois, on peut changer le type de la matrice en fonction de nos besoins (`bool`, `float`, `double`...).

On utilise ce type de représentation lorsqu'on a tout d'abord assez de mémoire, puis lorsqu'on a besoin d'accéder souvent et rapidement à des informations du type :

   - Est-ce que le nœud *A* et le nœud *B* sont voisins ?
   - Quel est le poids de l'arc entre le nœud *C* et *D* ?

La complexité en mémoire est en *O(N²)* (avec *N* le nombre de nœuds du graphe) et la complexité pour accéder aux deux informations citées au dessus est en *O(1)* (puisqu'il s'agit d'un tableau).

### Liste d'adjacence

On peut utiliser une variante de la matrice d'adjacence afin d'économiser de la mémoire (mais cette représentation requiert un temps en *O(N)* pour savoir si deux nœuds sont voisins ou pour connaître la pondération de tel arc). Cette solution consiste à utiliser un tableau de [listes chaînées](http://napnac.ga/algo/structure/liste_chainee.html), chaque nœud du graphe a sa propre liste chaînée contenant tous ses voisins (et éventuellement toutes les pondérations).

Voici par exemple la liste d'adjacence qui représente le premier graphe de l'article :

![Exemple de liste d'adjacence](/static/img/algo/structure/graphe/exemple_liste_adjacence.png)

Pour l'implémentation, j'utilise les `vector` du C++ au lieu de recoder à la main la liste chaînée en C (même si on peut tout à fait le faire, recoder des structures de données basiques en concours notamment est tout simplement une perte de temps) :

```cpp
vector <Voisin> graphe[NB_NOEUD_MAX];
```

La structure `Voisin` contient l'index du voisin, mais elle peut aussi contenir la pondération de l'arc liant les deux nœuds et d'autres informations spécifiques au graphe.

La liste d'adjacence est le plus souvent utilisée lorsque :

- On a pas assez de mémoire pour stocker une matrice d'adjacence : la complexité en mémoire d'une liste d'adjacence est de  *O(N + M)* (avec *M* le nombre d'arcs du graphe)
- On ne cherche pas à répondre aux questions du types tel nœud est-il voisin à tel autre nœud ? Ou encore quel est le poids de tel arc entre ces deux nœuds ? Mais plutôt lorsqu'on cherche à parcourir le graphe plus rapidement qu'en utilisant une matrice d'adjacence. En effet, dans une liste d'adjacence il n'y a que les voisins du nœud en question, alors que dans la matrice tous les nœuds sont représentés.

### Liste d'arcs

Enfin on peut utiliser une dernière solution, en représentant tous les arcs du graphe dans une liste chaînée.

Voici l'exemple d'une liste d'arcs (toujours sur le même graphe) :

![Exemple de liste d'arcs](/static/img/algo/structure/graphe/exemple_liste_arcs.png)

Pareil que pour la liste d'adjacence, j'utilise les `vector` :

```cpp
vector <Arc> graphe;
```

La structure `Arc` contient l'index des deux nœuds ainsi que la pondération de l'arc (si c'est un graphe pondéré).

Une liste d'arcs est plus rarement utilisée pour représenter un graphe, mais peut s'avérer très utile lorsqu'on a pas assez de mémoire (à cause du nombre trop élevé de nœuds) pour représenter le graphe avec une matrice d'adjacence ou même une liste d'adjacence. On utilise donc une liste d'arcs avec une complexité en mémoire de *O(M)*.

## Parcourir un graphe

Afin de parcourir notre graphe, on peut utiliser deux algorithmes différents :

- [Parcours en profondeur]() : DFS (*Depth First Search*)
- [Parcours en largeur]() : BFS (*Breadth First Search*)

## Opérations utiles sur un graphe

Voici une liste non exhaustive d'opérations utiles lorsqu'on manipule un graphe : 

- Détection de cycle
- Tri topologique
- Arc essentiel
- Circuit eulérien
- Recherche du plus court chemin
- Arbre couvrant minimal
- Composante fortement connexe

## Conclusion

Un graphe est une structure de données incontournable, utilisée dans de très nombreux problèmes (plus ou moins complexes) dans la vie de tous les jours dans beaucoup de domaines différents comme :

- La planification de tâches
- L'utilisation d'internet
- Les cartes routières
- La création d'itinéraire
- Les composants d'un circuit électronique
- La représentation de molécule chimique
- ...

