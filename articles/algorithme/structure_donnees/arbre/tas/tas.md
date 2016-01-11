Tas
===
algo/structure/arbre/

Publié le : 11/01/2016  
*Modifié le : 11/01/2016*

## Introduction

Dans l'introduction de mon article sur les [arbres binaires](/algo/structure/arbre/arbre_binaire.html), on a vu une méthode permettant de trouver le maximum dans un tableau dynamique avec une complexité en temps rapide ($O(\log _2 N)$). Cependant, qu'en est-il de la complexité en mémoire ? En effet, on crée de nombreuses fois de même nœuds afin d'avoir notre arbre binaire maximal final, mais peut-on faire mieux ? C'est là qu'on découvre le **tas**, une structure permettant de faire des recherches rapides, des comparaisons efficaces, et qui prend peu de place. On peut comprendre qu'avec ces caractéristiques, le tas est une structure de donnée énormément utilisée, et important à connaître.

## Principe du tas

Dans notre arbre binaire maximal, le père d'un nœud est le maximum des deux nœuds (autrement dit, c'est soit l'un soit l'autre), dans un tas, le père d'un nœud n'est pas un double de ses enfants, mais au contraire un autre nœud indépendant qui respecte une propriété spécifique au tas (**minimal** : alors le père a une valeur inférieure ou égale à celles de ses fils, et **maximal** : le père a une valeur supérieure ou égale à celles de ses fils).

![Exemple de tas maximal](//static.napnac.ga/img/algo/structure/arbre/tas/exemple_tas_max.png)

Ce tas max, peut représenter le tableau situé en dessous, et le fait qu'il soit maximal nous permet de dire avec certitude que sa racine est l'élément maximum du tableau (de même un tas min aura à la racine l'élément minimum du tableau). Cette propriété est très intéressante car on a réussi à avoir le même résultat qu'avec un arbre binaire maximal, mais sans utiliser de doublons, on peut alors stocker des tableaux bien plus grand sans avoir besoin de mémoire supplémentaire.

## Opérations sur un tas

Ajout d'un élément

Suppression d'un élément

Construction d'un tas

## Complexité

## Implémentation

## Variantes

## Conclusion
