Dichotomie
==========
algo/recherche

Publié le : 28/06/2014  
*Modifié le : 08/12/2015*

## Introduction

Jouons à un petit jeu appelé le plus ou moins. Je choisis un nombre entre 1 et 100 et vous devez le deviner en le moins de coup possible. A chaque fois que vous me dites un nombre, je vous dis si ce dernier est supérieur ou inférieur à celui que j'ai choisis (ou égal si vous avez trouvé).

Vu comme ça, on pourrait se dire qu'on a 1 chance sur 100 de tomber sur le bon nombre, et qu'il faut juste avoir de la chance, mais en réfléchissant bien on peut améliorer nos chances en s'aidant de la réponse que je donne à chaque fois (si c'est plus ou moins). Je choisis donc mon nombre, et au premier tour vous dites 50, si je vous dis plus vous savez que mon nombre sera forcément dans l'intervalle de 51 à 100, si je vous dis moins il sera dans l'intervalle 1 à 49, et si je vous dis égal vous avez trouvé le nombre. On peut continuer d'utiliser ce principe pour diviser par deux à chaque fois notre intervalle de recherche jusqu'à avoir un seul élément dans notre intervalle, qui est forcément celui que j'ai choisis au début du jeu. Cette méthode s'appelle la dichotomie, et s'applique dans bien d'autres domaines que dans ce jeu.

## Principe de la dichotomie

La dichotomie (*binary search* en anglais), est un algorithme de recherche efficace pour trouver un nombre dans un ensemble **trié** (ce point est très important puisque l'algorithme repose dessus). La dichotomie utilise le principe du [diviser pour régner](https://en.wikipedia.org/wiki/Divide_and_conquer_algorithms) afin de découper notre problème initiale en un sous problème plus petit.

On commence toujours la dichotomie dans un intervalle de recherche, puis à chaque étape on compare notre élément qu'on cherche à l'élément central de l'intervalle :

- Si l'élément qu'on cherche est supérieur, on peut continuer de chercher dans la moitié supérieure de l'intervalle.
- Si l'élément est inférieur, on continue de chercher dans la moitié inférieure.
- Sinon l'élément est égal, on l'a donc trouvé et on peut arrêter de chercher.

A chaque tour, on actualise notre intervalle de recherche et on recommence les opérations tant qu'on n'a pas trouvé notre élément.

## Exemple

Prenons un tableau trié : 1, 8, 15, 42, 99, 160, 380, 512, 678, 952, 1304, 7662. Nous cherchons dans ce tableau l'emplacement de l'élément 512 et nous allons utiliser le principe de la dichotomie pour le trouver :

TODO : image exemple dichotomie

## Pseudo-code

On peut faire le pseudo-code suivant d'un algorithme de la dichotomie :

```nohighlight
dichotomie :

   Tant qu'on n'a pas trouvé l'élément
      Si l'élément est supérieur au milieu
         Réduire l'intervalle à la partie supérieure
      Si l'élément est inférieur au milieu
         Réduire l'intervalle à la partie inférieure
      Sinon
         Arreter la recherche
```

## Complexité

Pour calculer la complexité en temps de la recherche dichotomique, on peut visualiser la décomposition des intervalles grâce à un [arbre](/algo/structure/arbre.html) :

TODO : image arbre décomposition tableau

## Implémentation

### Récursif

### Itératif

### STL

## Conclusion

Nous avons donc vu que notre dichotomie permet de chercher de manière générale, un élément dans un ensemble d'élément trié en *O(log N)*.

TODO : autres applications plus concrètes + ex d'ensemble : tableau, dictionnaire + débugger un code ? + nombre d'occurrences d'un nombre N dans un tableau trié + amélioration tri par insertion
