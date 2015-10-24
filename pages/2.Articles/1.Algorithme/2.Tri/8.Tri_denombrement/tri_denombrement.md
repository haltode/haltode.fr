Tri par dénombrement
====================
algo/tri

Publié le : 05/07/2014  
*Modifié le :*

## Introduction

Le tri par dénombrement (*counting sort* en anglais) est l’un des algorithmes de tri le plus rapide, et pourtant c’est aussi l’un des plus simples, cependant cet algorithme a quelques défauts. Il s’appuie sur la fréquence d’apparition des valeurs pour trier le tableau en un temps linéaire.

## Principe de l’algorithme

Le principe est simple, on parcourt le tableau et on compte le nombre de fois que chaque élément apparaît. Une fois que l’on a le tableau des effectifs *E* (avec *E[i]* le nombre de fois où *i* apparaît dans le tableau), on peut le parcourir dans le sens croissant (pour un tri croissant), ou décroissant (pour un tri décroissant) et placer dans le tableau trié *E[i]* fois l’élément *i* (avec *i* allant de l’élément minimum du tableau jusqu’à l’élément maximum).

## Exemple

Voici un tableau d’entier que l’on souhaite trier dans l’ordre croissant en utilisant le tri par dénombrement : 8, 6, 1, 3, 8, 1, 1.

Tout d’abord on crée le tableau des effectifs E :

  i    0 1 2 3 4 5 6 7 8
E[i]   0 3 0 1 0 0 1 0 2

On parcourt le tableau des effectifs E :

i = 0, E[0] = 0, on ne fait rien.
i = 1, E[1] = 3, on ajoute trois fois le nombre 1 à notre tableau trié : 1, 1, 1.
i = 2, E[2] = 0, on ne fait rien.
i = 3, E[3] = 1, on ajoute une fois le nombre 3 : 1, 1, 1, 3.
i = 4, E[4] = 0, on ne fait rien.
i = 5, E[5] = 0, on ne fait rien.
i = 6, E[6] = 1, on ajoute une fois le nombre 6 : 1, 1, 1, 3, 6.
i = 7, E[7] = 0, on ne fait rien.
i = 8, E[8] = 2, on ajoute deux fois le nombre 8 : 1, 1, 1, 3, 6, 8, 8.

On a atteint le maximum de notre tableau des effectifs E, notre tableau est donc trié :

1, 1, 1, 3, 6, 8, 8.

## Défauts

Cependant cet algorithme possède des défauts (même si il s’exécute en un temps linéaire) :

- Il ne s’applique que si les nombres du tableau sont des entiers, car je vous rappelle que on a *E* un tableau des effectifs avec *E[i]* le nombre de fois où *i* apparaît dans le tableau, donc si *i* est un nombre décimal on ne pourra pas le stocker dans notre tableau des effectifs car il faut que l’index soit un nombre entier. Pour les nombres entiers négatifs, il est possible de contourner le problème mais pour des nombres décimaux il ne l’est pas.
- Il peut prendre très vite beaucoup de place en mémoire. En effet, le tableau des effectifs *E* a pour taille la valeur maximale du tableau, or si cette valeur est très grande, le tableau *E* prendra énormément de place en mémoire. De plus si les valeurs du tableau sont éloignées entre elles, alors beaucoup d’espace mémoire restera inutilisé.

Cet algorithme est donc très utile et efficace si l’on sait que notre tableau en entrée contient des nombres entiers relativement petits et proches de préférence.

## Pseudo-code

Le pseudo-code de l’algorithme :

```nohighlight
Soit N la taille du tableau à trier

triParDénombrement(Tableau, N) :
   Max -> -infini

   Pour i = 0, allant jusqu'à N à pas de 1
      Si l'élément i de Tableau est supérieur à Max
         Max -> Tableau[i]

   Créer un tableau E de taille Max + 1, initialisé à 0

   Pour i = 0, allant jusqu'à N à pas de 1
      Incrémenter E[Tableau[i]] de 1

   Pour i = 0, allant jusqu'à Max (inclus) à pas de 1
      Si l'élément i de E est différent de 0
         Recopier E[i] fois le nombre i dans le tableau trié
```

Rien de compliqué dans ce pseudo-code, il faut juste faire attention à ne pas oublier de créer un tableau des effectifs de taille *Max + 1*, car il faut pouvoir stocker *Max* (puisqu’un tableau commence à l’index 0). Pareil pour la dernière boucle, on parcourt bien jusqu’à *Max* inclus.

## Complexité

La complexité de cet algorithme se calcule assez facilement. En effet, la recherche de la valeur maximale du tableau se fait en temps linéaire, soit *O(N)*, et la création du tableau trié se fait en temps linéaire de *O(M)* avec *M* correspondant à *Max*.

On a donc une complexité finale de *O(N + M)*, qui est bien une complexité en temps linéaire.

## Implémentation

Le lien vers une implémentation en C du tri par dénombrement :

main.c :

Quelques remarques à propos du code :

- Le code suit le pseudo-code, on cherche tout d’abord l’élément maximum du tableau, puis on crée le tableau des effectifs (ici j’utilise la fonction [calloc](http://www.cplusplus.com/reference/cstdlib/calloc/?kw=calloc) qui me permet de créer un tableau dynamique directement initialisé à 0, je ne vérifie pas le retour pour ne pas encombrer le code mais normalement il faut toujours vérifier le retour d’une allocation dynamique), puis on initialise notre tableau avec les effectifs, enfin on trie notre tableau à l’aide des effectifs comme dans le pseudo-code.

## Conclusion

Le tri par dénombrement est donc un algorithme de tri très efficace dans certaines conditions seulement, et s’exécute en un temps linéaire.
