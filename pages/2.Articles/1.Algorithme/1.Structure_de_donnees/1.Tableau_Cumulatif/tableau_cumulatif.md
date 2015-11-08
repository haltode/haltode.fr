Tableau cumulatif
=================
algo/structure

Publié le :   
*Modifié le :*

## Introduction

Je vous donne un tableau possédant des milliards de milliards d'éléments, et je vous pose des milliards de questions de la forme : Quelle est la somme des éléments compris entre l'indice *i* et *j* du tableau (avec *i < j*) ? La première idée d'algorithme naïf que l'on peut avoir, est de parcourir pour chaque question les éléments situés entre les indices donnés, et d'augmenter une variable `somme` au fur et à mesure du parcours.

Cependant nos parcours sont très nombreux, et notre solution bien trop longue dans le cas extrême donné. Il nous faut donc une solution plus efficace, nous permettant de faire moins de parcours inutiles afin de raccourcir notre temps d'exécution : le tableau cumulatif.

## Principe du tableau cumulatif

Dans notre algorithme naïf, on passe plusieurs fois et très souvent sur de mêmes éléments, on peut aussi parcourir le tableau en entier à de multiples occasions, mais lors de ces parcours on n'utilise aucune des informations récoltées autrement que pour répondre à une seule question parmi des milliards.

L'idée du tableau cumulatif (*summed area table* en anglais) est de parcourir une seule fois notre tableau en entier, et d'utiliser les données récoltées pour pouvoir ensuite répondre à n'importe quel type de question à propos de somme d'éléments contigus.

On peut très simplement expliquer son principe grâce à la géométrie et aux intervalles :

![Explication géométrique du tableau cumulatif](/static/img/algo/structure/tableau_cumulatif/explication_geo.png)

La partie verte dans le premier rectangle représente la question posée, et on voit qu'on peut retrouver exactement la même partie en utilisant deux sous parties du rectangle commençant toutes les deux au même endroit. L'avantage de pouvoir décomposer n'importe quelle sous partie du rectangle en deux sous parties ayant un début commun, est qu'on réduit alors le nombre de possibilités de sous parties. En effet, avec un début et une fin variable le nombre d'intervalles possibles est d'environ *N²* (avec *N* la taille du rectangle), alors qu'avec un début d'intervalle fixe et uniquement une fin variable on arrive à *N* possibilités de sous parties.

Le principe du tableau cumulatif est justement de calculer tous les intervalles ayant un début fixe et une fin variable afin de pouvoir finalement connaitre rapidement n'importe quel intervalle de notre tableau d'éléments.

![Intervalles nécessaires pour répondre à toutes les questions](/static/img/algo/structure/tableau_cumulatif/representation_inter.png)

## Exemple

Afin de parfaitement comprendre comment utiliser un tableau cumulatif, prenons l'exemple de ce tableau : 26, 42, 1, 89, 3, 7.

*1ère étape* : créer notre tableau cumulatif

A partir de la suite de nombres, on va créer un tableau cumulatif qui contiendra pour chaque élément *i* l'élément du tableau original + l'élément *i - 1* de notre tableau cumulatif. Cela aura pour effet de créer un tableau contenant nos intervalles nécessaires, c'est-à-dire dans la première case l'élément 1, dans la deuxième case l'élément 1 + 2, dans la troisième case l'élément 1 + 2 + 3, etc.

| Tableau cumulatif         |
| :-----------------        |
| 26                        |
| 26, 68                    |
| 26, 68, 69                |
| 26, 68, 69, 158           |
| 26, 68, 69, 158, 161      |
| 26, 68, 69, 158, 161, 168 |

Notre premier élément est le même que celui du tableau original, et ensuite pour créer la prochaine case du tableau cumulatif on additionne celle qu'on vient de créer avec le prochain élément de notre tableau. Par exemple pour la troisième case du tableau cumulatif, on prend la deuxième case de ce tableau (68), que l'on additionne avec le troisième élément du tableau original (1), on obtient bien 69.

*2ème étape* : répondre aux questions grâce au tableau cumulatif

