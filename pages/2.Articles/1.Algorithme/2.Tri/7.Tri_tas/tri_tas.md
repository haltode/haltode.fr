Tri par tas
===========
algo/tri

Publié le : 14/05/2014
*Modifié le :*

## Introduction

Le tri par tas (*heap sort* en anglais) est un algorithme de tri par comparaison inventé en 1964, plutôt efficace et qui a une complexité en *O(N \* log(N))*. C’est un algorithme de tri non stable mais en place.

## Principe de l’algorithme

L’algorithme du tri par tas repose sur un principe fondamental : le tas max. L’algorithme créé un tas max (si l’on trie dans l’ordre croissant, sinon on utilise un tas min pour l’ordre décroissant) du tableau que l’on souhaite trier, puis il parcourt le tas ainsi crée en reconstituant les valeurs triées dans le tableau.

Son fonctionnement est donc simple à comprendre.

## Exemple

On prend la suite de nombre suivant que l’on va trier dans l’ordre croissant avec le tri par tas : 1, 9, 3, 7, 6, 1, 4.

1ère étape : créer le tas max

       9
    /    \
   7      4
 /  \    / \
1   6   1   3

Ceci est le tas max qui correspond au tableau 1, 9, 3, 7, 6, 1, 4, je ne détaillerais pas sa création vu que j’en parle dans mon article sur les [arbres](http://napnac.ga/algo/structure/arbre.html).

2ème étape : restaurer les éléments dans le tableau

Ce qu’on va faire maintenant c’est échanger la racine (l’élément maximum du tas), avec le dernier élément que l’on va entasser dans le tas, et recommencer cette opération jusqu’à avoir un tas d’un seul élément.

1er tour :

       7
    /    \
   6      4
 /  \    / 
1   3   1   9

On échange 9 (la racine) et 3 que l’on entasse dans le tas (pour conserver la propriété clé d’un tas max), 9 ne fait plus partie du tas.

2ème tour :

       6
    /    \
   3      4
 /  \     
1   1   7   9

On échange 7 (la racine) et 1 que l’on entasse dans le tas, 7 ne fais plus partie du tas.

3ème tour :

       4
    /    \
   3      1
 /       
1   6   7   9

On échange 6 (la racine) et 1 que l’on entasse dans le tas, 6 ne fais plus partie du tas.

4ème tour :

       3
    /    \
   1      1     
4   6   7   9

On échange 4 (la racine) et 1 que l’on entasse dans le tas, 4 ne fais plus partie du tas.

5ème tour :

       1
    /    
   1      3
4   6   7   9

On échange 3 (la racine) et 1 que l’on entasse dans le tas, 3 ne fais plus partie du tas.

6ème tour :

       1    
   1      3
4   6   7   9

On se retrouve bien à la fin avec : 1, 1, 3, 4, 6, 7, 9.

## Pseudo-code

Voici le pseudo-code du tri par tas :

```nohighlight
triParTas(Tableau) :
   construireTasMax(Tableau)

   Pour i = tailleTableau, allant jusqu'à 1 à pas de 1
      Échanger l'élément de Tableau[1] et l'élément de Tableau[i]
      Décrémenter la taille du tableau
      entasser(Tableau, 1)

construireTasMax(Tableau) :
   Pour i = tailleTableau / 2, allant jusqu'à 0 à pas de 1
      entasser(Tableau, i)

entasser(Tableau, index) :
   enfantGauche -> gauche(index)
   enfantDroite -> droite(index)

   Si Tableau[enfantGauche] > Tableau[enfantDroite]
      max -> enfantGauche
   Sinon
      max -> index
   Si Tableau[enfantDroite] > Tableau[max]
      max -> enfantDroite

   Si max est différent de index
      Échanger l'élément Tableau[index] et l'élément Tableau[max]
      entasser(Tableau, max)
gauche(index) :
   Retourner 2 * index
droite(index) : 
   Retourner 2 * index + 1
```

Les fonctions `construireTasMax`, `entasser`, `gauche` et `droite` sont expliquées dans mon article sur les arbres, je ne décrirais donc pas ces dernières. La fonction `triParTas`, commence donc pas créer le tas max correspondant au tableau donné en paramètre. Ensuite on échange la valeur maximale du tas (situé à l’index 1 de `Tableau`) avec l’élément *i* de `Tableau` (sa place définitive), on l’enlève donc du tas et pour être sûr de conserver un tas max on appelle la fonction entasser pour conserver les propriétés fondamentales d’un tas max.

Voici une image résumant très bien le tri par tas :

source : http://commons.wikimedia.org/wiki/File:Heap_sort_example.gif

## Complexité

La complexité de l’algorithme du tri par tas est en *O(N \* log(N))* :

- Tout d’abord, il faut prendre en compte la boucle principale de la fonction `triParTas` qui parcourt *N* tours (*N* étant la taille du tableau) et s’exécute donc en un temps linéaire de *O(N)*.
- Ensuite il faut calculer la complexité de la fonction `entasser`, qui est de *O(log(N))* puisqu’elle utilise un tas.

On se retrouve donc bien avec une complexité en *O(N \* log(N))*.

Si vous n’avez pas lu mon article sur le [tri rapide](http://napnac.ga/algo/tri/tri_rapide.html), je vous conseille au moins de lire la partie complexité dans laquelle j’explique pourquoi le tri rapide peut être jusqu’à deux fois plus efficace que le tri par tas.

## Implémentation

Voici le lien vers l’implémentation en C de l’algorithme du tri pas tas :

main.c : 

Cette implémentation est simple, je vous conseille de l’améliorer avec les suggestions que je vous propose juste en dessous.

Une seule remarque sur le code, faites attention aux indices des tableaux car en C (et dans beaucoup de langages de programmation) les tableaux ont pour premier index 0 et non 1.

## Amélioration 1

Comme pour le [tri rapide](http://napnac.ga/algo/tri/tri_rapide.html), le tri par tas peut aussi être mélangé avec un autre algorithme de tri lorsque le tableau possède peu d’élément. Pour en savoir plus, je vous invite à lire la partie **Amélioration 2** de mon article sur le tri rapide.

## Conclusion

Le tri par tas est donc un algorithme de tri efficace en *O(N \* log(N))* non stable mais en place, et plutôt facile à implémenter.
