Tri par sélection
=================
algo/tri

Publié le : 30/04/2014  
*Modifié le :*

## Introduction

Le tri par sélection (*selection sort* en anglais) est un algorithme de tri par comparaison simple, mais assez inefficace sur une entrée trop importante, c’est un algorithme non stable mais qui tri en place. Il a pour complexité algorithmique *O(N²)* comme le [tri à bulles](http://napnac.ga/algo/tri/tri_bulles.html).

## Principe de l’algorithme

Le tri par sélection consiste à trouver le plus petit élément du tableau (ou le plus grand), puis de le placer à la première case du tableau (ou la dernière si vous avez choisis le plus grand élément). Ensuite on fait pareil pour le deuxième plus petit (ou plus grand) élément et on le place à la deuxième case du tableau (ou avant dernière encore une fois si vous avez choisis le plus grand élément). On continue ainsi jusqu’à avoir trié tous les éléments du tableau, c’est-à-dire lorsqu’on a placé le *Nième* élément le plus petit (ou plus grand) à sa place, avec *N* étant la taille du tableau.

## Exemple
 
Prenons désormais comme exemple la suite de nombres suivante : 6, 1, 9, 3. Trions cette suite avec l’algorithme du tri par sélection dans l’ordre croissant :
1er tour :
6, 1, 9, 3 -> le plus petit élément du tableau est 1, le deuxième élément, on l’échange avec le premier, qui est 6.
2ème tour :
1, 6, 9, 3 -> le deuxième plus petit élément du tableau est 3, le quatrième élément, on l’échange avec le deuxième qui est 6.
3ème tour :
1, 3, 9, 6 -> le troisième plus petit élément du tableau est 6, le quatrième élément, on l’échange avec le troisième qui est 9.
1, 3, 6, 9

## Pseudo-code

Le pseudo-code du tri par sélection est simple :

```nohighlight
Soit N la taille du tableau à trier

triParSelection(Tableau, N) :
   Pour i = 0, allant jusqu'à N à pas de 1
      Pour j = i + 1, allant jusqu'à N à pas de 1
         Si l'élément j est le minimum du tableau actuellement rencontré jusqu'ici
            min -> j
      Si l'élément i est différent de l'élément min
         Échanger l'élément i et l'élément min
```

Vous remarquez que nous faisons un test avant d’échanger le plus petit élément, en effet si le plus petit élément est l’élément *i*, alors ça ne sert à rien de l’échanger car il est déjà à la bonne place.
Voici une image résumant bien le fonctionnement de l’algorithme (en jaune c’est l’élément actuel, en rouge c’est le minimum de la partie bleue, en bleue c’est le reste du tableau non trié) :

source : http://csud.educanet2.ch/3oc-info/1_Programmation/6_Algorithmique/page3.html

## Complexité

Comme pour le tri à bulles, le tri par sélection a une complexité en *O(N²)* :

- La première boucle du pseudo-code parcourt *N* tours.
- La deuxième boucle du pseudo-code parcourt *N – i* tours (*i* variant de 0 à *N*).

Sa complexité devrait donc être légèrement inférieure à *N²*, cependant cette différence est mineure et sa complexité est donc considéré comme étant en *O(N²)*.

## Implémentation

Le lien vers une implémentation en C de l’algorithme du tri par sélection :

main.c : 

Implémentation très simple dans le but de vous offrir un code facile à comprendre, à utiliser et à améliorer.

## Conclusion

L’algorithme du tri par sélection est donc un algorithme simple, mais peu efficace à cause de sa complexité en *O(N²)*. C’est un algorithme non stable mais qui trie sur place.
