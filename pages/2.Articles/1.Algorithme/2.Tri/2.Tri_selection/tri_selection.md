Tri par sélection
=================
algo/tri

Publié le : 30/04/2014  
*Modifié le :*

## Introduction

Le tri par sélection (*selection sort* en anglais) est un algorithme de tri par comparaison simple, mais assez inefficace sur une entrée trop importante, c’est un algorithme non [stable](https://en.wikipedia.org/wiki/Sorting_algorithm#Stability) mais qui tri [en place](https://en.wikipedia.org/wiki/In-place_algorithm). Il a pour complexité algorithmique *O(N²)* comme le [tri à bulles](http://napnac.ga/algo/tri/tri_bulles.html).

## Principe de l’algorithme

Le tri par sélection consiste à trouver le plus petit élément du tableau (ou le plus grand), puis de le placer à la première case du tableau (ou la dernière si vous avez choisis le plus grand élément). Ensuite on fait pareil pour le deuxième plus petit (ou plus grand) élément et on le place à la deuxième case du tableau (ou avant-dernière encore une fois si vous avez choisis le plus grand élément). On continue ainsi jusqu’à avoir trié tous les éléments du tableau, c’est-à-dire lorsqu’on a placé le *Nième* élément le plus petit (ou plus grand) à sa place, avec *N* étant la taille du tableau.

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

A chaque tour, on cherche le minimum dans l'espace non trié du tableau (le minimum est représenté en bleu, et la partie non triée du tableau en blanc), ensuite on déplace cet élément à sa place définitive (représentée en vert). Si on fait cela à chaque tour, le tableau final est bien trié.

## Pseudo-code

Le pseudo-code du tri par sélection est simple :

```nohighlight
Soit N la taille du tableau à trier

triParSelection(Tableau, N) :
   Pour i = 0, allant jusqu'à N à pas de 1
      Pour j = i + 1, allant jusqu'à N à pas de 1
         Si l'élément j est le minimum du tableau rencontré jusqu'ici
            min -> j
      Si l'élément i est différent de l'élément min
         Échanger l'élément i et l'élément min
```

## Complexité

Comme pour le tri à bulles, le tri par sélection a une complexité en *O(N²)* :

- La première boucle parcourt *N* tours.
- La deuxième boucle parcourt *N – i* tours (*i* variant de 0 à *N*).

Sa complexité devrait donc être légèrement inférieure à *N²*, cependant cette différence est mineure et sa complexité est donc considérée comme étant en *O(N²)*.

## Implémentation

Le lien vers une implémentation en C de l’algorithme du tri par sélection :

main.c : 

## Améliorations et variantes

### Tri par sélection bidirectionnel

Tout comme le tri à bulles, on peut améliorer légèrement le tri par sélection pour qu'il effectue moins d'opérations. Par exemple dans notre boucle qui cherche le *kème* élément plus petit, on peut aussi en profiter pour chercher le *kème* élément plus grand. Grâce à cela on divise par deux le nombre de tours que l'on réalise pour chercher les éléments à placer. Cependant diviser par deux ne change pas la complexité finale car 2 est un facteur assez petit pour ne pas en prendre compte dans de très larges entrées. La complexité reste donc quadratique.

```nohighlight

```

### Le cas des doublons

Dans le cas où notre tableau contient de nombreux doublons, l'algorithme de tri par sélection va faire plusieurs fois la recherche du plus petit élément dans le tableau alors que c'est encore un doublon du dernier plus petit. Le *bingo sort* permet de palier ce problème, en proposant de placer tous les éléments ayant la même valeur en même temps, sans faire de nouvelles recherches de plus petit élément. Encore une fois, notre algorithme sera plus rapide en général mais pas assez pour que la complexité change, elle restera donc en *O(N²)*.

```nohighlight

```

### Tri par tas

On peut voir le [tri par tas](http://napnac.ga/algo/tri/tri_tas.html) comme une amélioration directe au tri par sélection. En effet, si l'on utilise un tas pour permettre de trouver les éléments plus petits rapidement, on obtient une complexité en *O(N \* log(N))* et un tri qu'on appelle tri par tas.

## Conclusion

L’algorithme du tri par sélection est donc un algorithme simple et assez intuitif, mais peu efficace à cause de sa complexité en *O(N²)*. En revanche il sert de base de réflexion pour un algorithme de tri bien plus efficace : le tri par tas.
