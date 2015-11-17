Parcours d'un graphe
====================
algo/structure/graphe/

Publié le :  
*Modifié le : 17/11/2015*

## Introduction

Vous vous trouvez dans un labyrinthe contenant des milliards de chemins différents, de plusieurs millions de km chacun, et vous cherchez la sortie. Vous essayez dans un premier temps de sortir en essayant des chemins au hasard, mais vous abandonnez rapidement en vous rendant compte de la taille du labyrinthe. Vous avez donc besoin d'une solution qui marche à tous les coups, et deux solutions s'offrent alors à vous :

- Instinctivement, on peut essayer chaque possibilité de chemin jusqu'à trouver la sortie, ça marche même si c'est lent mais de toute façon nous n'avons aucune information sur le labyrinthe ou sur sa sortie, donc n'importe quelle possibilité pourrait être la bonne.
- On peut aussi tenter de parcourir petit à petit chaque possibilité de chemin, au lieu de faire une possibilité d'un coup, on essaie au fur et à mesure, en commençant par une "case" de profondeur dans chaque chemin, puis deux, puis trois, etc. jusqu'à arriver à notre sortie.

Dans les deux cas, on pourrait très bien parcourir toutes les possibilités et trouver la sortie comme étant la dernière. On se rend compte alors qu'il n'y a pas de solution dite *optimale* à ce problème si l'on ne connait rien sur notre labyrinthe. Les deux solutions ont alors leurs avantages et leurs inconvénients, et il faut savoir quand préférer l'une par rapport à l'autre.

Ce labyrinthe pourrait être représenté comme un [graphe](/algo/structure/graphe.html), où chaque "case" du labyrinthe représente un nœud du graphe, et un arc pourrait représenter un simple chemin ou bien une intersection. Maintenant qu'on voit notre labyrinthe comme un graphe, on peut aussi voir les deux choix de parcours comme les deux manières de parcourir un graphe, qu'on appelle respectivement : le parcours en profondeur, et le parcours en largeur.

## Le parcours en profondeur

### Principe

Le parcours en profondeur (ou plus communément *DFS* pour *Depth First Search*) permet de parcourir un graphe en utilisant le principe de la [récursivité](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29). Ce parcours a la particularité de parcourir les nœuds du graphe les plus "profonds" en premier (c'est-à-dire les plus éloignés du nœud de départ) avant de "remonter" progressivement dans le graphe.

Ce parcours s'assimile donc à notre première solution pour notre sortie de labyrinthe, on essaie une possibilité jusqu'au bout, on revient un peu en arrière sur la dernière intersection, on explore cette partie de nouveau en entier, on revient un peu en arrière, etc. 

### Exemple

La meilleure manière de comprendre ce parcours est de le visualiser sur un [arbre](/algo/structure/arbre.html) :

![Exemple de DFS sur un arbre](/static/img/algo/structure/graphe/dfs/exemple_dfs_arbre.png)

Chaque nœud représente l'ordre de parcours du dfs, on peut même y rajouter des flèches pour que ça soit plus clair :

![Exemple fléché de DFS sur un arbre](/static/img/algo/structure/graphe/dfs/exemple_dfs_arbre_fleche.png)

On voit bien qu'on parcourt tant qu'on peut les fils gauches, puis lorsqu'on est bloqué, on remonte tant qu'il n'y a pas de fils droit non parcouru, et lorsqu'on en trouve un on recommence l'opération.

Jusqu'ici nous n'avons vu notre algorithme en action uniquement sur un arbre car cela facilite la compréhension du parcours, mais de manière plus général on peut l'utiliser sur un graphe (on ne parlera plus alors de fils gauche ou droit, mais on prendra un voisin considéré tout simplement comme non parcouru) :

![Exemple de DFS sur un graphe](/static/img/algo/structure/graphe/dfs/exemple_dfs_graphe.png)

Techniquement sur un graphe, on peut le parcourir de différentes façons en utilisant un DFS en fonction de l'ordre de parcours des nœuds choisis.

### Pseudo-code

### Complexité

### Implémentation

## Le parcours en largeur

### Principe

### Exemple

### Pseudo-code

### Complexité

### Implémentation

## Quel parcours choisir ?

## Conclusion
