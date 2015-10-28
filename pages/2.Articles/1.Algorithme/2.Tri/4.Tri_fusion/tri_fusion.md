Tri fusion
==========
algo/tri

Publié le : 10/05/2014  
*Modifié le : 28/10/2015*

## Introduction

Le tri fusion (*merge sort* en anglais) est un algorithme de tri par comparaison efficace qui a pour complexité *O(N \* log N)*, il se base sur le principe du diviser pour régner. Cet algorithme est [stable](https://en.wikipedia.org/wiki/Sorting_algorithm#Stability) mais ne s’exécute pas [en place](https://en.wikipedia.org/wiki/In-place_algorithm).

## Principe de l’algorithme

L'algorithme se compose de deux parties distinctes :

- **Diviser** : on divise récursivement le tableau, c'est-à-dire qu'on va couper le tableau en deux sous-tableaux et recommencer cette opération sur ces derniers jusqu'à ce que chaque sous-tableau ne contienne plus qu'un seul élément.
- **Fusionner** : une fois notre tableau divisé en *N* sous-tableaux (*N* étant le nombre d'éléments), on fusionne deux à deux les tableaux dans l'ordre du tri (croissant ou décroissant).

L'intérêt de diviser pour ensuite fusionner est que créer un tableau trié à partir de deux sous-tableaux peut s'effectuer en temps linéaire. C'est ce point en particulier qui fait la rapidité du tri fusion.

## Exemple

Prenons comme exemple la suite de nombre : 5, 1, 3, 8, 9, 6 que l’on veut trier avec le tri fusion dans l’ordre croissant :

*1ère étape* : diviser

5, 1, 3 | 8, 9, 6 -> on divise le tableau en deux.

5, | 1, 3 | 8 | 9, 6 -> on divise en deux les sous-tableaux.

5 | 1 | 3 | 8 | 9 | 6 -> chaque sous-tableau est de nouveau divisé pour n'avoir plus qu'un seul élément.

*2ème étape* : fusionner

1, 5 | 3, 8 | 6, 9  -> on prend deux sous-tableaux adjacents que l'on fusionne en les ordonnant.

1, 3, 5, 8 | 6, 9 -> on continue la fusion des sous-tableaux.

1, 3, 5, 6, 8, 9 -> le tableau ne contient plus de sous-tableaux, il est donc trié.

1, 3, 5, 6, 8, 9

Pour résumer les deux étapes du tri :

![Exemple de tri fusion](/static/img/algo/tri/tri_fusion/exemple_tri.png)

## Pseudo-code

Voici le pseudo-code du tri fusion :

```nohighlight
triFusion (début, fin) :

   Si le tableau actuel a plus d'un élément
      milieu -> (début + fin) / 2
      triFusion(début, milieu)
      triFusion(milieu + 1, fin)
      fusionner(début, milieu, fin)
   Sinon
      Arrêter

fusionner (début, milieu, fin) :

   A -> éléments du tableau de début à milieu
   B -> éléments du tableau de milieu + 1 à fin

   Pour i = début, allant jusqu'à fin à pas de 1
      Si A[indexA] <= B[indexB]
         Tableau[i] = A[indexA]
         Incrémenter indexA 
      Sinon
         Tableau[i] = B[indexB]
         Incrémenter indexB
```

Ce pseudo-code est relativement simple :

- Dans la fonction `triFusion`, on utilise la [récursivité](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29) pour découper puis fusionner notre tableau, et on arrête les appels récursifs lorsque le sous-tableau que l'on traite n'a plus qu'un seul élément.
- La fonction `fusionner` est assez explicite, elle nous permet de créer à partir de deux sous-tableaux triés, un tableau lui aussi trié en temps linéaire.

## Complexité

La complexité du tri fusion est de *O(N \* log N)*, puisque notre fonction `triFusion` contient deux appels récursifs (complexité logarithmique en *O(log N)*) et la fonction `fusionner` s'éxécute en temps linéaire, *O(N)*.

## Implémentation

Le lien vers l’implémentation du tri fusion :

main.c : 

## Améliorations et variantes

### Liste chaînée

Les [listes chaînées](http://napnac.ga/algo/structure/liste_chainee.html) sont effectivement un bon moyen d'implémenter le tri fusion à cause de cette flexibilité que ce tri impose. En effet, on doit pouvoir séparer des éléments pour les fusionner dans un ordre différent après, et ces opérations ne sont pas pratiques ni optimales avec des tableaux, mais sont adaptées à des listes chaînées.

La complexité en temps ne bouge pas mais la complexité en mémoire est améliorée.

## Conclusion

Le tri fusion est donc un algorithme de tri efficace, qui a pour complexité *O(N \* log N)*.
