Arbre binaire
=============
algo/structure/arbre/

Publié le : 27/12/2015  
*Modifié le : 29/12/2015*

## Introduction

Je vous donne un tableau contenant des nombres entiers, et je vous pose une simple question : Quelle est la valeur maximale de ce tableau ? Naturellement, on peut parcourir notre tableau et comparer chaque élément afin de trouver le maximum, cet algorithme a une complexité linéaire en $O(N)$ avec $N$ la taille du tableau. Mais maintenant, je décide de changer quelques valeurs dans le tableau et je vous repose la question. On peut à nouveau parcourir tout le tableau, et comparer nos $N$ éléments pour chercher le maximum, mais peut-on faire mieux ? Comment trouver rapidement le maximum d'un tableau dynamique ?

Une idée serait de diviser notre gros problème en plus petits sous problèmes. Au lieu de se demander quel est le maximum de tout le tableau, on peut commencer par se demander quel est le maximum entre les deux premiers éléments du tableau, puis entre les deux suivants, etc. Une fois qu'on a tous ces maximums, on a divisé le nombre d'éléments à visiter par deux pour répondre à notre problème initial puisque désormais on peut simplement parcourir les maximums locaux pour trouver le maximum du tableau. Mais on peut continuer de diviser notre problème, en trouvant les maximums des maximums, etc. jusqu'à arriver à la valeur maximale contenue dans le tableau.

![Représentation des sous problèmes](//static.napnac.ga/img/algo/structure/arbre/arbre_binaire/representation_probleme_intro.png)

Les éléments en bleus représentent notre tableau initial, et l'élément en vert est le maximum du tableau trouvé grâce à notre méthode. On commence en bas avec notre tableau, et on monte progressivement en prenant à chaque fois les maximums deux à deux. Cette structure s'apparente à un [arbre](/algo/structure/arbre.html), mais a la particularité de ne pas posséder plus de deux fils par nœud (car on compare les éléments deux à deux à chaque fois). Cette propriété nous permet de démontrer qu'il suffit dans le pire des cas $log _2 N$ changements pour modifier le maximum du tableau (et donc la racine de l'arbre). C'est-à-dire que lorsqu'on modifie des valeurs, il suffit uniquement de modifier les pères des nœuds affectés, et de simplement remonter petit à petit à la racine en recalculant uniquement les maximums locaux nécessaires. Or, la hauteur de cet arbre est dans le pire des cas de $log _2 N$, notre algorithme a donc une complexité en $O(\log _2 N)$ pour trouver le maximum d'un tableau dynamique.

