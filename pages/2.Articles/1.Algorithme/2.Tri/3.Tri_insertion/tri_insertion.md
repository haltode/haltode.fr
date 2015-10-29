Tri par insertion
=================
algo/tri

Publié le : 01/05/2014  
*Modifié le : 27/10/2015*

## Introduction

Le tri par insertion (*insertion sort* en anglais) est un algorithme de tri par comparaison simple, et intuitif mais toujours avec une complexité en *O(N²)*. Vous l’avez sans doute déjà utilisé sans même vous en rendre compte : lorsque vous triez des cartes par exemple. C’est un algorithme de tri [stable](https://en.wikipedia.org/wiki/Sorting_algorithm#Stability), [en place](https://en.wikipedia.org/wiki/In-place_algorithm), et le plus rapide en pratique sur une entrée de petite taille.

## Principe de l’algorithme

Le principe du tri par insertion est de trier les éléments du tableau comme avec des cartes :

- On prend nos cartes mélangées dans notre main
- On crée deux ensembles de carte, l’un correspond à l’ensemble de carte triée, l’autre contient l’ensemble des cartes restantes (non triées)
- On prend au fur et à mesure, une carte dans l’ensemble non trié et on l’insère à sa bonne place dans l’ensemble de carte triée
- On répète cette opération tant qu’il y a une carte dans l’ensemble non trié

## Exemple

Prenons comme exemple la suite de nombre suivante : 9, 2, 7, 1 que l’on veut trier en ordre croissant avec l’algorithme du tri par insertion :

*1er tour* :

9 | **2**, 7, 1 -> à gauche la partie triée du tableau (le premier élément est considéré comme trié puisqu'il est seul dans cette partie), à droite la partie non triée. On prend le premier élément de la partie non triée, 2, et on l'insère à sa place dans la partie triée, c'est-à-dire à gauche de 9.

*2ème tour* :

2, 9 | **7**, 1 -> on prend 7, et on le place entre 2 et 9 dans la partie triée.

*3ème tour* :

2, 7, 9 | **1** -> on continue avec 1 que l’on place au début de la première partie.

1, 2, 7, 9

Pour insérer un élément dans la partie triée, on parcourt de droite à gauche tant que l'élément est plus grand que celui que l'on souhaite insérer.

Pour résumer l'idée de l'algorithme :

![Exemple de tri par insertion](/static/img/algo/tri/tri_insertion/exemple_tri.png)

La partie en verte du tableau est la partie triée, l'élément en bleu est le prochain élément non trié à placer et la partie blanche est la partie non triée.

## Pseudo-code

```nohighlight
triInsertion :
   
   Pour chaque élément du tableau non trié
      Tant que la valeur précédente est supérieure à l'élement à placer
         Décaler le tableau vers la droite
      Insérer l'élément à sa place définitive
```

Dans la boucle `Tant que`, on parcourt le sous-tableau déjà trié de droite à gauche tant que l'élément n'est pas à sa place et on décale le tableau à chaque fois pour pouvoir insérer l'élément à la fin.

## Complexité

L’algorithme du tri par insertion a une complexité de *O(N²)*, on le remarque facilement à cause des boucles imbriquées dans le pseudo-code notamment :

- La première boucle parcourt *N – 1* tours, ici on notera plutôt *N* tours car le *– 1* n’est pas très important.
- La deuxième boucle parcourt *i* tours (*i* variant de 0 à *N*).

Donc dans le pire des cas on parcourt *N \* N* tours, le tri par insertion a donc une complexité en temps de *O(N²)*.

Cependant, le tri par insertion est très efficace sur des entrées de petites tailles, et encore plus sur des entrées étant déjà presque triées (il est même plus performant que certains tris en *O(N \* log N)* comme le [tri fusion](http://napnac.ga/algo/tri/tri_fusion.html), ou même le [tri rapide](http://napnac.ga/algo/tri/tri_rapide.html)), dans ce cas il peut s’exécuter en temps linéaire.

## Implémentation

L’implémentation en C fonctionne exactement comme le pseudo-code :

main.c : 

## Améliorations et variantes

### Utiliser des listes chaînées

Le tri par insertion doit décaler de nombreuses fois le tableau pour insérer un élément, ce qui est une opération lourde et inutile puisqu'on peut utiliser des [listes chaînées](http://napnac.ga/algo/structure/liste_chainee.html) afin de contrer ce problème. Les listes chaînées permettent d'insérer notre élément de façon simple et plus rapide, cependant comme il faut toujours calculer où placer cet élément, la complexité reste quadratique.

### Tri Shell

Il est possible d'utiliser la propriété du tri par insertion d'être rapide sur des tableaux quasi triés pour le rendre plus efficace. En effet, le tri Shell (*Shell sort* en anglais, du nom de son inventeur Donald L. Shell) va échanger certaines valeurs du tableau à un écart bien précis afin de le rendre dans la plupart des cas presque trié. Une fois qu'on a ce tableau "ré-arrangé", on lui applique simplement notre tri par insertion classique, mais ce dernier sera plus rapide grâce à notre première étape.

Pour calculer cet écart, on utilise cette formule :

*Ecart(N) = 3 * Ecart(N - 1) + 1*  
avec *Ecart(0) = 0*

Voici un exemple d'utilisation du tri Shell pour mieux comprendre son application. On souhaite trier la suite de nombres : 5, 8, 2, 9, 1, 3 dans l'ordre croissant :

On calcule les écarts tant que le résultat est inférieur à la taille du tableau.

*Ecart(0) = 0*  
*Ecart(1) = 3 * Ecart(0) + 1 = 3 * 0 + 1 = 1*  
*Ecart(2) = 3 * Ecart(1) + 1 = 3 * 1 + 1 = 4*  
*Ecart(3) = 3 * Ecart(2) + 1 = 3 * 4 + 1 = 13*

On a donc deux écarts qu'on peut utiliser : 1 et 4 (13 étant supérieur au nombre d'éléments du tableau). Cependant appliquer un écart de 1 revient à faire un tri par insertion normal, on utilisera donc uniquement l'écart de 4 dans cet exemple.

On compare chaque élément du tableau écarté de quatre éléments :

**5**, 8, 2, 9, **1**, 3 -> on voit que 5 est supérieur à 1, on les échange.  
1, **8**, 2, 9, 5, **3** -> on voit que 8 est supérieur à 3, on les échange.  
1, 3, 2, 9, 5, 8 -> plus d’échange possible avec un écart de 4.

On répète cette opération tant qu'il nous reste des écarts, dans notre cas c'est la fin de la première étape du tri. Maintenant notre tableau est réorganisé et presque trié, on peut donc lui appliquer un tri par insertion.

Malheureusement le tri Shell reste avec une complexité quadratique dans le pire des cas, mais est une bonne amélioration en général.

### Dichotomie

Une autre amélioration est possible et très efficace. En effet, le tri par insertion est basé sur le fait que le tableau est coupé en deux parties, l’une triée (celle qui nous intéresse) et l’autre non triée. On peut améliorer la recherche de l'emplacement où insérer notre élément grâce à la [dichotomie](http://napnac.ga/algo/recherche/dichotomie.html) (c’est un algorithme de recherche efficace dans un ensemble d’objet déjà trié, ce qui est parfait pour notre cas).

Cette recherche consiste à utiliser la méthode du [diviser pour régner](https://en.wikipedia.org/wiki/Divide_and_conquer_algorithms), on cherche l’emplacement pour notre élément à l’aide d’intervalles. Notre intervalle de départ est : *début partie triée* ->  *fin partie triée* :

- On teste si l’élément situé au milieu de notre intervalle est supérieur à l’élément que l’on veut insérer.
- Si c’est le cas on recommence l’opération mais cette fois ci avec cet intervalle : *milieu ancien inter* -> *fin ancien inter*.
- Sinon on recommence mais avec l’intervalle suivant : *début ancien inter* -> *milieu ancien inter*.

Une fois que l’intervalle ne contient plus qu’un élément, on a trouvé l’emplacement de notre élément et on peut l’insérer. Grâce à cette amélioration, l’algorithme du tri par insertion a pour complexité *O(N \* log N)*.

*J'ai expliqué ici très rapidement le principe de la dichotomie, j'en parle plus longuement dans mon article à ce propos donc si vous n'avez pas tout suivi, je vous conseille d'aller le lire pour bien saisir ce concept très utile.*

## Conclusion

Le tri par insertion est donc intuitif et simple à implémenter, et même si sa complexité algorithmique est *O(N²)*, c’est un tri extrêmement efficace pour des petites entrées, ou des entrées quasi triées. De plus on peut facilement l’améliorer pour avoir une complexité en *O(N \* log N)* à l’aide de la dichotomie.
