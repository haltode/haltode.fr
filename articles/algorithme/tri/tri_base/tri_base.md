Tri par base
============
algo/tri

Publié le :   
*Modifié le :*

## Introduction

Le tri par base (*radix sort* en anglais) est un algorithme de tri ayant une complexité algorithmique linéaire, il était utilisé par les trieuses de [cartes perforées](https://en.wikipedia.org/wiki/Punched_card) et l’est encore aujourd’hui dans les ordinateurs modernes. Cet algorithme doit fonctionner à l’aide d’un autre algorithme de tri qui doit être obligatoirement [stable](https://en.wikipedia.org/wiki/Punched_card).

## Principe de l’algorithme

L’algorithme est simple, on va trier successivement (à l’aide d’un algorithme de tri stable) les nombres donnés en entrée en commençant par le chiffre moins significatif de chaque nombre.

C’est-à-dire que l’on va trier tout d’abord les nombres en fonction du chiffre de l’unité, puis trier de nouveau en fonction du chiffre des dizaines, et ainsi de suite jusqu’à atteindre le nombre maximum de chiffre contenu dans un nombre.

L’ordre de tri est défini dans l’algorithme de tri utilisé et non dans le tri par base en lui même.

## Exemple

Soit le tableau suivant que l’on souhaite trier dans l’ordre croissant en utilisant l’algorithme du tri par base : 56, 87, 2, 36, 74, 19.

Tout d’abord, on remarque qu’il y a au maximum deux chiffres par nombre et que par conséquent on n’utilisera notre algorithme de tri stable seulement deux fois. On commence donc par trier cette suite de nombre en fonction du chiffre des unités, puis on recommence l'opération sur le chiffre des dizaines :

| Début   | 1er tour   | 2ème tour   |
| ------: | ---------: | ----------: |
| 56      | **2**      | 2           |
| 87      | 7**4**     | **1**9      |
| 2       | 5**6**     | **3**6      |
| 36      | 3**6**     | **5**6      |
| 74      | 8**7**     | **7**4      |
| 19      | 1**9**     | **8**7      |

On atteint le nombre maximum de chiffre, notre tableau est donc trié :

2, 19, 36, 56, 74, 87.

## Pseudo-code

Le pseudo-code du tri par base :

```nohighlight
triParBase :

   Pour chaque chiffre possible
      Trier Tableau en fonction du chiffre i
```

Cela peut paraitre assez étrange d'utiliser un autre algorithme de tri dans un algorithme de tri, mais si l'on considère cet autre algorithme comme le [tri par dénombrement](/pages/algo/tri/tri_denombrement.html) on peut ainsi pallier un des problèmes de ce tri au niveau de la mémoire utilisée. Il va cependant nous falloir modifier légèrement notre implémentation du tri par dénombrement car la notion de stabilité pour ce tri n'a pas vraiment de sens puisqu'on utilise des effectifs sans lien réel avec notre tableau.

## Complexité

## Implémentation

Voici le lien vers une implémentation en C du tri par base :

main.c :

## Conclusion

Le tri par base est donc un algorithme de tri rapide, sur des nombres ne comportant pas beaucoup de chiffres, de plus il se base sur un autre algorithme de tri stable pour fonctionner.