![Changement d'une valeur dans notre tableau](//static.napnac.ga/img/algo/structure/arbre/arbre_binaire/changement_valeur_intro.png)

Pour changer une valeur dans notre tableau (ici le 1 devient un 11), on change aussi les nœuds de l'arbre en remontant tant que le maximum local a changé.

Cette structure de données porte un nom : un arbre binaire (et plus particulièrement un arbre binaire maximal dans notre cas), et elle est très utile dans le domaine de la recherche, mais nous verrons que son utilisation ne se limite pas à cette catégorie d'algorithme et qu'elle est présente dans de nombreux autres structures de données plus complexes.

## Définition

Un arbre binaire (ou *binary tree* en anglais) est un type d'[arbre](/algo/structure/arbre.html) spécifique avec comme contrainte de ne pas avoir plus de deux fils par nœuds. On appelle alors les deux fils d'un nœud le *fils gauche* et le *fils droit*.

![Exemple d'arbre binaire](//static.napnac.ga/img/algo/structure/arbre/arbre_binaire/exemple_arbre_binaire.png)

Notre arbre binaire ici n'a aucune propriété spécifique, mais sachez qu'il peut être **maximal** (comme dans l'exemple de l'introduction), ou bien **minimal**. 

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

Chaque élément pointe alors vers ses deux fils, reliant ainsi les nœuds entre eux pour former notre arbre binaire. Cette solution permet un stockage optimal en mémoire, n'occupant rien de plus que nécessaire, mais peut être un inconvénient lorsqu'on a besoin d'accéder rapidement à des éléments (en effet, il faut parcourir l'arbre jusqu'à un élément particulier pour récupérer ses données).

### Tableau

Une autre implémentation consiste à utiliser un simple tableau, permettant un accès rapide (en $O(1)$) à n'importe quel élément, mais pouvant parfois être une perte de mémoire.

Pour stocker notre arbre binaire, on va prendre chaque élément de l'arbre profondeur par profondeur (de gauche à droite), et les placer dans le tableau dans cet ordre. 

![Exemple de représentation d'un arbre binaire dans un tableau](//static.napnac.ga/img/algo/structure/arbre/arbre_binaire/exemple_imple_tableau.png)

Ce tableau permet notamment un accès rapide, et un parcours facile grâce à sa manière de stocker les nœuds qui nous renseigne sur qui est le père/fils gauche/fils droit d'un nœud :

- La racine sera l'élément 1 du tableau.
- Chaque nœud d'indice $N$ a son fils gauche stocké en indice $2N$, et son fils droit en indice $2N + 1$.
- Chaque nœud d'indice $N$ (excepté pour la racine de l'arbre) a son père dans le tableau en indice $N / 2$ (on gardera juste la partie entière du résultat).

Ce tableau suffit donc à stocker un arbre binaire :

```c
int arbreBinaire[NB_NOEUD_ARBRE + 1];
```

On n'oublie pas d'allouer une case de plus dans notre tableau car la racine doit obligatoirement être l'élément d'indice 1 du tableau pour satisfaire les propriétés de placement des nœuds.

## Application

Cela peut paraitre étrange de penser qu'un simple arbre avec une contrainte sur le nombre de nœuds de ses fils peut être extrêmement utile. Et pourtant, les arbres binaires sont présents dans énormément d'algorithmes et de structures de données, et en voici une courte liste :

- **Recherche** :

      - Comme vu dans l'introduction, un arbre binaire peut être maximal ou minimal, facilitant la recherche du maximum/minimum dans un tableau dynamique.
      - Certains [arbres de recherche](/algo/structure/arbre/arbre_recherche.html) sont des arbres binaires, comme l'arbre rouge et noir ou encore l'arbre binaire de recherche.

- **Structure de données** :

      - Le [tas](/algo/structure/arbre/tas.html) est sans doute la structure de données basée sur un arbre binaire la plus utilisée. Elle est très efficace pour chercher mais aussi trier des éléments, et cette structure a comme l'arbre binaire, un champ d'application très large.
      - Le [T-tree](https://en.wikipedia.org/wiki/T-tree) est un arbre binaire modifié permettant de grandes optimisations de mémoire, souvent utilisé dans de grosses bases de données.

- **Tri** :

      - Le [tri par tas](/algo/tri/tri_tas.html) basé donc sur un tas, est un algorithme de tri efficace avec une complexité en temps de $O(N \log _2 N)$. De plus, son amélioration le smoothsort fondée elle aussi sur des arbres binaires, permet dans le meilleur des cas une complexité en temps linéaire.

- **Compression** :

      - Le [codage de Huffman](https://en.wikipedia.org/wiki/Huffman_coding) est un célèbre algorithme de compression des données sans perte, utilisant en partie des arbres binaires pour fonctionner.

- **Syntaxe** :

      - Les [arbres syntaxiques](https://en.wikipedia.org/wiki/Abstract_syntax_tree) sont eux aussi créés à partir d'arbre binaire, et sont le cœur du fonctionnement d'un compilateur ou tout autre parseur d'expression.

- **Géométrie/Graphique** :

      - La plupart des jeux 3D utilisent des [arbres binaires spécifiques](https://en.wikipedia.org/wiki/Binary_space_partitioning) afin de savoir quel objet a besoin d'être affiché ou non à l'écran.

## Conclusion

La liste des applications d'un arbre binaire peut continuer longtemps, car cette structure de données est fondamentale en algorithmique. Son principe est simple, son implémentation aussi, mais ses applications peuvent être très complexes.
