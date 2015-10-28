Tri rapide
==========
algo/tri

Publié le : 10/05/2014  
*Modifié le :*

## Introduction

Le tri rapide (*quick sort* en anglais) est un algorithme de tri par comparaison inventé en 1962 par Hoare, son fonctionnement est plutôt simple à comprendre, il est très utilisé sur de grandes entrées. En effet il a pour complexité moyenne de *O(N \* log(N))* et de *O(N²)* dans le pire des cas. Cependant même si cet algorithme est lent dans le pire des cas, il est le plus utilisé en pratique que d’autres tris comme le [tri par fusion](http://napnac.ga/algo/tri/tri_fusion.html) qui a une complexité dans le pire des cas en *O(N \* log(N))*. C’est un algorithme non stable mais en place.

## Principe de l’algorithme

Le tri rapide utilise le principe de diviser pour régner, c’est-à-dire que l’on va choisir un élément du tableau (que l’on appelle **pivot**), puis l’on **réorganise** le tableau initial en deux sous tableaux :

- L’un contenant les éléments du tableau inférieurs au pivot.
- L’autre contenant les éléments supérieurs au pivot.

On continue ce procédé jusqu’à se retrouver avec un tableau découpé en *N* sous tableaux (*N* étant la taille du tableau), qui est donc trié.

## Exemple

Si l’on prend 5, 9, 7, 3, 8 comme suite de nombres, et que l’on utilise l’algorithme du tri rapide pour trier cette suite dans l’ordre croissant, voici comment faire :

5, 9, 7, 3, 8 -> on choisit le pivot, je choisirai tout le temps l’élément du milieu pour le tableau actuel : ici 7.

5, 3 | 7 | 9, 8 -> j’ai représenté les sous tableaux, et je les ai séparés, l’un est inférieur au pivot et l’autre est supérieur. Vous remarquez que les sous tableaux ne sont pas triés (mais déjà plus qu’au départ), cependant le pivot est bien à sa place définitive, en effet tous les éléments qui lui sont supérieurs sont à sa droite et les éléments inférieurs à sa gauche.

3 | 5 | 7 | 9, 8 -> je prends mon premier sous tableaux et je recommence l’opération de partitionnement (c’est le terme exact qui définit le fait de choisir un pivot et de placer les éléments du tableau inférieurs au pivot à sa gauche et les éléments supérieurs à sa droite). Je choisis 3 comme pivot, on se retrouve donc avec trois sous tableaux ne contenant qu’un seul élément (et donc déjà triés), et encore un sous tableaux contenant deux éléments sur lequel on va appliquer le principe de partitionnement.

3 | 5 | 7 | 8 | 9 -> je prends comme pivot 9 et je place donc 8 à sa gauche, mon tableau ne contient plus aucun sous tableau de plus d’un élément, il est donc entièrement trié.

3, 5, 7, 8, 9

## Pseudo-code

Voici le pseudo-code du tri rapide :

```nohighlight
triRapide (Tableau, début, fin) :
   Si le tableau actuel a plus d'un élément
      Choisir le pivot
      Échanger le pivot avec le premier élément du tableau
      dernierEmplacement -> début (emplacement du pivot)

      Pour i = début + 1, allant jusqu'à fin à pas de 1
         Si Tableau[i] est inférieur au pivot
            Incrémenter dernierEmplacement
            Échanger l'élément i de Tableau et l'élément dernierEmplacement
      Placer le pivot à sa place définitive

   triRapide(Tableau, début, dernierEmplacement - 1)
   triRapide(Tableau, dernierEmplacement + 1, fin)
```

Quelques remarques sur ce pseudo-code :

- Le choix du pivot est important dans le tri rapide, je vais faire comme dans l’exemple et toujours choisir l’élément du milieu.
- On place le pivot que l’on a choisi au début du tableau pour pouvoir plus facilement parcourir le tableau sans passer par le pivot (on parcourt tout simplement le tableau entier en commençant à partir du deuxième élément). Cependant il nous faut garder l’emplacement de se pivot pour pouvoir bien le placer à la fin du partitionnement (d’où la variable `dernierEmplacement`).
- On parcourt le tableau et on échange les éléments inférieurs au pivot, pour les mettre à leurs places.
- On place le pivot à sa place définitive.
- Enfin on rappelle la fonction `triRapide` mais sur les sous tableaux *début à dernierEmplacement – 1* et *dernireEmplacement + 1 à fin* qui sont les sous tableaux situés aux extrémités du pivot (l’élément situé au milieu du tableau).

Pour bien comprendre ce pseudo-code et le fonctionnement du tri rapide, je vous conseille vivement de suivre ce pseudo-code à la lettre sur l’exemple donné au dessus.

## Complexité

Le tri rapide a une complexité moyenne de *O(N \* log(N))* :

- Dans la fonction `triRapide`, on utilise une boucle qui parcourt le tableau de taille *N*, cette boucle a donc pour complexité *O(N)*.
- Ensuite à la fin de la fonction `triRapide`, on appelle récursivement la fonction deux fois. Si vous ne le savez pas, les algorithmes utilisant le principe du diviser pour régner ont une complexité de *O(log(N))*.

Donc si l’on fusionne nos deux complexités on se retrouve avec comme complexité finale de *O(N \* log(N))*.

L’algorithme du tri rapide peut être deux fois plus rapide que le [tri par tas](http://napnac.ga/algo/tri/tri_tas.html) pour une raison de cache et de mémoire. En effet, lorsque vous accédez à votre tableau, la mémoire garde en cache le tableau (ou une partie s’il est trop grand), si vous demandez un élément hors du cache, la mémoire va aller chercher l’élément et à son tour charger dans la mémoire cache la partie du tableau contenant cet élément. Le tri par tas compare des éléments du tableau assez éloignés ce qui signifie que sur de grandes entrées (dont la taille dépasse celle du cache), la mémoire sera amené à charger bien plus d’éléments dans le cache et donc cela ralentie l’algorithme.

## Implémentation

L’implémentation suit le pseudo-code :

main.c : 

L’implémentation en C est rudimentaire, et est là pour vous proposer un code facile à comprendre et à utiliser. Vous pouvez aussi l’améliorer avec les idées que je vous propose ci-dessous.

Aucun commentaire à propos du code, si vous avez compris le pseudo-code vous n’aurez aucun mal à comprendre cette implémentation.

## Amélioration 1

La première amélioration à faire sur notre algorithme concerne le choix du pivot. En effet ce choix peut améliorer le temps d’exécution du tri rapide, pour cela il faut choisir un pivot optimal comme la valeur **médiane** du tableau. La valeur médiane d’un tableau est l’élément qui est situé au milieu du tableau et qui coupe ce dernier en deux sous tableaux de même taille. De plus elle peut être trouvée en temps linéaire dans un tableau.

Par exemple avec ce tableau de nombres : 3, 9, 7, 5, 1. Si l’on suit notre algorithme on devrait prendre 7 comme pivot, on se retrouve donc avec les deux sous tableaux suivants : 1, 3, 5 et 9 qui ne sont pas de la même taille. En revanche si l’on prend 5 (la valeur médiane du tableau) comme pivot on se retrouve avec les deux sous tableaux : 1, 3 et 7, 9 qui contiennent deux éléments chacun.

Cette amélioration nous permet donc de raccourcir le nombre d’appels récursifs de la fonction et ainsi d’améliorer sa complexité en temps. Techniquement, avec notre nouvel algorithme le tri rapide a pour complexité dans le pire des cas en *O(N \* log(N))*.

## Amélioration 2

La deuxième amélioration se base sur le fait que le tri rapide est moins rapide (paradoxalement) sur une petite entrée que d’autres algorithmes de tri comme le [tri par insertion](http://napnac.ga/algo/tri/tri_insertion.html), ou le [tri par sélection](http://napnac.ga/algo/tri/tri_selection.html) (qui eux sont moins efficaces sur des entrées de grande taille).

On peut donc combiner les deux tris, et faire en sorte d’utiliser le tri par insertion (ou par sélection) lorsque le tableau inférieure à une certaine limite, sinon on utilise le tri rapide. Cette taille limite tourne en général au tour des 15 éléments en moyenne mais varie selon l’ordinateur.

Cette amélioration est plus rapide, mais n’est pas optimale à cause de la limite qu’il faut fixer, or cette dernière varie beaucoup.

## Amélioration 3

Enfin la dernière amélioration que je vous présente est l’Introsort. C’est une variante du tri rapide permettant d’améliorer sa complexité en temps dans le pire des cas en *O(N \* log(N))*. Pour cela, l’Introsort arrête le tri rapide lorsque la récursion dépasse une certaine profondeur et utilise un algorithme de tri plus efficace dans ce genre de situation comme le [tri par tas](http://napnac.ga/algo/tri/tri_tas.html) pour finir le travail. Ensuite le tri rapide reprend la main sur le tri par tas, et ainsi de suite.

## Conclusion

Le tri rapide est donc un algorithme de tri efficace, qui a une complexité en *O(N \* log(N))* et *O(N²)* dans le pire des cas (ce qui est assez rare, en pratique le tri s’exécute en *O(N \* log(N))*). Cependant cet algorithme est très utilisé, et peut être largement amélioré. Cet algorithme est même implémenté dans certains langages de programmation comme le C avec la fonction [qsort](http://www.cplusplus.com/reference/cstdlib/qsort/?kw=qsort) définit dans `stdlib.h`.
