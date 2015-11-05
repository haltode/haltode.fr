Tableau cumulatif
=================
algo/structure

Publié le :   
*Modifié le :*

## Introduction

Je vous donne un tableau possédant des milliards de milliards d'éléments, et je vous pose des milliards de questions de la forme : Quelle est la somme des éléments compris entre l'indice *i* et *j* du tableau ? La première idée d'algorithme naïf que l'on peut avoir, est de parcourir pour chaque question les éléments situés entre les indices donnés, et d'augmenter une variable `somme` au fur et à mesure du parcours.

Cependant nos parcours sont très nombreux, et notre solution bien trop longue dans le cas extrême donné. Il nous faut donc une solution plus efficace, nous permettant de faire moins de parcours inutiles afin de raccourcir notre temps d'exécution : le tableau cumulatif.

## Principe du tableau cumulatif

Dans notre algorithme naïf, on passe plusieurs fois et très souvent sur de mêmes éléments, on peut aussi parcourir le tableau en entier à de multiples occasions, mais lors de ces parcours on n'utilise aucune des informations récoltées autrement que pour répondre à une seule question parmi des milliards.

L'idée du tableau cumulatif est de parcourir une seule fois notre tableau en entier, et d'utiliser les données récoltées pour pouvoir ensuite répondre à n'importe quel type de question à propos de somme d'éléments contigus.

On peut très simplement expliquer son principe grâce à la géométrie :

![Explication géométrique du tableau cumulatif](/static/img/algo/structure/tableau_cumulatif/explication_geo.png)

## Exemple

Afin de parfaitement comprendre comment utiliser un tableau cumulatif, prenons l'exemple de ce tableau : 26, 42, 1, 89, 3, 7.

*1ère étape* : créer notre tableau cumulatif

A partir de la suite de nombres, on va créer un tableau cumulatif qui contiendra pour chaque élément *i* l'élément du tableau original + l'élément *i - 1* de notre tableau cumulatif. Cela aura pour effet de créer un tableau contenant dans la première case l'élément 1, dans la deuxième case l'élément 1 + 2, dans la troisième case l'élément 1 + 2 + 3, etc.

| Tableau cumulatif | Commentaire |
| ----------------- | ----------- |
| 26 | Le premier élément du tableau cumulatif est le même que celui du tableau original |
| 26, 68 | Le deuxième élément est l'addition du deuxième élément de notre tableau (42), et du dernier élément de notre tableau cumulatif (26) |
| 26, 68, 69 | De nouveau on additionne le troisième élément du tableau original (1), et le dernier élément de notre tableau cumulatif (68). On utilise le dernier élément du tableau cumulatif pour éviter justement de devoir reparcourir les deux premiers éléments pour les additionner (puisque la deuxième case du tableau cumulatif contient déjà ce résultat, on l'utilise afin d'avoir l'addition des trois premiers éléments) |
| 26, 68, 69, 158 | On continue la création de notre tableau cumulatif |
| 26, 68, 69, 158, 161 | Idem |
| 26, 68, 69, 158, 161, 168 | On arrive au dernier élément, notre tableau cumulatif est terminé |

*2ème étape* : répondre aux questions grâce au tableau cumulatif


## Implémentation

## Tableau cumulatif 2D

## Conclusion
