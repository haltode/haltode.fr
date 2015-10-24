Tri par insertion
=================
algo/tri

Publié le : 01/05/2014  
*Modifié le :*

## Introduction

Le tri par insertion (*insertion sort* en anglais) est un algorithme de tri par comparaison simple, et intuitif mais toujours avec une complexité en *O(N²)*. Vous l’avez déjà sans doute utilisé sans même vous en rendre compte : lorsque vous trier des cartes par exemple. C’est un algorithme de tri stable et en place, et sans doute l’algorithme le plus rapide en pratique sur une entrée de petite taille.

## Principe de l’algorithme

Le principe de l’algorithme du tri par insertion est de trier les éléments du tableau comme avec des cartes :

- On prend nos cartes dans notre main, mélangées.
- On créé deux ensembles de carte, l’un correspond à l’ensemble de carte déjà triée, l’autre contient l’ensemble des cartes restantes (non triées).
- On prend au fur et à mesure, une carte dans l’ensemble de carte non triée et on l’insère à sa bonne place dans l’ensemble de carte triée.
- On répète cette opération tant qu’il y a une carte dans l’ensemble non trié.

On voit donc que l’on va séparer le tableau à trier en deux parties, l’une triée et l’autre non.

## Exemple

Prenons comme exemple la suite de nombre suivante : 9, 2, 7, 1 que l’on veut trier en ordre croissant avec l’algorithme du tri par insertion :

1er tour :

9 | 2, 7, 1 -> j’ai séparé le tableau en deux pour bien comprendre, la première partie est celle triée (on commence donc par le premier élément du tableau, que l’on considère comme trié), la deuxième partie est la partie non triée. On prend le premier élément de la deuxième partie, ici 2, et on l’insère à sa place dans la première partie, avant 9.

2ème tour :

2, 9 | 7, 1 -> on recommence mais on prend cette fois 7, et on le place entre 2 et 9 de la première partie du tableau.

3ème tour :

2, 7, 9 | 1 -> on continue avec 1 que l’on place au début de la première partie.

1, 2, 7, 9

## Pseudo-code

Le pseudo-code du tri par insertion reste simple :

```nohighlight
Soit N la taille du tableau à trier

triParInsertion(Tableau, N) :
   Pour i = 1, allant jusqu'à N à pas de 1
      j -> i
      temporaire -> valeur de l'élément i du tableau
      Tant que j est supérieur à 0 ET l'élément j - 1 est supérieur à la valeur de temporaire
         Décaler l'élément j - 1 du tableau d'une place vers la droite
         j -> j - 1
      Insérer la valeur de temporaire à l'emplacement j qui est libre après avoir décalé les autres éléments
```

Plusieurs choses à noter sur ce pseudo-code :

- Tout d’abord la première boucle commence bien à l’élément 1 et non 0 du tableau car comme expliqué dans la partie **Exemple**, on commence la partie triée du tableau à partir du deuxième élément
- Ensuite on sauvegarde la valeur située à l’élément *i* pour pouvoir ensuite « décaler » les éléments du tableau en utilisant la case i comme case vide puisqu’on a sauvegardé sa valeur. Il suffit donc de décaler chaque élément vers la droite (jusqu’à la case *i*), et d’insérer notre valeur sauvegardée.

Voici une image résumant le principe du tri par insertion (en bleu la partie du tableau triée, en rouge le prochain élément à trier dans la partie bleue, en jaune l’élément qui vient d’être placé dans la partie bleue) :

source : http://csud.educanet2.ch/3oc-info/1_Programmation/6_Algorithmique/page4.html

## Complexité

L’algorithme du tri par insertion a une complexité de *O(N²)*, on le remarque facilement à cause des boucles imbriquées dans le pseudo-code notamment :

- La première boucle parcourt *N – 1* tours, ici on notera plutôt *N* tours car le – 1 n’est pas très important.
- La deuxième boucle parcourt *i* tours (*i* variant de 0 à *N*).

Donc dans le pire des cas on parcourt *N\*N* tours, le tri par insertion a donc une complexité en temps de *O(N²)*.

Cependant, le tri par insertion est très efficace sur des entrées de petites tailles, et encore plus sur des entrées étant déjà presque triées (il est même plus performant que certains tris en *O(N \* log(N))* comme le [tri par fusion](http://napnac.ga/algo/tri/tri_fusion.html), ou même le [tri rapide](http://napnac.ga/algo/tri/tri_rapide.html)), dans ce cas il s’exécute en temps linéaire donc *O(N)*.

C’est pour cela que le tri par insertion est très utilisé sur de petites entrées.

## Implémentation

L’implémentation en C fonctionne exactement comme le pseudo-code :

main.c : 

Cette implémentation est juste là pour vous proposer un code concret, vous pouvez donc l’améliorer !

## Amélioration 1

Une des premières améliorations possibles, vous y avez peut-être déjà pensé, et d’utiliser des [listes chaînées](http://napnac.ga/algo/structure/liste_chainee.html) à la place d’un tableau. En effet, on aurait plus besoin de déplacer les éléments du tableau mais juste à insérer l’élément dans la liste, cependant il faut toujours calculer l’indice ou insérer l’élément ! Et pour cela il faut toujours exécuter une boucle, mais plus besoin de déplacer les éléments, c’est donc une amélioration.

L’algorithme du tri par insertion implémenté avec une liste chaînée est donc toujours en *O(N²)*.

## Amélioration 2

Une autre amélioration est possible et bien plus efficace que la précédente. En effet, le tri par insertion est basé sur le fait que le tableau est coupé en deux parties, l’une triée (celle qui nous intéresse) et l’autre non triée. On peut améliorer le temps d’exécution pour trouver l’indice dans lequel placer l’élément dans la première partie du tableau, en utilisant ce que on appelle la [dichotomie](http://napnac.ga/algo/recherche/dichotomie.html) (c’est un algorithme de recherche efficace dans un ensemble d’objet déjà trié).

Cette recherche consiste à utiliser la méthode du "diviser pour régner", on cherche donc l’emplacement pour notre élément à l’aide d’intervalles. Notre premier intervalle est : début de la première partie du tableau -> fin de la première partie du tableau :

- On teste si l’élément situé au milieu de notre intervalle est supérieur à l’élément que l’on veut insérer.
- Si c’est le cas on recommence l’opération mais cette fois ci avec cet intervalle : milieu de l’ancien intervalle -> fin de la première partie du tableau.
- Sinon on recommence mais avec l’intervalle suivant : début de la première partie du tableau -> milieu de l’ancien intervalle.

Une fois que l’intervalle ne contient plus qu’un élément, on a donc trouvé l’emplacement de notre élément et on peut l’insérer. Cette technique nous permet donc de diviser par deux le nombre de recherches. Grâce à cette amélioration, l’algorithme du tri par insertion a pour complexité *O(N \* log(N))*.

## Conclusion

Le tri par insertion est donc intuitif et simple à implémenter et même si sa complexité algorithmique est en *O(N²)*, c’est un tri extrêmement efficace pour des petites entrées, ou des entrées quasi triées. De plus on peut facilement l’améliorer pour avoir une complexité en *O(N \* log(N))* à l’aide de la dichotomie.
