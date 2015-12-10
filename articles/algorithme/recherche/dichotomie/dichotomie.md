Dichotomie
==========
algo/recherche

Publié le : 28/06/2014  
*Modifié le : 10/12/2015*

## Introduction

Jouons à un petit jeu appelé *le plus ou moins*. Je choisis un nombre entre 1 et 100 et vous devez le deviner en moins de coup possible. A chaque fois que vous me dites un nombre, je vous dis si ce dernier est supérieur ou inférieur à celui que j'ai choisis (ou égal si vous avez trouvé).

Vu comme ça, on pourrait se dire qu'on a 1 chance sur 100 de tomber sur le bon nombre, et qu'il faut juste avoir de la chance, mais en réfléchissant bien on peut améliorer nos chances en s'aidant de la réponse que je donne à chaque fois (si c'est plus ou moins). Je choisis donc mon nombre, et au premier tour vous dites 50, si je vous dis « plus » vous savez que mon nombre sera forcément dans l'intervalle de 51 à 100, si je vous dis « moins » il sera dans l'intervalle 1 à 49, et si je vous dis égal vous avez trouvé le nombre. On peut continuer d'utiliser ce principe pour diviser par deux à chaque fois notre intervalle de recherche jusqu'à avoir un seul élément dans notre intervalle, qui est forcément celui que j'ai choisis au début du jeu. Cette méthode s'appelle la dichotomie, et s'applique dans bien d'autres domaines que dans ce jeu.

## Principe de la dichotomie

La dichotomie (*binary search* en anglais), est un algorithme de recherche efficace pour trouver un nombre dans un ensemble **trié** (ce point est très important puisque l'algorithme repose dessus). La dichotomie utilise le principe du [diviser pour régner](https://en.wikipedia.org/wiki/Divide_and_conquer_algorithms) afin de découper notre problème initiale en un sous problème plus petit.

On commence toujours la dichotomie dans un intervalle de recherche, puis à chaque étape on compare notre élément qu'on cherche à l'élément central de l'intervalle :

- Si l'élément qu'on cherche est supérieur, on peut continuer de chercher dans la moitié supérieure de l'intervalle.
- Si l'élément est inférieur, on continue de chercher dans la moitié inférieure.
- Sinon l'élément est égal, on l'a donc trouvé et on peut arrêter de chercher.

A chaque tour, on actualise notre intervalle de recherche et on recommence les opérations tant qu'on n'a pas trouvé notre élément.

## Exemple

Prenons un tableau trié : 1, 8, 15, 42, 99, 160, 380, 512, 678, 952, 1304. Nous cherchons dans ce tableau l'emplacement de l'élément 512 et nous allons utiliser le principe de la dichotomie pour le trouver :

1, 8, 15, 42, 99, **160**, 380, 512, 678, 952, 1304 : on compare l'élément du milieu de l'intervalle (c'est le premier tour, on commence donc par un intervalle contenant tout le tableau) avec l'élément qu'on cherche. 512 > 160, donc on peut oublier les éléments avant 160 (compris), pour se concentrer sur la partie supérieure de l'intervalle.

380, 512, **678**, 952, 1304 : notre intervalle est donc divisé en deux, et on continue nos opérations. 512 < 678 donc on continue notre recherche dans la partie inférieure de l'intervalle.

**380**, 512 : 512 > 380, on continue dans la partie supérieure de l'intervalle.

512 : notre intervalle ne contient plus qu'un seul élément, c'est donc forcément celui qu'on recherche.

Pour résumé le principe :

![Exemple de dichotomie](//static.napnac.ga/img/algo/recherche/dichotomie/exemple_dichotomie.png)

L'élément en bleu est celui du milieu que l'on compare, et ensuite on choisit la bonne portion du tableau (en vert) en fonction de cette comparaison pour couper notre intervalle en deux à chaque tour.

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

Et il est tout à fait possible d'écrire cet algorithme sous forme [récursive](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29) :

```nohighlight
dichotomie (début, fin) :

   Si la recherche est supérieure au milieu
      Retourner dichotomie(milieu + 1, fin)
   Si la recherche est inférieure au milieu
      Retourner dichotomie(debut, milieu - 1)
   Sinon
      Retourner l'élément au milieu
```

## Complexité

Pour calculer la complexité en temps de la recherche dichotomique, on peut visualiser la décomposition des intervalles grâce à un [arbre](/algo/structure/arbre.html) :

![Calcul de la complexité](//static.napnac.ga/img/algo/recherche/dichotomie/calcul_complexite.png)

Chaque opération possible est représentée dans notre arbre, c'est-à-dire qu'à chaque tour on coupe notre tableau (qu'on note *n*) en deux. On voit qu'on arrive à une profondeur maximale de l'arbre en *log N* avec *N* la taille de notre tableau, la complexité de la recherche dichotomique est donc dans le pire des cas en *O(log N)*.

*Pour comprendre (ou en savoir plus) sur le logarithme : [lien de la page Wikipédia](https://en.wikipedia.org/wiki/Logarithm)*

## Implémentation

Dans ces implémentations, je suppose que l'élément appartient bien au tableau afin de simplifier le code et de se concentrer sur la recherche dichotomique.

### Récursif

L'implémentation récursive en C de la recherche :

[INSERT]
dichotomie_recursif.c

Si on donne notre tableau en entrée, ainsi que l'élément qu'on recherche :

[INSERT]
test01.in

On obtient bien en sortie :

[INSERT]
test01.out

### Itératif

La version itérative en C :

[INSERT]
dichotomie_iteratif.c

Le tableau et l'élément recherché :

[INSERT]
test01.in

Et la sortie obtenue :

[INSERT]
test01.out

### C/C++

En C, il existe une fonction [`bsearch`](http://www.cplusplus.com/reference/cstdlib/bsearch/) permettant de réaliser une dichotomie.

De même, en C++, la [STL](https://en.wikipedia.org/wiki/Standard_Template_Library) (*Standard Template Library*) implémente des fonctions de recherche dichotomique :

- [`lower_bound`](http://www.cplusplus.com/reference/algorithm/lower_bound/)
- [`upper_bound`](http://www.cplusplus.com/reference/algorithm/upper_bound/)
- [`equal_range`](http://www.cplusplus.com/reference/algorithm/equal_range/)
- [`binary_search`](http://www.cplusplus.com/reference/algorithm/binary_search/)

## Conclusion

Nous avons donc vu que notre dichotomie permet de chercher, de manière générale, un élément dans un ensemble d'élément trié en *O(log N)*.

TODO : autres applications plus concrètes + ex d'ensemble : tableau, dictionnaire + débugger un code ? + nombre d'occurrences d'un nombre N dans un tableau trié + amélioration tri par insertion
