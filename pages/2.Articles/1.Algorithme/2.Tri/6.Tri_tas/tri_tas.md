Tri par tas
===========
algo/tri

Publié le : 14/05/2014  
*Modifié le : 30/10/2015*

## Introduction

Le tri par tas (*heapsort* en anglais) est un algorithme de tri par comparaison, plutôt efficace et qui a une complexité en *O(N \* log N)*. C’est un algorithme de tri [non stable](https://en.wikipedia.org/wiki/Sorting_algorithm#Stability) mais [en place](https://en.wikipedia.org/wiki/In-place_algorithm).

## Principe de l’algorithme

L'algorithme du tri par tas repose sur un élément fondamental : le [tas]() (d'où son nom). En effet, ce tri crée un tas du tableau que l'on souhaite trier (un tas max si on trie dans l'ordre croissant et un tas min dans l'ordre décroissant). Une fois qu'on a ce tas, on peut le parcourir pour reconstituer les valeurs triées dans notre tableau.

## Exemple

On prend la suite de nombres suivante que l’on va trier dans l’ordre croissant avec le tri par tas : 1, 9, 3, 7, 6, 1, 4.

*1ère étape* : créer le tas (max dans notre cas)

![Tas max correspondant au tableau](/static/img/algo/tri/tri_tas/exemple_tas_max.png)

*2ème étape* : parcourir le tas pour trier les éléments

Pour trier les éléments grâce à notre tas, on retire la racine à chaque tour (l'élément le plus grand de notre tas, et de notre tableau), on le range à sa place définitive dans le tableau, et on entasse le dernier élément du tas pour combler le trou de la racine et respecter les règles d'un tas.

![1er tour](/static/img/algo/tri/tri_tas/exemple_tour1.png)

La racine du tas (en vert) est placée dans le tableau et le dernier élément (en bleu) va remplacer la racine, mais il ne faut pas oublier de l'entasser pour respecter les règles du tas max.

On continue ces opérations tant que le tas n'est pas vide :

![Fin du tri par tas](/static/img/algo/tri/tri_tas/exemple_tour2.png)

## Pseudo-code

Voici le pseudo-code du tri par tas :

```nohighlight
triTas :

   Contruire le tas max du tableau

   Pour chaque élément du tableau (en partant de la fin)
      Echanger l'élément avec la racine
      Décrémenter la taille du tas
      Entasser l'élément placé à la racine
```

En réalité, nous ne créons pas de tas à part, on réarrange simplement les éléments du tableau pour qu'il fonctionne comme un tas max car c'est plus simple pour le manipuler. On parcourt donc notre tableau dans le sens inverse, pour toujours avoir comme élément actuel le dernier élément du tas, que l'on va échanger avec la racine qui désormais est bien placée, on n'oublie pas de diminuer la taille du tas pour ne plus prendre en compte notre élément que l'on vient de placer, et on finit par entasser la nouvelle racine pour continuer à respecter les règles d'un tas.

*Toutes les fonctions relatives à un tas (`construire`, `entasser`, etc.) sont décrites dans mon article à ce propos je n'en reparlerai pas ici.*

## Complexité

La complexité de l’algorithme du tri par tas est en *O(N \* log N)*. En effet, la boucle principale parcourt *N* tours (*N* étant la taille du tableau), et appelle à chaque tour une fonction pour entasser qui a une complexité logarithmique.

*Si vous n’avez pas lu mon article sur le [tri rapide](http://napnac.ga/algo/tri/tri_rapide.html), je vous conseille au moins de lire la partie complexité dans laquelle j’explique pourquoi le tri rapide peut être jusqu’à deux fois plus efficace que le tri par tas.*

## Implémentation

Voici le lien vers une implémentation en C de l’algorithme du tri pas tas :

main.c : 

## Améliorations et variantes

### Mélange d'algorithme

Comme pour le [tri rapide](http://napnac.ga/algo/tri/tri_rapide.html), le tri par tas peut être mélangé avec un autre algorithme de tri lorsque le tableau possède peu d’éléments afin de le rendre plus efficace. Pour en savoir plus, je vous invite à lire la partie **Mélange d'algorithme** dans les **Améliorations et variantes** de mon article sur le tri rapide.

### Smoothsort

## Conclusion

Le tri par tas est donc un algorithme de tri efficace en *O(N \* log N)* non stable mais en place, et plutôt facile à implémenter.
