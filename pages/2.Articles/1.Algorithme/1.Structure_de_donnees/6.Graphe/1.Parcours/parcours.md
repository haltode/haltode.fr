Parcours d'un graphe
====================
algo/structure/graphe/

Publié le :  
*Modifié le : 01/12/2015*

## Introduction

Le parcours d'un [graphe](/algo/structure/graphe.html) est une opération essentielle à connaître à propos de cette structure. Il est fondamental de maitriser les différents algorithmes de parcours de graphe, ainsi que leur application et surtout savoir quand les utiliser en fonction de la situation.

## Le parcours en profondeur

Vous vous trouvez dans un labyrinthe contenant de nombreux chemins possibles, et vous cherchez la sortie alors que vous ne connaissez aucunes indications sur ce labyrinthe. Tout d'abord, on peut représenter notre labyrinthe comme un graphe dit *implicite*, qui sera non pondéré (chaque arc aura alors une distance de *1* unité). En effet, chaque intersection sera représentée par un nœud du graphe, et chaque chemin par un arc. L'entrée et la sortie du labyrinthe sont juste de simples nœuds distincts du graphe, et le fait de trouver la sortie du labyrinthe, revient à trouver un chemin reliant le nœud d'entrée au nœud de sortie.

Vu qu'on ne connait rien sur ce labyrinthe, il est impossible de deviner le chemin nous permettant d'arriver à la sortie puisque ça pourrait être n'importe lequel du graphe. On peut donc tout simplement essayer chacun des chemins jusqu'à trouver le bon. Ce parcours est alors qualifié de : parcours en profondeur.

### Principe

Le parcours en profondeur (ou plus communément *DFS* pour *Depth First Search*) permet de parcourir un graphe en utilisant le principe de la [récursivité](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29). Ce parcours se distingue facilement car il visite les nœuds du graphe les plus "profonds" en premier (c'est-à-dire les plus éloignés du nœud de départ), avant de "remonter" progressivement dans le graphe.

Dans notre cas du labyrinthe, on essaie un chemin jusqu'à être bloqué, puis on revient à la dernière intersection, on continue jusqu'à être bloqué, on revient à la dernière intersection, etc. jusqu'à tomber sur la sortie.

### Exemple

La meilleure manière de comprendre ce type de parcours est de le visualiser :

![Exemple de DFS sur un graphe](/static/img/algo/structure/graphe/dfs/exemple_dfs.png)

Ce graphe représente notre labyrinthe, et chaque nœud correspond à l'ordre de parcours du DFS (en plus de la flèche montrant comment agit un parcours en profondeur en entier sur notre graphe).

Si par exemple notre entrée de labyrinthe est le nœud 1, et que notre sortie est le nœud 6, on parcourra avant de trouver la sortie, les nœuds 2, 3, 4, et 5.

Techniquement sur un graphe, on peut effectuer un DFS de différentes façons en fonction de l'ordre de visite des voisins. Par exemple, on aurait pu après le nœud 1 visiter le nœud 7, puis le 9, puis le 8, puis le 6, le 2, le 4, le 5, et enfin le 3. Ce parcours est bien un DFS, mais il est juste différent car on a choisi un autre ordre pour parcourir les voisins des nœuds rencontrés.

### Pseudo-code

```nohighlight
DFS (noeud) :
  
   Marquer le nœud comme visité

   Pour chaque voisin du nœud passé en paramètre
      Si le voisin n'est pas marqué visité
         DFS(voisin)
```

### Complexité

Dans le pire des cas, si notre sortie est le dernier nœud que l'on visite, notre algorithme va devoir parcourir les *M* arcs du graphe, on a donc une complexité en temps linéaire de *O(M)*.

### Implémentation

On peut implémenter un DFS de deux manières différentes, même si on a plutôt tendance à le coder de manière récursive car le code est plus court et plus intuitif.

#### Récursif

Une implémentation récursive en C++ (j'utilise le C++ afin d'utiliser les `vector` pour représenter notre graphe) :

[INSERT]
dfs_recursif.cpp

#### Itératif

[REFAIRE EXPLICATION + AVANTAGE VERSION ITERATIVE]

Pour passer de la version récursive à la version itérative, on utilise simplement une [pile](/algo/structure/pile.html) afin de "simuler" la pile d'appel récursif créée par notre dernière implémentation. En effet, si on empile les voisins du nœud actuel au lieu de faire un appel récursif, l'ordre de parcours sera conservé car la pile d'appel d'une fonction est une pile toute simple finalement. Pour vous convaincre je vous invite à essayer de faire un exemple, en empilant les voisins au lieu de faire un appel récursif, vous verrez que le principe du parcours en profondeur est bien le même avec une pile.

[INSERT]
dfs_iteratif.cpp

## Le parcours en largeur

### Principe

### Exemple

### Pseudo-code

### Complexité

### Implémentation

## Quel parcours choisir ?

## Conclusion
