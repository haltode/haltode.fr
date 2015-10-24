Tri Shell
=========
algo/tri

Publié le : 03/05/2014  
*Modifié le :*

## Introduction

Le tri Shell (*Shell sort* en anglais) est un algorithme de tri par comparaison inventé en 1959 par Donald L. Shell, cet algorithme est basé sur le [tri par insertion](http://napnac.ga/algo/tri/tri_insertion.html). En effet le tri Shell utilise la propriété du tri par insertion d’être très rapide sur des tableaux presque triés, on va donc échanger quelques éléments du tableau à un écart bien précis (calculé à l’aide d’une formule mathématique), puis appliquer le tri par insertion sur le tableau qui est alors presque trié. Cet algorithme n’est pas stable contrairement au tri par insertion mais tri sur place.

## Principe de l’algorithme

Le principe de l’algorithme est le même que celui du tri par insertion, sauf qu’on va comparer les éléments du tableau à un certain intervalle (si cet intervalle est de un, alors cela revient à effectuer un tri par insertion). On peut calculer cet intervalle grâce à la formule mathématique suivante :

*Écart(N + 1) = 3 \* Écart(N) + 1*, avec *Écart(0) = 0*

Cette formule permet de calculer un écart relativement optimisé pour permettre au tri Shell d’être plus rapide que le tri par insertion. L’écart est extrêmement important, et ne doit pas être choisi au hasard car c’est l’élément clé de cet algorithme, et c’est lui qui va faire la différence au niveau du temps.

Une fois que l’écart est calculé (on va l’appeler *E*), on échange (si nécessaire et en fonction de l’ordre de tri voulu), les valeurs ayant pour écart *E*. On fait cela jusqu’à ce que *E* soit égal à 1, une fois que c’est le cas, on applique juste un tri par insertion sur le tableau qui est alors beaucoup moins en désordre.

## Exemple

Prenons comme exemple la suite de nombre suivante et appliquons lui l’algorithme du tri Shell dans un ordre croissant : 5, 8, 2, 9, 1, 3 :

Tout d’abord, il faut calculer l’écart *E* en fonction de la taille de la suite (ici la suite comporte 6 éléments) :

```nohighlight
Écart(0) = 0
Écart(1) = 3 * Écart(0) + 1 = 3 * 0 + 1 = 1
Écart(2) = 3 * Écart(1) + 1 = 3 * 1 + 1 = 4
Écart(3) = 3 * Écart(2) + 1 = 3 * 4 + 1 = 13
```

On s’arrête dès que la valeur calculée dépasse le nombre d’éléments à trier, ici on s’arrête donc à 13. On a donc nos différents écarts :

- 13 n’est pas pris en compte car il est supérieur à 6, il n’y a donc aucun élément avec un écart de 13 cases dans ce tableau.
- 4 est donc le premier écart.
- 1 est le dernier, je vous rappelle que lorsque l’écart est égal à un c’est comme si l’on utilisait le tri par insertion.

Ici on a donc seulement un écart que l’on peut utiliser (sans compter le 1, car c’est le cas de base), mais sur de plus grands tableaux avec plusieurs centaines d’éléments on utilisera bien plus d’écart.

Première étape, on utilise notre premier écart (4) pour comparer les éléments et les échanger s’ils ne sont pas dans l’ordre croissant :

5, 8, 2, 9, 1, 3 -> on voit que 5 est supérieur à 1, on les échange.

1, 8, 2, 9, 5, 3 -> on voit que 8 est supérieur à 3, on les échange.

1, 3, 2, 9, 5, 8 -> plus d’échange possible avec un écart de 4, on passe donc au prochain écart : 1.

Deuxième étape, appliquer le tri par insertion sur le tableau. Je ne vous montre pas cette étape car il vous suffit de lire l’article que j’ai rédigé à propos du tri par insertion pour comprendre le fonctionnement de cette étape. Cependant vous remarquez que le tableau est bien plus ordonné qu’au départ (même s’il est petit, et on utilise rarement le tri Shell sur des tableaux aussi petits mais c’est plus simple pour vous en faire un exemple).

## Pseudo-code

Le pseudo-code du tri Shell :

```nohighlight
Soit N la taille du tableau à trier

triShell(Tableau, N) :
   Pour E = écart maximum du tableau (inférieur à N), allant jusqu'à 1 et divisé par 3 à chaque tour
      Pour i = E, allant jusqu'à N à pas de 1
         temporaire -> valeur de l'élément i du tableau
         j -> i, Tant que j est supérieur à E - 1 ET l'élément j - E est supérieur à temporaire
            Décaler les éléments j et j - E du tableau
            j -> j - E
         Insérer la valeur temporaire à l'élément j du tableau
```

Quelques points sur le pseudo-code :

- Je passe la partie où l’on calcule l’écart maximum car je fais appelle à une fonction qui le fait pour moi (dans notre exemple plus haut, la fonction aurait renvoyé 4). Ensuite je divise à chaque tour par 3, pour pouvoir retrouver toutes mes valeurs d’écarts obtenues au fur et à mesure de la formule. En effet, si j’effectue une division euclidienne de 13 par 3 j’obtiens bien 4, et si je fais pareil avec 4 et 3, j’obtiens 1, on retrouve donc : 13, 4 et 1 qui sont les bonnes valeurs.
- On décale les éléments comme dans le tri par insertion, c’est-à-dire que l’on sauvegarde la valeur située à l’élément *i* (initialisé à *E*), puis si on peut décaler l’élément actuel d’une place vers la droite (sans être en dehors du tableau) on le fait, et enfin on insère notre donnée sauvegardée auparavant.

## Complexité

La complexité de l’algorithme de tri Shell dans le pire des cas est en *O(N²)*, cependant cet algorithme est plus rapide que le tri par insertion.

Le calcul exact de la complexité de cet algorithme est assez complexe, de plus il varie en fonction de l’écart choisi et du tableau à proprement parlé. Il faut donc retenir que cet algorithme à une complexité dans le pire des cas en *O(N²)*, mais qu’il est toujours plus efficace que le tri par insertion.

## Implémentation

Le lien vers une implémentation en C du tri Shell :

main.c :

Quelques explications à propos du code C :

- Tout d’abord, je crée une fonction `formule` me renvoyant l’écart maximum possible avec mon tableau. On renvoie à la fin `ecart / 3` car je vous rappelle que l’on veut que cette fonction nous renvoie 4 et non 13 pour rester avec notre exemple.
- Ensuite, le reste du code est le même que pour le pseudo-code.

## Conclusion

L’algorithme du tri Shell est donc une amélioration efficace du tri par insertion, même s’il reste en *O(N²)* dans le pire des cas.
