Tri par dénombrement
====================
algo/tri

Publié le : 05/07/2014  
*Modifié le : 31/10/2015*

## Introduction

Le tri par dénombrement (*counting sort* en anglais) est l’un des algorithmes de tri le plus rapide, et pourtant c’est aussi l’un des plus simples, cependant cet algorithme a quelques défauts. Il s’appuie sur la fréquence d’apparition des valeurs pour trier le tableau en un temps linéaire.

## Principe de l’algorithme

Le principe est simple, on parcourt le tableau et on compte le nombre de fois que chaque élément apparaît. Une fois que l’on a le tableau des effectifs *E* (avec *E[i]* le nombre de fois où *i* apparaît dans le tableau), on peut le parcourir dans le sens croissant (pour un tri croissant), ou décroissant (pour un tri décroissant) et placer dans le tableau trié *E[i]* fois l’élément *i* (avec *i* allant de l’élément minimum du tableau jusqu’à l’élément maximum).

## Exemple

Voici un tableau d’entier que l’on souhaite trier dans l’ordre croissant en utilisant le tri par dénombrement : 8, 6, 1, 3, 8, 1, 1.

La première étape est de créer notre tableau des effectifs *E*, la deuxième étape est simplement de le parcourir et de recopier dans le tableau trié les valeurs :

| i | E[i] | Action                 | Tableau trié  |
| - | ---- | ------                 | ------------  |
| 0 | 0    | on ne fait rien        |               |
| 1 | 3    | on ajoute trois fois 1 | 1 1 1         |
| 2 | 0    | on ne fait rien        | 1 1 1         |
| 3 | 1    | on ajoute une fois 3   | 1 1 1 3       |
| 4 | 0    | on ne fait rien        | 1 1 1 3       |
| 5 | 0    | on ne fait rien        | 1 1 1 3       |
| 6 | 1    | on ajoute une fois 6   | 1 1 1 3 6     |
| 7 | 0    | on ne fait rien        | 1 1 1 3 6     |
| 8 | 2    | on ajoute deux fois 8  | 1 1 1 3 6 8 8 |

On a atteint le maximum de notre tableau des effectifs *E*, notre tableau est donc trié :

1, 1, 1, 3, 6, 8, 8.

## Défauts

Cependant cet algorithme possède des défauts (même s'il s’exécute en un temps linéaire) :

- Il ne s’applique que si les nombres du tableau sont des entiers, car je vous rappelle qu'on a *E* un tableau des effectifs avec *E[i]* le nombre de fois où *i* apparaît dans le tableau, donc si *i* est un nombre décimal on ne pourra pas le stocker dans notre tableau des effectifs car il faut que l’index soit un nombre entier. Pour les nombres entiers négatifs, il est possible de contourner le problème mais pour des nombres décimaux il ne l’est pas.
- Il peut prendre très vite beaucoup de place en mémoire. En effet, le tableau des effectifs *E* a pour taille la valeur maximale du tableau, or si cette valeur est très grande, le tableau *E* prendra énormément de place en mémoire. De plus si les valeurs du tableau sont éloignées entre elles, alors beaucoup d’espace mémoire restera inutilisé.

Cet algorithme est donc très utile et efficace si l’on sait que notre tableau en entrée contient des nombres entiers relativement petits et proches de préférence.

## Pseudo-code

Le pseudo-code de l’algorithme :

```nohighlight
triDénombrement :

   Chercher l'élément maximum du tableau
   Créer un tableau E de taille Max + 1, initialisé à 0

   Pour chaque élément du tableau
      Incrémenter E[Tableau[i]]

   Pour chaque élément de E
      Si l'élément i de E est différent de 0
         Recopier E[i] fois le nombre i dans le tableau trié
```

## Complexité

La complexité en temps de cet algorithme se calcule assez facilement. En effet, les seules opérations que l'on effectue dans notre fonction se font en temps linéaire. L'initialisation du tableau des effectifs se fait en *O(N)* (avec *N* la taille du tableau), et la copie des éléments dans notre tableau trié en *O(M)* (avec *M* correspondant à `Max`).

La complexité finale de notre algorithme est de *O(N + M)*, soit une complexité en temps linéaire.

## Implémentation

Le lien vers une implémentation en C du tri par dénombrement :

main.c :

## Conclusion

Le tri par dénombrement est donc un algorithme de tri très efficace dans certaines conditions seulement, et s’exécute en un temps linéaire.
