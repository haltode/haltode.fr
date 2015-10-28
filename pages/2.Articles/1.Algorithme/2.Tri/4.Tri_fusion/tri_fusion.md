Tri fusion
==========
algo/tri

Publié le : 10/05/2014  
*Modifié le :*

## Introduction

Le tri fusion (*merge sort* en anglais) est un algorithme de tri par comparaison efficace qui a pour complexité *O(N \* log(N))*, il se base sur le principe du diviser pour régner. Cet algorithme est stable mais ne s’exécute pas en place.

## Principe de l’algorithme

L’algorithme du tri fusion commence par **diviser** le tableau initial en deux sous-tableaux et recommence l’opération jusqu’à ce que les sous-tableaux ne contiennent plus qu’un seul élément chacun. On se retrouve donc avec un tableau entièrement divisé en *N* sous-tableaux (*N* étant la taille initiale du tableau).

Ensuite le tri fusion, **fusionne** les sous-tableaux deux à deux dans l’ordre souhaité (croissant ou décroissant par exemple). On recommence l’opération jusqu’à reconstituer le tableau entier, mais trié.

La rapidité du tri fusion vient du fait que la fusion de deux sous-tableaux en un tableau trié peut se faire facilement en un temps linéaire.

## Exemple

Prenons comme exemple la suite de nombre 5, 1, 3, 8, 9, 6 que l’on veut trier avec le tri fusion dans l’ordre croissant :

1ère étape : diviser

5, 1, 3 | 8, 9, 6 -> le tableau est divisé en deux, on recommence jusqu’à avoir des sous-tableaux ne contenant plus qu’un seul élément.

5, | 1, 3 | 8 | 9, 6 -> on continue de diviser le tableau.

5 | 1 | 3 | 8 | 9 | 6 -> le tableau ne contient plus que des sous-tableaux avec un seul élément, on a donc fini de le diviser.

2ème étape : fusionner

1, 5 | 3, 8 | 6, 9  -> on fusionne deux à deux les sous-tableaux en les réorganisant dans l’ordre croissant.

1, 3, 5, 8 | 6, 9 -> on continue la fusion des sous-tableaux.

1, 3, 5, 6, 8, 9 -> le tableau ne contient plus de sous-tableaux, il est donc trié.

1, 3, 5, 6, 8, 9

## Pseudo-code

Voici le pseudo-code du tri fusion :

```nohighlight
triFusion (Tableau, début, fin) :
   Si le tableau actuel a plus d'un élément
      milieu -> (début + fin) / 2
      triFusion(Tableau, début, milieu)
      triFusion(Tableau, milieu + 1, fin)
      fusionner(Tableau, début, milieu, fin)
   Sinon
      Arrêter

fusionner (Tableau, début, milieu, fin) :
   Créer deux tableaux (A et B) contenant respectivement les éléments début à milieu, et milieu + 1 à fin de Tableau

   Pour i = début, allant jusqu'à fin à pas de 1
      Si A[indexA] <= B[indexB]
         Tableau[i] = A[indexA]
         Incrémenter indexA 
      Sinon
         Tableau[i] = B[indexB]
         Incrémenter indexB
```

Ce pseudo-code est relativement simple :

- La fonction `triFusion` vérifie dans un premier temps si le tableau donné en paramètre a plus d’un élément, si ce n’est pas le cas on arrête. Sinon on divise le tableau en deux en rappelant `triFusion` (premier sous-tableau -> *début à milieu*, deuxième sous-tableau -> *milieu + 1 à fin*). Enfin on fusionne les sous-tableaux à l’aide de la fonction `fusionner`.
- La fonction `fusionner` est simple, son principe est de créer les deux sous-tableaux (*début à milieu* et *milieu + 1 à fin*), puis, dans le tableau principal donné en paramètre, réorganiser les deux sous-tableaux pour n’en former plus qu’un seul mais trié. Ceci se fait tout simplement à l’aide d’une seule boucle.

Voici une image résumant le principe du tri fusion :

source : http://commons.wikimedia.org/wiki/File:Mergesort_algorithm_diagram.png

## Complexité

La complexité de l’algorithme du tri fusion est de *O(N \* log(N))*  :

- Premièrement, on a vu que la fonction `fusion` étant en temps linéaire *O(N)*, puisqu’elle ne contient qu’une simple boucle parcourant le tableau de taille *N*.
- Ensuite, il faut analyser la fonction `triFusion`. La fonction divise en deux à chaque appel le tableau, on peut représenter cette action très simplement à l’aide d’un [arbre](http://napnac.ga/algo/structure/arbre.html) comme l’image juste au dessous, et on peut donc calculer la complexité à l’aide d’un [logarithme]() de base 2. Notre fonction a donc pour complexité *O(log(N))*.

Si l’on assemble les deux complexités, on obtient bien une complexité finale de l’algorithme en *O(N \* log(N))*.

## Implémentation

Le lien vers l’implémentation du tri fusion :

main.c : 

La seule remarque sur ce code est qu’il faut d’abord vérifier dans la fonction `fusion` que l’un des deux tableaux A et B a au moins un autre élément non trié, si ce n’est pas le cas on compare les deux tableaux sinon on utilise le reste du tableau non trié.

## Amélioration 1

L’une des améliorations possibles est d’utiliser des [listes chaînées](http://napnac.ga/algo/structure/liste_chainee.html) au lieu de tableau. En effet à l’aide de ces dernières il n’est pas nécessaire de faire des copies en mémoire du tableau, cette version du tri fusion est donc plus optimisée au niveau de la mémoire mais reste la même au niveau de la complexité en temps.

## Conclusion

Le tri fusion est donc un algorithme de tri efficace, qui a pour complexité *O(N \* log(N))*. Cependant ce tri n’est pas en algorithme de tri en place, et nécessite de la mémoire supplémentaire.
