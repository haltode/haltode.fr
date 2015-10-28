Tri par base
============
algo/tri

Publié le :   
*Modifié le :*

## Introduction

Le tri par base (*radix sort* en anglais) est un algorithme de tri ayant une complexité algorithmique linéaire soit *O(N)*, il était utilisé par les trieuses de [cartes perforées] et l’est encore aujourd’hui dans les ordinateurs modernes. Cet algorithme doit fonctionner à l’aide d’un autre algorithme de tri qui doit être obligatoirement stable, c’est-à-dire qu’il conserve l’ordre relatif d’apparition des éléments dans un tableau en cas d’égalité (par exemple si dans un tableau que je souhaite trier, j’ai deux 7, un algorithme de tri stable conservera l’ordre d’apparition des 7 dans le tableau trié).

## Principe de l’algorithme

L’algorithme est simple, on va trier successivement (à l’aide d’un algorithme de tri stable) les nombres donnés en entrée en commençant par le chiffre moins significatif de chaque nombre.

C’est-à-dire que l’on va trier tout d’abord les nombres en fonction du chiffre de l’unité, puis trier de nouveau en fonction cette fois-ci du chiffre des dizaines, et ainsi de suite jusqu’à atteindre le nombre maximum de chiffre contenu dans un nombre.

L’ordre de tri est défini dans l’algorithme de tri utilisé et non dans le tri par base en lui même.

## Exemple

Soit le tableau suivant que l’on souhaite trier dans l’ordre croissant en utilisant l’algorithme du tri par base : 56, 87, 2, 36, 74, 19.

Tout d’abord, on remarque qu’il y a au maximum deux chiffres par nombre et que par conséquent on n’utilisera notre algorithme de tri stable seulement deux fois.

Première étape, on trie les nombres en fonction du chiffre de l’unité :

56                 2
87                74
 2   +-------->   56
36                36
74                87
19                19

Vous voyez ici que l’on a deux 6 dans les unités, pour décider lequel placer en premier, on prendra toujours celui avec l’index le plus faible, c’est-à-dire le plus proche du début du tableau (dans notre cas on choisit 56 puis 36), d’où l’obligation d’utiliser un algorithme de tri stable.

Deuxième étape, on trie les nombres en fonction du chiffre des dizaines :

 2                 2
74                19
56   +-------->   36
36                56
87                74
19                87

Le 2 n’a pas de chiffre des dizaines, on fait donc comme s’il avait un zéro pour chiffre des dizaines.

On a atteint le nombre maximum de chiffre dans un nombre, notre tableau est donc trié :

2, 19, 36, 56, 74, 87.

Cependant, vous devez sans doute vous demander quel algorithme de tri utiliser ? Le tri par dénombrement semble le choix idéal. En effet, on sait que l’on va trier uniquement des chiffres dont les éléments à trier seront toujours compris en 0 et 9 (inclus), soit toujours des nombres entiers pas trop grands et proches les uns des autres. Cela permet donc de pallier tous les « défauts » du tri par dénombrement et de l’utiliser efficacement.

## Pseudo-code

Le pseudo-code du tri par base :

```nohighlight
Soit N la taille du tableau à trier

triParBase(Tableau, N) :
   maxChiffre -> le nombre maximum de chiffre contenu dans un nombre de Tableau

   Pour i = 0, allant jusqu'à maxChiffre à pas de 1
      Trier Tableau en fonction du chiffre i
```

Ce pseudo-code peut paraître un peu vide, en effet le tri par base est juste composé d’une boucle puisqu’il repose sur un autre algorithme de tri.

## Complexité

La complexité du tri par base peut varier puisqu’elle dépend de l’algorithme utilisé dans le tri. En effet, si l’on utilise le [tri par dénombrement](http://napnac.ga/algo/tri/tri_denombrement.html) :

- La boucle fait `maxChiffre` tours.
- A chaque tour de boucle, on utilise le tri par dénombrement qui comme je vous l’ai dit dans mon article à propos de ce tri, a une complexité de *O(N)* en général.

La complexité finale est donc de *O(maxChiffre \* N)*, or `maxChiffre` sera souvent assez petit pour ne pas le prendre en compte, on obtient donc une complexité moyenne pour le tri par base de *O(N)*.

## Implémentation

Voici le lien vers une implémentation en C du tri par base :

main.c :

## Conclusion

Le tri par base est donc un algorithme de tri rapide, sur des nombres ne comportant pas beaucoup de chiffres, de plus il se base sur un autre algorithme de tri stable pour fonctionner.
