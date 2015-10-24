Tri à bulles
============
algo/tri

Publié le : 29/04/2014  
*Modifié le :*

## Introduction

Le tri à bulles (*bubble sort* en anglais) est un algorithme de tri par comparaison très simple à comprendre et à implémenter, cependant c’est l’un des algorithmes de tri les plus inefficaces. En effet, il a une complexité quadratique : *O(N²)*. Cet algorithme est très peu utilisé à cause de sa complexité en temps trop lente, mais c’est un bon exemple pour commencer à travailler sur des algorithmes de tri. Il faut noter que le tri à bulles est un algorithme stable et sur place.

## Principe de l’algorithme

Le tri à bulles consiste à "remonter" les éléments du tableau à trier, jusqu’à leurs places définitives dans le tableau, comme des bulles qui remontent d’un liquide (d’où son nom de tri à bulles). L’algorithme compare chaque paire d’élément d’un tableau, et les échange si besoin et en fonction du tri (croissant ou décroissant).

## Exemple

Si l’on prend 8, 7, 1, 4, 6 comme suite de nombres, et que l’on utilise l’algorithme du tri à bulles pour trier cette suite dans l’ordre croissant, voici comment l’algorithme fonctionne :
1er tour :
8, 7, 1, 4, 6
8 > 7 donc on échange.
7, 8, 1, 4, 6
8 > 1 donc on échange.
7, 1, 8, 4, 6
8 > 4 donc on échange.
7, 1, 4, 8, 6
8 > 6 donc on échange.
7, 1, 4, 6, 8
2ème tour :
7, 1, 4, 6, 8
7 > 1 donc on échange.
1, 7, 4, 6, 8
7 > 4 donc on échange.
1, 4, 7, 6, 8
7 > 6 donc on échange.
1, 4, 6, 7, 8
7 < 8 donc on laisse.
1, 4, 6, 7, 8

## Pseudo-code

Voici le pseudo-code très simple de l’algorithme du tri à bulles :

```nohighlight
Soit N la taille du tableau à trier

triAbulles(Tableau, N) :

   Pour i = 0, allant jusqu'à N à pas de 1
      Pour j = 0, allant jusqu'à N - 1 à pas de 1
         Si l'élément j est supérieur à l'élément j + 1
            Échanger les éléments j et j + 1 du tableau
```

Voici une image résumant le principe du tri à bulles (la partie en bleue est la partie non triée, en blanc la partie triée, et en jaune le tableau entièrement triée) :

tri_bulle
source : http://csud.educanet2.ch/3oc-info/1_Programmation/6_Algorithmique/page5.html

## Complexité

Comme dit dans l’introduction, la complexité algorithmique de l’algorithme du tri à bulles est de *O(N²)*, et on peut le démontrer simplement par le fait qu’il y est deux boucles imbriqués dans le pseudo-code :

- La première boucle parcourt *N* tours.
- La deuxième boucle parcourt *N* tours aussi.

On se retrouve donc avec *N\*N* tours, et donc une complexité en *O(N²)*.

## Implémentation

L’implémentation est aussi simple que le pseudo-code :

main.c : http://git.io/vtzUH

Cette implémentation en C est très simple, et à pour seul but de vous proposer un code facile à comprendre et à récrire, qui vous permet de tester par vous même l’algorithme du tri à bulles. Vous pouvez l’améliorer à l’aide des idées proposées ci-dessous.

## Amélioration 1

On peut améliorer le tri à bulles en faisant en sorte qu’il s’arrête lorsque le tableau est trié, et qu’il ne parcourt pas d’autres tours inutiles. Pour cela il suffit de vérifier si l’on effectue un échange ou pas dans le tour de boucle actuelle, si ce n’est pas le cas le tableau est trié, on peut donc sortir de la boucle.

```nohighlight
Faire
   tableauPasTrié -> faux

   Pour i = 0, allant jusqu'à N - 1 à pas de 1
      Si l'élément i est supérieur à l'élément i + 1
         Échanger les éléments i et i + 1 du tableau
         tableauPasTrié -> vrai

Tant que tableauPasTrié est vrai
```

La complexité reste de *O(N²)* même si l’on a gagné quelques tours de boucle sur certains cas.

## Amélioration 2

