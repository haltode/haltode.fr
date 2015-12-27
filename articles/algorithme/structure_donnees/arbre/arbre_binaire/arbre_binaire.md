Arbre binaire
=============
algo/structure/arbre/

Publié le : 27/12/2015  
*Modifié le : 27/12/2015*

## Introduction

## Principe d'un arbre binaire

Un arbre binaire est un type d'[arbre](/algo/structure/arbre.html) spécifique avec comme contrainte de ne pas avoir plus de deux fils par nœuds. On appelle alors les deux fils d'un nœud le *fils gauche* et le *fils droit*.

![Exemple d'arbre binaire](//static.napnac.ga/img/algo/structure/arbre/arbre_binaire/exemple_arbre_binaire.png)

Cette définition est assez simple, mais cette structure de données est la base de nombreuses autres plus complexes, et on retrouve son utilisation dans plusieurs domaines très variés.

## Implémentation

Un arbre binaire reste un arbre, on peut donc l'implémenter de la même façon que ce dernier, mais vu les propriétés de cette structure de données, il est possible de l'implémenter de différentes façons.

### Recoder à la main

Les possibilités d'implémentation d'un arbre ne s'applique pas forcément bien pour un arbre binaire, en effet, on sait qu'il n'aura qu'au maximum deux fils, on peut donc simplement utiliser une structure auto référentielle :

```c
typedef struct Noeud Noeud;
struct Noeud 
{
   Noeud *gauche;
   Noeud *droit;
   int donnee;
};

typedef Noeud *ArbreBinaire;
```

Chaque élément pointe alors vers ses deux fils, reliant ainsi les nœuds entre eux pour former notre arbre binaire. Cette solution permet un stockage optimal en mémoire, n'occupant rien de plus que nécessaire, mais peut être un inconvénient lorsqu'on a besoin d'accéder rapidement à des éléments (en effet, il faut parcourir l'arbre jusqu'à cet élément pour récupérer ses données).

### Tableau

Une autre implémentation consiste à utiliser un simple tableau, permettant un accès rapide (en *O(1)*) à n'importe quel élément, mais peut parfois être une perte de mémoire. 

Pour stocker notre arbre binaire, il faut cependant respecter quelques règles :

- La racine sera l'élément 1 du tableau.
- Chaque nœud d'indice *N* a son fils gauche stocké en indice *2 \* N*, et son fils droit en indice *2 \* N + 1*.
- Chaque nœud d'indice *N* (excepté pour la racine de l'arbre) a son père dans le tableau en indice *N / 2*.

La taille du tableau doit être de *2^(H + 1)* avec *H* la hauteur de notre arbre binaire.

![Exemple de représentation d'un arbre binaire dans un tableau](//static.napnac.ga/img/algo/structure/arbre/arbre_binaire/exemple_imple_tab.png)

Une implémentation en C d'un arbre binaire stocké dans un tableau :

[INSERT]
arbre_binaire_tableau.c

## Conclusion

Application :

- Recherche + tri

   - Tri par tas + smoothsort

   - Arbre de recherche : arbre binaire min/max +  arbre binaire de recherche, arbre rouge et noir
   - Tas : tas binaire + file à priorité
   - Trie : trie binaire
