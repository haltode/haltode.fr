Parcours d'un graphe
====================
algo/structure/graphe/

Publié le :  
*Modifié le : 03/12/2015*

## Introduction

Le parcours d'un [graphe](/algo/structure/graphe.html) est une opération essentielle à connaître à propos de cette structure. Il est fondamental de maitriser les différents algorithmes de parcours de graphe, ainsi que leur application et surtout savoir quand les utiliser en fonction de la situation.

## Le parcours en profondeur

Vous vous trouvez dans un labyrinthe contenant de nombreux chemins possibles, et vous cherchez la sortie alors que vous ne connaissez aucunes indications sur ce labyrinthe. Tout d'abord, on peut représenter notre labyrinthe comme un graphe dit *implicite*, qui sera non pondéré (chaque arc aura alors une distance de *1* unité). En effet, chaque intersection sera représentée par un nœud du graphe, et chaque chemin par un arc. L'entrée et la sortie du labyrinthe sont juste de simples nœuds distincts du graphe, et le fait de trouver la sortie du labyrinthe, revient à trouver un chemin reliant le nœud d'entrée au nœud de sortie.

Vu qu'on ne connait rien sur ce labyrinthe, il est impossible de deviner le chemin nous permettant d'arriver à la sortie puisque ça pourrait être n'importe lequel du graphe. On peut donc tout simplement essayer chacun des chemins jusqu'à trouver le bon. Ce parcours est alors qualifié de : parcours en profondeur.

### Principe

Le parcours en profondeur (ou plus communément *DFS* pour *Depth First Search*) permet de parcourir un graphe en utilisant le principe de la [récursivité](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29). Ce parcours visite les nœuds du graphe les plus "profonds" en premier (c'est-à-dire les plus éloignés du nœud de départ), avant de "remonter" progressivement dans le graphe.

Dans notre cas du labyrinthe, on essaie un chemin jusqu'à être bloqué, puis on revient à la dernière intersection, on continue jusqu'à être bloqué, on revient à la dernière intersection, etc. jusqu'à tomber sur la sortie.

### Exemple

La meilleure manière de comprendre ce type de parcours est de le visualiser :

![Exemple de DFS sur un graphe](//static.napnac.ga/img/algo/structure/graphe/dfs/exemple_dfs.png)

Ce graphe représente notre labyrinthe, et chaque nœud correspond à l'ordre de parcours du DFS (la flèche montre uniquement comment agit un parcours en profondeur en entier sur notre graphe).

Si par exemple notre entrée de labyrinthe est le nœud 1, et que notre sortie est le nœud 6, on parcourra avant de trouver la sortie, les nœuds 2, 3, 4, et 5.

Cependant sur un graphe, on peut effectuer un DFS de différentes façons en fonction de l'ordre de visite des voisins. Par exemple, on aurait pu après le nœud 1 visiter le nœud 7, puis le 9, puis le 8, puis le 6, le 2, le 4, le 5, et enfin le 3. Ce parcours est bien un DFS, mais il est juste différent car on a choisi un autre ordre pour parcourir les voisins des nœuds rencontrés.

### Pseudo-code

On utilise le principe de la récursivité pour définir notre parcours en profondeur :

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

Une implémentation récursive en C++ (j'utilise le C++ afin d'avoir les `vector` pour représenter notre graphe) :

[INSERT]
dfs_recursif.cpp

Si en entrée on donne notre graphe (celui de l'exemple et sous forme d'une liste d'arcs) :

[INSERT]
test01.in

On obtient bien en sortie :

```
$ ./recursif < test01.in
1
2
3
4
5
6
7
8
9
```

Et pour vous montrer que l'ordre d'un parcours en profondeur peut changer selon l'ordre des voisins visités, prenons le même graphe mais avec un ordre différent dans sa description (l'ordre inverse) :

[INSERT]
test02.in

En sortie cette fois on a :

```
$ ./recursif < test02.in
1
7
9
8
6
2
4
5
3
```

#### Itératif

Il est rare d'implémenter de façon itérative un parcours en profondeur, mais cela peut être utile pour ne pas faire exploser la [pile d'appels](https://en.wikipedia.org/wiki/Call_stack) à cause des nombreux appels récursifs imbriqués provoqués par notre dernière implémentation.

Pour passer de la version récursive à la version itérative, on utilise simplement une [pile](/algo/structure/pile.html) afin de "simuler" la pile d'appel. En effet, si on empile les voisins du nœud actuel au lieu de faire un appel récursif dessus, on gardera un parcours en profondeur car la pile d'appel reste néanmoins une pile avec quelques informations supplémentaires. Pour vous convaincre je vous invite à essayer de faire un exemple, en empilant les voisins au lieu de faire un appel récursif, vous verrez que le principe du parcours en profondeur est bien le même avec une pile.

[INSERT]
dfs_iteratif.cpp

En entrée :

[INSERT]
test01.in

Et la sortie affichée :

```
$ ./iteratif < test01.in
1
7
9
8
6
2
4
5
3
```

Et si on donne notre entrée modifiée (à l'envers) :

[INSERT]
test02.in

On a en sortie cette fois :

```
$ ./iteratif < test02.in
1
2
3
4
5
6
7
8
9
```

Vous constatez donc que la pile "inverse" l'ordre, tout simplement car lorsqu'on parcourt la liste des voisins, on ne visite pas le voisin dès qu'on en a trouvé un non visité (comme le fait la version récursive), mais on les empile tous, et ils vont donc se superposer (ce qui va "inverser" l'ordre car c'est le principe d'une pile : le dernier arrivé, le premier sorti).

### Utilisation

## Le parcours en largeur

### Principe

### Exemple

### Pseudo-code

### Complexité

### Implémentation

### Utilisation

## Conclusion