Une variante du tri à bulles qui s’appelle le tri à bulles bidirectionnel, consiste contrairement au tri à bulles, à trier dans les deux directions (d’où son nom). Là où le tri à bulles tri seulement de gauche à droite (ou de droite à gauche, ça n’importe pas), le tri à bulles bidirectionnel tri de gauche à droite et de droite à gauche. Cela permet d’optimiser le tri de certains éléments comme les petits éléments situés en fin de tableau, le tri à bulles les ramène d’un seul emplacement à chaque tour de boucle, alors que le tri à bulles bidirectionnel les ramène en un seul tour. Par exemple avec la suite de nombres suivante : 2, 3, 4, 5, 1

*Tri à bulles*
(de gauche à droite)
2, 3, 4, 5, 1
(de gauche à droite)
2, 3, 4, 1, 5
(de gauche à droite)
2, 3, 1, 4, 5
(de gauche à droite)
2, 1, 3, 4, 5
1, 2, 3, 4, 5
*Tri à bulles bidirectionnel*
(de gauche à droite)
2, 3, 4, 5, 1
(de droite à gauche)
2, 3, 4, 1, 5
2, 3, 1, 4, 5
2, 1, 3, 4, 5
1, 2, 3, 4, 5
Dans cet exemple le tri à bulles bidirectionnel n’a besoin que de deux tours de boucle alors que le tri à bulles en a besoin de quatre. Vous voyez donc l’intérêt de l’algorithme du tri à bulles bidirectionnel.

Le pseudo-code du tri à bulles bidirectionnel :

```nohighlight
Faire
   tableauPasTrié -> faux

   Pour i = 0, allant jusqu'à N - 1 à pas de 1
      Si l'élément i est supérieur à l'élément i + 1
         Échanger les éléments i et i + 1 du tableau
         tableauPasTrié -> vrai

   Pour i = N, allant jusqu'à 1 à pas de 1
      Si l'élément i est inférieur à l'élément i - 1
         Échanger les éléments i et i - 1 du tableau
         tableauPasTrié -> vrai

Tant que tableauPasTrié est vrai
```

Cette variante peut être encore optimisé, en retenant l’endroit où le dernier échange s’est effectué pour ne pas aller plus loin (car c’est inutile), cependant cet algorithme a toujours pour complexité *O(N²)*.

## Amélioration 3

Une autre variante du tri à bulles appelée le tri CombSort, permet à l’algorithme du tri à bulles d’être beaucoup plus efficace et ainsi rivaliser avec des algorithmes bien plus performants comme le [tri rapide](http://napnac.ga/algo/tri/tri_rapide.html), le [tri fusion](http://napnac.ga/algo/tri/tri_fusion.html), ou encore le [tri Shell](http://napnac.ga/algo/tri/tri_shell.html).
Cet algorithme consiste donc à comparer des éléments du tableau à un certain intervalle au lieu de comparer les éléments voisins. En effet cette technique permet d’éliminer le problème du petit élément situé à la fin du tableau qui remonte lentement jusqu’à sa place initiale. Cet intervalle est initialisé par la longueur du tableau, puis est divisé par 1,3 (calculé pour optimiser les échanges entre les intervalles) à chaque tour, on fait cela tant que l’intervalle est supérieur à 1.

```nohighlight
Faire
   tableauPasTrié -> faux
   intervalle -> intervalle / 1.3 (valeur entière)

   Si intervalle est inférieur à 1
      intervalle -> 1

   Pour i = 0, allant jusqu'à N - intervalle à pas de 1
      Si l'élément i est supérieur à l'élément i + intervalle
         Échanger les éléments i et i + intervalle du tableau
         tableauPasTrié -> vrai

Tant que tableauPasTrié est vrai OU intervalle est supérieur à 1
```

Sa complexité en moyenne est donc de *O(N\*log(N))*, mais peut-être dans le pire des cas en *O(N²)* bien qu’en pratique c’est peu probable que l’algorithme de tri CombSort est une complexité de *O(N²)*.

## Conclusion

Le tri à bulles est donc un algorithme très basique, simple à implémenter et plutôt intuitif, cependant il n’est pas très efficace à cause sa complexité en *O(N²)* même si certaines améliorations peuvent le rendre plus rapide.
