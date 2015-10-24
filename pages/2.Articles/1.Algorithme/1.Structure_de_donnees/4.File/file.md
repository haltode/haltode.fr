File
====
algo/structure/

Publié le : 08/06/2014  
*Modifié le :*

## Introduction

Une file (*queue* en anglais) est une structure de données de type **FIFO** (**F**irst **I**n **F**irst **O**ut, *premier entré premier sorti*).

## Principe de la file

Une file fonctionne exactement comme une file d’attente dans un magasin :

- Le premier client arrivé dans la file sera le premier servi.
- Le dernier client arrivé dans la file sera le dernier servi.

Voici comment on pourrait représenter une file :

![Exemple représentation d'une file](/static/img/algo/structure/file/exemple_file.png)

L’action d’ajouter un élément dans la file est appelée : **enfiler** (ou *enqueue* en anglais) :

![Un nouvel élément est enfilé](/static/img/algo/structure/file/exemple_ajout.png)

L’action d’enlever un élément de la file est appelée : **défiler** (ou *dequeue* en anglais) :

![Un élément est défilé](/static/img/algo/structure/file/exemple_suppression.png)

Cette fois ci, j'implémenterai la file uniquement avec une [liste chaînée](http://napnac.ga/algo/structure/liste_chainee.html) car les tableaux ne sont pas du tout adaptés à ce genre de structure de données (soit on gaspille de la mémoire, soit on réalise beaucoup d'opérations inutiles).

## Quelques fonctions pour manipuler une file

Comme pour une liste chaînée et une pile, des fonctions de bases sont nécessaires pour bien manipuler une file.

```nohighlight
créerFile :
   Créer un premier élément
   Initialiser les données de l'élément
   Le faire pointer sur NULL (pour indiquer la fin de la file)
   Retourner l'élément
supprimerFile :
   Pour chaque élément de la file
      Supprimer l'élément actuel

enfiler (élément) :
   Faire pointer le nouvel élément vers le début de la file
défiler :
   Parcourir la file jusqu'à l'avant dernier élément
   Sauvegarder les données du dernier élément
   Faire pointer l'avant dernier élément sur NULL
   Supprimer le dernier élément
   Retourner les données sauvegardées

afficher :
   Pour chaque élément de la file
      Afficher les données de l'élément actuel

estVide :
   Si le premier élément de la file est NULL
      Retourner vrai
   Sinon
      Retourner faux

taille :
   Pour chaque élément de la file
      Incrémenter nbElement
   Retourner nbElement
```

## Complexité

Soit *N* le nombre d'éléments de la file.

- `créerFile` : *O(1)*
- `supprimerFile` : *O(N)*
- `enfiler` : *O(1)*
- `défiler` : *O(N)*
- `afficher` : *O(N)*
- `estVide` : *O(1)*
- `taille` : *O(N)*


## Implémentation

Le lien vers une implémentation en C d’une file :

main.c : 

### STL

Si vous programmez en C++, la [STL](https://en.wikipedia.org/wiki/Standard_Template_Library) (*Standard Template Library*) fournit une implémentation et des fonctions permettant de manipuler une file : <http://www.cplusplus.com/reference/queue/queue/> 

## Conclusion

La file est donc une structure de données utile lorsqu’il s’agit d’implémenter une file d’attente.
