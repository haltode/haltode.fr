Path: algo/structure/arbre
Title: Arbre binaire
Published: 27/12/2015
Modified: 14/01/2016

## Introduction

Je vous donne un tableau contenant des nombres entiers, et je vous pose une simple question : Quelle est la valeur maximale de ce tableau ? Naturellement, on peut parcourir tous les éléments et les comparer afin de trouver le maximum, cet algorithme naïf a une complexité linéaire en $O(N)$ avec $N$ la taille du tableau. Mais maintenant, je décide de changer quelques valeurs dans le tableau et je vous repose la question. On peut à nouveau parcourir tout le tableau, et comparer nos $N$ éléments pour chercher le maximum, mais peut-on faire mieux ? Une des premières idées qui peut vous venir à l'esprit serait d'utiliser une variable en plus du tableau qui contient le maximum actuel, on l'initialise avec le maximum qu'on a trouvé en parcourant le tableau, et ensuite dès qu'on effectue une modification on compare cette variable aux valeurs que l'on change pour la mettre à jour. Cependant cette méthode, qui peut paraitre bien au premier coup d'œil, ne fonctionne pas dans tous les cas. Si la valeur que l'on change dans le tableau est l'ancien maximum (et donc la valeur de notre variable externe), alors il se peut que le nouveau maximum ne soit plus la valeur qu'on a changée mais une autre contenue dans le reste du tableau :

