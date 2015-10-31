Pile
====
algo/structure

Publié le : 08/06/2014  
*Modifié le : 24/10/2015*

## Introduction

Une pile (*stack* en anglais) est une structure de données de type **LIFO** (**L**ast **I**n **F**irst **O**ut, *dernier arrivé premier sorti*).

## Principe de la pile

Une pile fonctionne exactement comme une pile d’assiettes :

- Quand on ajoute une assiette sur la pile on l’ajoute en haut.
- Quand on enlève une assiette de la pile on enlève celle du haut pour ne pas faire tomber le reste.

C’est le principe LIFO, lorsqu’on ajoute un élément sur une pile il est en haut, et lorsqu’on retire un élément de la pile, on retire l’élément tout en haut.

![Exemple de représentation d'une pile](/static/img/algo/structure/pile/exemple_pile.png)

L’action d’ajouter un élément dans la pile est appelée : **empiler** (ou *push* en anglais) :

![Un nouvel élément est empilé](/static/img/algo/structure/pile/exemple_ajout.png)

L’action d’enlever un élément de la pile est appelée : **dépiler** (ou *pop* en anglais) :

![Un élément est dépilé](/static/img/algo/structure/pile/exemple_suppression.png)

Pour représenter une pile, je vais vous présenter deux moyens :

- Avec une [liste chaînée](/algo/structure/liste_chainee.html).
- Avec un tableau ainsi qu’un index nous indiquant le prochain élément libre dans la pile. Cet index est appelé pointeur de pile (ou *stack pointer* en anglais, souvent abrégé *SP*).

## Quelques fonctions pour manipuler une pile

Comme pour une liste chaînée, il existe différentes fonctions de bases permettant de manipuler une pile.

### Avec une liste chaînée

```nohighlight
créerPile :
   Créer un premier élément
   Initialiser les données de l'élément
   Le faire pointer sur NULL (pour indiquer la fin de la pile)
   Retourner l'élément
supprimerPile :
   Pour chaque élément de la pile
      Supprimer l'élément actuel

empiler (élément) :
   Faire pointer le haut de la pile vers le nouvel élément
dépiler :
   Sauvegarder les données de l'élément en haut de la pile
   Supprimer l'élément en haut
   Faire pointer le haut de la pile vers NULL
   Retourner les données sauvegardées

afficher :
   Pour chaque élément de la pile
      Afficher les données de l'élément actuel

estVide :
   Si le premier élément de la pile est NULL
      Retourner vrai
   Sinon
      Retourner faux

taille :
   Pour chaque élément de la pile
      Incrémenter nbElement
   Retourner nbElement 
```

### Avec un tableau

```nohighlight
créerPile :
   Créer un tableau d'une taille fixe et suffisamment grand pour la pile
   Initialiser le pointeur de pile (PP) à 0
supprimerPile :
   Supprimer le tableau

empiler (élément) :
   Affecter les données du nouvel élément à la case d'index PP du tableau
   Incrémenter le PP
dépiler :
   Décrémenter le PP
   Retourner les données de l'élément d'index PP du tableau

afficher :
   Pour chaque élément de la pile
      Afficher les données de l'élément actuel

estVide :
   Si PP = 0
      Retourner vrai
   Sinon 
      Retourner faux

taille :
   Retourner PP
```

## Complexité

Soit *N* le nombre d'éléments de la pile.

- `créerPile` : *O(1)*
- `supprimerPile` : *O(N)*
- `empiler` : *O(1)*
- `dépiler` : *O(1)*
- `afficher` : *O(N)*
- `estVide` : *O(1)*
- `taille` : *O(N)*

## Implémentation

### Liste chaînée

Le lien vers une implémentation en C d’une pile à l’aide d’une liste chaînée :

main.c : 

Le code est simple et ne nécessite pas d’explication, si besoin je vous invite à relire l'article sur les listes chaînées pour bien comprendre le code : </algo/structure/liste_chainee.html>

### Tableau

Le lien vers une implémentation en C d’une pile à l’aide d’un tableau :

main.c : 

Cette implémentation a pour but d’être extrêmement simple à utiliser, comprendre et à implémenter.

### STL

Si vous programmez en C++, la [STL](https://en.wikipedia.org/wiki/Standard_Template_Library) (*Standard Template Library*) fournit une implémentation et des fonctions permettant de manipuler une pile : <http://www.cplusplus.com/reference/stack/stack/>

## Conclusion

La pile est donc une structure de données facile à implémenter et peut être pratique dans de nombreux domaines : 

- Dans un éditeur : quand vous écrivez votre prochain article sur votre éditeur préféré, et que vous ne cessez de faire des ctrl-z et ctrl-y pour revenir en arrière/avant, et bien vous utilisez une pile. Chaque opération va être empilé pour garder l'ordre dans lequel vous les avez réalisées, et vous pouvez ainsi facilement parcourir la pile des opérations pour vous retrouver à tel moment précis de votre édition.
- Lors d'un appel de fonction : à chaque fois que vous appelez une fonction dans votre programme, la pile d'exécution (ou [pile d'appel](https://en.wikipedia.org/wiki/Call_stack)) empile les informations à propos de l'endroit où vous réalisez l'appel pour se souvenir où revenir à la fin de la fonction appelée.
- Pour évaluer des expressions : dans certains cas, une pile peut être utilisé pour évaluer des expressions (mathématiques ou syntaxiques). Par exemple, si vous devez évaluer une expression en notation polonaise inverse ([NPI](https://en.wikipedia.org/wiki/Reverse_Polish_notation)), une pile est indispensable pour calculer l'expression au fur et à mesure des opérations (quand vous rencontrez un nombre vous l'empilez, quand vous rencontrez un opérateur vous dépilez les deux derniers éléments et vous empilez le résultat).
- Dans une machine virtuelle : plusieurs [machines virtuelles](https://en.wikipedia.org/wiki/Virtual_machine) sont implémentées sur le principe d'une pile, par exemple celle de Java. Si vous voulez en savoir plus à ce sujet, cet article explique très bien le principe de machine virtuelle et les différentes implémentations possible : <https://markfaction.wordpress.com/2012/07/15/stack-based-vs-register-based-virtual-machine-architecture-and-the-dalvik-vm/>
