Tas
===
algo/structure/arbre/

Publié le : 11/01/2016  
*Modifié le : 14/01/2016*

## Introduction

TODO : refaire intro : problème de base 2 opérations -extraire min/max -insérer valeur

Dans l'introduction de mon article sur les [arbres binaires](/algo/structure/arbre/arbre_binaire.html), on a vu une méthode permettant de trouver le maximum dans un tableau dynamique avec une complexité en temps efficace de $O(\log _2 N)$. Cependant, qu'en est-il de la complexité en mémoire ? En effet, on crée de nombreuses fois des doublons afin d'avoir notre arbre binaire maximal final, mais peut-on faire autrement ? C'est là qu'on découvre le **tas**, une structure permettant de faire des recherches rapides, des comparaisons efficaces, et qui prend peu de place. On peut comprendre qu'avec tous ces avantages, le tas est une structure de données énormément utilisée, et importante à connaître.

## Principe du tas

Le tas (ou *heap* en anglais), sera la plupart du temps implémenté comme un **tas binaire**, c'est-à-dire qu'il est construit sur la forme d'un arbre binaire. C'est sur cette structure que l'on va donc se concentrer dans cet article, mais sachez qu'il est possible de créer des tas basés sur des arbres autres que binaires.

Dans notre arbre binaire maximal, le père d'un nœud est le maximum des deux nœuds (autrement dit, c'est soit l'un soit l'autre), dans un tas binaire, le père d'un nœud n'est pas un double de ses enfants, mais au contraire un autre nœud indépendant qui respecte une propriété spécifique au tas (**tas minimal** : alors le père a une valeur inférieure ou égale à celles de ses fils, et **tas maximal** : le père a une valeur supérieure ou égale à celles de ses fils).

![Exemple de tas maximal](//static.napnac.ga/img/algo/structure/arbre/tas/exemple_tas_max.png)

Ce tas max peut représenter le tableau situé en dessous, et le fait qu'il soit maximal nous permet de dire avec certitude que sa racine est l'élément maximum du tableau (de même un tas min aura à la racine l'élément minimum du tableau).

## Opérations sur un tas

Un tas ne peut pas avoir de "trous" dedans, seul le dernier étage de l'arbre peut ne pas être rempli en entier. Lorsqu'on veut insérer un nouvel élément, on a donc pas d'autres choix que de le placer à la première place libre que l'on trouve dans le tas. Cependant, ce nouvel élément ne respecte pas les propriétés du tas, et il va falloir échanger des éléments afin d'avoir une structure cohérente. Pour cela, on applique le même principe que lors d'un changement d'une valeur dans un arbre binaire maximal, c'est-à-dire que l'on va modifier tous les nœuds parents tant que les propriétés du tas ne sont pas respectées.

![Exemple d'insertion d'un nouvel élément dans un tas maximal](//static.napnac.ga/img/algo/structure/arbre/tas/exemple_insertion_tas_max.png)

La deuxième opération principale d'un tas est l'extraction de son minimum/maximum (en fonction des propriétés du tas). On a vu que cette valeur se trouve forcément à la racine, mais comment reboucher le trou qu'on vient de faire ? Une solution consiste à prendre le dernier élément du tas (sur le dernier étage), et de le déplacer à la racine. Vu que c'est une feuille, on peut très bien le bouger de place sans inconvénient, cependant on ne respecte plus les propriétés du tas. On va donc **entasser** cet élément pour qu'il se retrouve à sa bonne place :

![Exemple d'extraction du maximum dans un tas](//static.napnac.ga/img/algo/structure/arbre/tas/exemple_extraction_tas_max.png)

Suppression d'un élément + Changer un élément (évoquer)

Construction d'un tas

## Pseudo-code

## Complexité

Notre tas binaire est basé sur un arbre binaire, il a donc une hauteur maximale de $O(\log _2 N)$ avec $N$ le nombre d'éléments du tas. Pour l'insertion d'un élément, on fait dans le pire des cas remonter le nœud jusqu'à la racine et donc on effectue $\log _2 N$ opérations. Pareil pour l'extraction du min/max, on fait dans le pire des cas $\log _2 N$ échanges, résultant dans les deux cas en une complexité en $O(\log _2 N)$.

TODO : rajouter complexité des autres opérations

## Implémentation

TODO : implémentation en C (à la main) + C++ priority_queue STL

## Conclusion

TODO : variantes + applications