On a désormais notre tableau cumulatif 26, 68, 69, 158, 161, 168 que l'on va utiliser pour répondre à des questions du type quelle est la somme des éléments du tableau original entre deux indices *i* et *j* donnés. Il faut juste faire attention à une chose, c'est d'utiliser comme indice de début d'intervalle *i - 1* et non *i* car sinon notre premier élément ne sera pas inclus.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Début (*i*)     Fin (*j*)       Tableau                             Tableau cumulatif                            Réponse
-------------- --------------    ----------------------------------- -------------------------------------------  ------------------------------------------------------------------
      3              6           26, 42, **1**, **89**, **3**, **7** 26, **68**, 69, 158, 161, **168**            On soustrait l'élément *j* (6ème) et l'élément *i - 1* (2ème) soit 
                                                                                                                  168 - 68 = 100 (or 1 + 80 + 3 + 7 = 100) 

      1              4           **26**, **42**, **1**, **89**, 3, 7 26, 68, 69, **158**, 161, 168                Ici l'indice 0 correspond à un résultat de 0, on a donc 158 - 0 =
                                                                                                                  158 (or 26 + 42 + 1 + 89 = 158)

      4              5           26, 42, 1, **89**, **3**, 7         26, 68, **69**, 158, **161**, 168            161 - 69 = 92 (or 89 + 3 = 92) 

      1              6           **26**, **42**, **1**, **89**, **3  26, 68, 69, 158, 161, **168**                168 - 0 = 168 (or 26 + 42 + 1 + 89 + 3 + 7 = 168)
                                 **, **7**

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Complexité

Si l'on reprend notre énoncé dans l'introduction, on nous donne un tableau de taille *N*, et *M* questions du type : Quelle est la somme des éléments de *i* à *j* dans le tableau ? Notre solution naïve, dans le pire des cas, aura une complexité en *O(N \* M)* (lorsqu'on parcourt à chaque fois le tableau en entier, soit quand *i* = 0 et *j* = *N* pour chaque question). En revanche, notre tableau cumulatif revient à une complexité dans le pire des cas en *O(N)* car on parcourt une seule fois le tableau donné et pour répondre aux questions on a juste besoin d'accéder au tableau cumulatif (donc opération en *O(1)*).

## Implémentation

Une implémentation en C d'un tableau cumulatif et de son utilisation :

main.c :

## Variantes

### Autres opérations que la somme

Il est possible de répondre à des questions plus générales que sur la somme d'éléments, pour cela il suffit que notre opération possède un "inverse". Par exemple l'inverse de l'addition est la soustraction (c'est d'ailleurs ce qu'on utilise dans notre tableau cumulatif, l'addition pour le construire, et la soustraction pour répondre aux questions), et l'inverse de la multiplication est la division. Il est donc possible de modifier le comportement de notre tableau cumulatif pour prendre en compte le produit d'une suite de nombre, la soustraction d'éléments contigus, etc. Le principe reste exactement le même, il suffit juste de changer la manière de construire et de répondre aux questions en fonction de l'opération choisie.

### Tableau cumulatif 2D

Le tableau cumulatif ne se limite pas à une seule dimension, on peut l'utiliser sur deux dimensions :

![Exemple de représentation d'un tableau cumulatif 2D](/static/img/algo/structure/tableau_cumulatif/exemple_tableau2D.png)

Le principe est toujours le même encore une fois, mais il faut adapter nos fonctions qui construisent et répondent aux questions, pour qu'elles puissent fonctionner sur un tableau cumulatif en deux dimensions. Ce dernier schéma montre comment répondre à une question sur un tableau cumulatif 2D, mais il faut surtout l'initialiser correctement afin de pouvoir l'utiliser :

![Initialisation du tableau cumulatif 2D](/static/img/algo/structure/tableau_cumulatif/init_tableau2D.png)

## Conclusion

Le tableau cumulatif est donc une structure de données permettant de connaître la somme d'éléments contigus rapidement, mais ce dernier ne se limite pas à la somme on peut aussi l'utiliser pour la soustraction, la multiplication et la division, et on peut recréer cette structure en deux dimensions.
