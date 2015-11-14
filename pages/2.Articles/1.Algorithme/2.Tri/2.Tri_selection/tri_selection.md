Tri par sélection
=================
algo/tri

Publié le : 30/04/2014  
*Modifié le : 14/11/2015*

## Introduction

Le tri par sélection (*selection sort* en anglais) est un algorithme de tri par comparaison simple, mais assez inefficace sur une entrée trop importante, c’est un algorithme non [stable](https://en.wikipedia.org/wiki/Sorting_algorithm#Stability) mais qui trie [en place](https://en.wikipedia.org/wiki/In-place_algorithm). Il a pour complexité algorithmique *O(N²)* comme le [tri à bulles](/algo/tri/tri_bulles.html).

## Principe de l’algorithme

Le tri par sélection se décompose en deux étapes :

- Sélectionner un élément (d'où son nom)
- Le placer à sa bonne place

Le facteur qui détermine si un élément est bien placé est son rang (par exemple : le *ième* plus petit élément sera forcément placé en *ième* position du tableau). Le tri par sélection va donc à chaque tour trouver le *ième* plus petit élément du tableau, pour ensuite l'insérer à sa place, en commençant par le premier plus petit, et en augmentant à chaque fois (deuxième plus petit, troisième, etc.).

## Exemple
 
Prenons désormais comme exemple la suite de nombres suivante : 6, 1, 9, 3. Trions cette suite avec l’algorithme du tri par sélection dans l’ordre croissant :

*1er tour* :

6, **1**, 9, 3 -> le plus petit élément du tableau est 1, on le place donc sur la première case (en l'échangeant avec le 6).

*2ème tour* :

1, 6, 9, **3** -> le deuxième plus petit élément est 3, on le place sur la deuxième case et on l’échange avec le 6.

*3ème tour* :

1, 3, 9, **6** -> le troisième plus petit élément est 6, on l’échange avec 9 pour le placer sur la troisième case.

*4ème tour* :

1, 3, 6, **9** -> le quatrième plus petit élément du tableau est 9, il est déjà en quatrième position on ne fait rien.

1, 3, 6, 9

Ce tri se décompose réellement en deux étapes distinctes :

![Exemple de tri par sélection](/static/img/algo/tri/tri_selection/exemple_tri.png)

A chaque tour, on cherche le minimum dans l'espace non trié du tableau (le minimum est représenté en bleu, et la partie non triée en blanc), ensuite on déplace cet élément à sa place définitive (représentée en vert). En faisant cela pour chaque élément du tableau, ce dernier se retrouve trié au bout de *N* tours maximum (*N* étant la taille du tableau).

## Pseudo-code

Le pseudo-code du tri par sélection est simple :

```nohighlight
triSelection :

   Pour chaque élément
      Pour chaque élément de la partie non triée
         Mettre à jour le minimum du tableau rencontré jusqu'ici
      Echanger l'élément actuel avec le minimum
```

## Complexité

Comme pour le tri à bulles, le tri par sélection a une complexité en *O(N²)* :

- La première boucle parcourt *N* tours.
- La deuxième boucle parcourt *N – i* tours (*i* variant de 0 à *N*).

Sa complexité est donc légèrement inférieure à *N²*, cependant cette différence est mineure et sa complexité est considérée comme étant en *O(N²)*.

## Implémentation

Le lien vers une implémentation en C de l’algorithme du tri par sélection :

main.c : 

## Améliorations et variantes

### Tri par sélection bidirectionnel

Tout comme pour le tri à bulles, on peut améliorer légèrement le tri par sélection pour qu'il effectue moins d'opérations. Dans notre boucle qui cherche le *ième* plus petit élément, on peut aussi en profiter pour chercher le *jème* plus grand. Grâce à cela, on divise par deux le nombre de tours que l'on réalise pour trier notre tableau, cependant, diviser par deux ne change pas la complexité finale car 2 est un facteur assez petit pour ne pas en prendre compte dans de très larges entrées. La complexité du tri reste donc quadratique.

```nohighlight
Pour chaque élément restant
   Pour chaque élément de la partie non triée
      Mettre à jour le minimum et le maximum du tableau rencontré jusqu'ici
      
   Echanger l'élément i (variant de 0 à N / 2 ) avec le minimum
   Echanger l'élément j (variant de N à N / 2 ) avec le maximum
```

### Le cas des doublons

Dans le cas où notre tableau contient de nombreux doublons, l'algorithme de tri par sélection va effectuer plusieurs recherches de plus petits éléments sur le même élément qui n'est rien d'autre qu'un doublon. Le *bingo sort* permet de palier ce problème, en proposant de placer tous les éléments ayant la même valeur en même temps, sans faire de nouvelles recherches à chaque tour. Encore une fois, notre algorithme sera plus rapide en général mais pas assez pour que la complexité change, elle restera donc en *O(N²)*.

```nohighlight
Pour chaque élément
   Pour chaque élément de la partie non triée
      Mettre à jour le minimum du tableau rencontré jusqu'ici
   
   Pour chaque élément de même valeur que le minimum
      Echanger avec l'élément actuel
      Augmenter l'indice de l'élément actuel
```

### Tri par tas

On peut voir le [tri par tas](/algo/tri/tri_tas.html) comme une amélioration directe du tri par sélection. En effet, si l'on utilise un [tas](/algo/structure/arbre/tas.html) pour permettre de trouver les plus petits éléments rapidement, on obtient une complexité en *O(N \* log N)* et un tri qu'on appelle tri par tas.

## Conclusion

Le tri par sélection est donc un algorithme assez simple, mais peu efficace à cause de sa complexité en *O(N²)*. Cependant des améliorations et des variantes permettent de le rendre plus rapide, et le tri par sélection sert de base au tri par tas, un autre algorithme de tri bien plus efficace avec une complexité en *O(N log N)*. Même avec une complexité quadratique, ce tri reste en pratique utilisé sur de petites entrées, mais aussi lorsqu'on a besoin d'un nombre d'échanges faible au sein du tableau (contrairement au [tri par insertion](/algo/tri/tri_insertion.html) qui peut être plus rapide, mais réalise plus d'échanges).