![Contre-exemple de l'algorithme proposé](/img/algo/structure/arbre/arbre_binaire/contre_exemple_intro.png)

Dans cet exemple, on part du tableau 8, 3, 14, 42, 2, 0 qu'on a parcouru et dont on a retenu la valeur maximale (en vert) dans notre variable à part : 42. Cependant, quand on change le maximum actuel par un nombre plus petit (7 dans notre cas), la variable externe ne change pas puisque 7 < 42 alors que le maximum du tableau n'est plus le même (c'est 14 désormais). Cet algorithme est donc invalide, et il nous en faut un nouveau pour trouver rapidement le maximum d'un tableau dynamique.

Une autre idée serait de diviser notre gros problème en plus petits sous problèmes. Au lieu de se demander quel est le maximum de tout le tableau, on peut commencer par se demander quel est le maximum entre les deux premiers éléments du tableau, puis entre les deux suivants, etc. Une fois qu'on a tous ces maximums, on a divisé le nombre d'éléments à visiter par deux pour répondre à notre problème initial puisque désormais on peut simplement parcourir les maximums locaux pour trouver le maximum du tableau. Mais on peut continuer de diviser notre problème, en trouvant les maximums des maximums, etc. jusqu'à arriver à la valeur maximale contenue dans le tableau.

![Représentation des sous problèmes](/img/algo/structure/arbre/arbre_binaire/representation_probleme_intro.png)

Les éléments en bleus représentent notre tableau initial, et l'élément en vert est le maximum du tableau trouvé grâce à notre méthode. On commence en bas avec notre tableau, et on monte progressivement en prenant à chaque fois les maximums deux à deux. Cette structure s'apparente à un [arbre](/algo/structure/arbre.html), mais a la particularité de ne pas posséder plus de deux fils par nœud (car on compare les éléments deux à deux à chaque fois). Cette propriété nous permet de démontrer qu'il suffit dans le pire des cas $log _2 N$ changements (en savoir plus sur les [logarithmes](https://en.wikipedia.org/wiki/Logarithm)) pour modifier le maximum du tableau (et donc la racine de l'arbre). C'est-à-dire que lorsqu'on modifie des valeurs, il suffit uniquement de modifier les pères des nœuds affectés, et de simplement remonter petit à petit à la racine en recalculant uniquement les maximums locaux nécessaires. Or, la hauteur de cet arbre est dans le pire des cas de $log _2 N$, notre algorithme a donc une complexité en $O(\log _2 N)$ pour trouver le maximum d'un tableau dynamique.

![Changement d'une valeur dans notre tableau](/img/algo/structure/arbre/arbre_binaire/changement_valeur_intro.png)

Pour changer une valeur dans notre tableau (ici le 1 devient un 11), on change aussi les nœuds de l'arbre en remontant tant que le maximum local a changé.

Cette structure de données porte un nom : un arbre binaire (et plus particulièrement un arbre binaire maximal dans notre cas), et elle est très utile dans le domaine de la recherche, mais nous verrons que son utilisation ne se limite pas à cette catégorie d'algorithme et qu'elle est présente dans de nombreux autres structures de données plus complexes.

## Définition

Un arbre binaire (ou *binary tree* en anglais) est un type d'[arbre](/algo/structure/arbre.html) spécifique avec comme contrainte de ne pas avoir plus de deux fils par nœuds. On appelle alors les deux fils d'un nœud le *fils gauche* et le *fils droit*.

![Exemple d'arbre binaire](/img/algo/structure/arbre/arbre_binaire/exemple_arbre_binaire.png)

Cette structure de données a l'avantage d'être très modulable et on peut lui appliquer différentes propriétés afin d'en changer son comportement, en voici quelques-unes :

- L'arbre binaire **maximal** a la particularité d'avoir chaque nœud parent comme étant le maximum de ses deux fils. C'est la structure utilisée dans l'exemple de l'introduction, on part d'un tableau initial et on crée l'arbre en prenant deux à deux les maximums en remontant jusqu'à avoir une racine.
- L'arbre binaire **minimal** repose sur le même principe que le précédent, sauf que chaque parent représente le minimum de ses fils.
- Un [**tas**](/algo/structure/arbre/tas.html) (et plus particulièrement un tas binaire) permet un stockage plus efficace qu'avec un arbre binaire max/min en évitant de créer des doublons des différents nœuds dans l'arbre, et répond rapidement à des questions de maximum/minimum dynamiques.
- Un **arbre binaire de recherche** attribue à chaque nœud une *clé* qui va organiser l'arbre. Tous les nœuds à gauche d'un nœud père auront tous des clés inférieures à ce dernier, et tous les nœuds à droite auront une clé supérieure.
- Un **arbre rouge et noir** est la même idée qu'un arbre binaire de recherche, excepté que chaque nœud a une *couleur* qui permet d'organiser l'arbre mais aussi de l'équilibrer pour ne pas avoir un côté bien plus grand que l'autre à cause de l'ordre des clés.

## Opérations

Dans un arbre binaire, ajouter et supprimer un élément est relativement simple, il suffit uniquement de respecter les propriétés de l'arbre utilisé. Dans notre cas, on utilise un arbre binaire normal :

![Exemple d'insertion de nœuds dans un arbre binaire](/img/algo/structure/arbre/arbre_binaire/exemple_insertion_noeud.png)

Ajouter un nœud suit une logique, on cherche à ne pas faire de "trous" dans notre arbre binaire, et on va donc combler tant que possible les espaces vides dans l'ordre (les nœuds en verts représentent le nouveau nœud à chaque étape).

Pour la suppression d'un nœud, il y a trois cas possibles :

- Soit le nœud à supprimer est une feuille, dans ce cas rien de plus simple et on le supprime sans se soucier du reste.
- Soit le nœud possède un fils, on remplace alors ce nœud par son unique fils.
- Soit le nœud a deux fils, et il faut décider quel nœud va remplacer le père, c'est assez ambigu car on ne peut pas réellement choisir dans un arbre binaire normal puisque les deux fils peuvent tous les deux remplacer le nœud parent, il faut donc choisir à l'avance selon ses propres critères. Heureusement, ce n'est pas toujours le cas et lorsque notre arbre binaire a des propriétés (ce qui arrivera souvent), on peut alors décider quel nœud choisir afin de remplacer le père, en fonction desdites propriétés.

![Différents cas de suppression de nœuds dans un arbre binaire](/img/algo/structure/arbre/arbre_binaire/exemple_suppression_noeud.png)

Dans le premier cas, *C* est une feuille, il n'y a donc aucuns soucis pour le supprimer. Dans le deuxième cas, *B* a un fils *D*, lorsqu'on supprime *B* on le remplace donc par *D*.

### Arbres binaires spécifiques

Dès qu'un arbre binaire possède des propriétés, les opérations d'insertion et de suppression sont différentes. Elles peuvent être plus ou moins complexes en fonction des propriétés ajoutées à l'arbre binaire, mais doivent être bien définies pour avoir une structure opérationnelle. D'autres opérations peuvent être utiles sur certains arbres binaires, par exemple la possibilité de changer une valeur dans un tableau (ce qui implique souvent des changements dans l'arbre en lui-même). Le parcours d'un arbre binaire peut aussi évoluer en fonction de ses caractéristiques, et même s'il reste un arbre, parfois il faut adapter sa méthode de parcours pour utiliser le mieux possible la structure de données.

## Implémentation

Même s'il est très rare de devoir implémenter un simple arbre binaire sans aucunes propriétés, savoir le représenter est important, car c'est en fonction de cette représentation que l'on peut ensuite construire des opérations spécifiques à la structure. Un arbre binaire n'est techniquement qu'une structure dérivée de l'arbre, on peut donc l'implémenter de la même façon que ce dernier, mais vu les contraintes de cette structure de données, il est possible d'utiliser d'autres manières.

### Recoder à la main

Les possibilités d'implémentation d'un arbre ne s'appliquent pas forcément bien pour un arbre binaire, en effet, on sait qu'il n'aura qu'au maximum deux fils, on peut donc simplement utiliser une structure auto référentielle :

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

Chaque nœud pointe alors vers ses deux fils, reliant ainsi les éléments entre eux pour former notre arbre binaire. Cette solution permet un stockage optimal en mémoire, ainsi qu'une facilité pour insérer et supprimer des éléments, mais elle peut être un inconvénient lorsqu'on a besoin d'accéder rapidement à des éléments (en effet, il faut parcourir l'arbre jusqu'à un élément particulier pour récupérer ses données).

### Tableau

Une autre implémentation consiste à utiliser un simple tableau, permettant un accès rapide en $O(1)$ à n'importe quel élément, mais qui est moins souple que la dernière solution. On l'utilise notamment pour construire des arbres binaires min ou max, car on n'a pas besoin de modifier d'autres nœuds que des feuilles dans ces derniers, et on veut souvent accéder à la racine rapidement.

Pour stocker notre arbre binaire, on va prendre chaque élément de l'arbre profondeur par profondeur (de gauche à droite), et les placer dans le tableau dans cet ordre. 

![Exemple de représentation d'un arbre binaire dans un tableau](/img/algo/structure/arbre/arbre_binaire/exemple_imple_tableau.png)

Ce tableau permet notamment un accès rapide, et un parcours facile grâce à sa manière de stocker les nœuds qui nous renseigne sur qui est le père/fils gauche/fils droit d'un nœud :

- La racine sera l'élément 1 du tableau.
- Chaque nœud d'indice $N$ a son fils gauche stocké en indice $2N$, et son fils droit en indice $2N + 1$.
- Chaque nœud d'indice $N$ (excepté pour la racine de l'arbre) a son père dans le tableau en indice $N / 2$ (on gardera juste la partie entière du résultat).

Ce tableau suffit donc à stocker un arbre binaire :

```c
int arbreBinaire[NB_NOEUD_ARBRE + 1];
```

On n'oublie pas d'allouer une case de plus dans notre tableau car la racine doit obligatoirement être l'élément d'indice 1 du tableau pour satisfaire les propriétés de placement des nœuds.

## Conclusion

Cela peut paraitre étrange de penser qu'un simple arbre avec une contrainte sur le nombre de nœuds de ses fils peut être extrêmement utile. Et pourtant, les arbres binaires sont présents dans énormément d'algorithmes et de structures de données, et en voici une courte liste :

- **Recherche** :

      - Comme vu dans l'introduction, un arbre binaire peut être maximal ou minimal, facilitant la recherche du maximum/minimum dans un tableau dynamique.
      - Certains [arbres de recherche](/algo/structure/arbre/arbre_recherche.html) sont des arbres binaires, comme l'arbre rouge et noir ou encore l'arbre binaire de recherche dont nous avons parlé.

- **Structure de données** :

      - Le [tas](/algo/structure/arbre/tas.html) est sans doute la structure de données basée sur un arbre binaire la plus utilisée. Elle est très efficace pour chercher mais aussi trier des éléments, et cette structure a comme l'arbre binaire, un champ d'application très large.
      - Le [T-tree](https://en.wikipedia.org/wiki/T-tree) est un arbre binaire modifié permettant de grandes optimisations de mémoire, souvent utilisé dans de grosses bases de données.

- **Tri** :

      - Le [tri par tas](/algo/tri/tri_tas.html) basé donc sur un tas, est un algorithme de tri efficace avec une complexité en temps de $O(N \log _2 N)$. De plus, son amélioration le smoothsort fondée elle aussi sur des arbres binaires, permet dans le meilleur des cas une complexité en temps linéaire.

- **Compression** :

      - Le [codage de Huffman](https://en.wikipedia.org/wiki/Huffman_coding) est un célèbre algorithme de compression des données sans perte, utilisant en partie des arbres binaires pour fonctionner.

- **Syntaxe** :

      - Les [arbres syntaxiques](https://en.wikipedia.org/wiki/Abstract_syntax_tree) sont eux aussi créés à partir d'arbres binaires, et sont le cœur du fonctionnement d'un compilateur ou tout autre parseur d'expression.

- **Géométrie/Graphique** :

      - La plupart des jeux 3D utilisent des [arbres binaires spécifiques](https://en.wikipedia.org/wiki/Binary_space_partitioning) afin de savoir quel objet a besoin d'être affiché ou non à l'écran.

La liste des applications d'un arbre binaire peut continuer longtemps, car cette structure de données est fondamentale en algorithmique. Son principe est simple, son implémentation aussi, mais ses applications peuvent être très complexes.
