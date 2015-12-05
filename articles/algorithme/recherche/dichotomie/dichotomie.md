Dichotomie
==========
algo/recherche

Publié le :28/06/2014  
*Modifié le :*

## Introduction

La dichotomie (*binary search* en anglais) est un algorithme très utilisé pour rechercher un élément dans un ensemble trié rapidement, il peut s’appliquer dans de nombreux problèmes.

## Principe de l’algorithme

La dichotomie est un moyen très efficace de chercher un élément précis dans un ensemble d’élément **trié**. Elle utilise la méthode de "diviser pour régner" sur l’ensemble pour rechercher l’élément voulu rapidement.

La méthode de « diviser pour régner » consiste à diviser un gros problème en deux plus petits sous-problèmes, eux-mêmes divisibles en sous-sous-problèmes jusqu’à arriver à un seul petit problème facile et rapide à résoudre.

Prenons un cas particulier où l’on utilise la dichotomie : on cherche un élément dans un tableau d’entier trié. On compare l’élément à chercher avec l’élément au milieu du tableau, si l’élément central est supérieur on sait que l’on continuera de chercher dans le premier sous-tableau (du début du tableau jusqu’au milieu), sinon si il est inférieur on sait que l’on cherchera dans le deuxième sous-tableau (du milieu jusqu’à la fin du tableau). On répète cette opération jusqu’à se retrouver avec un sous-tableau contenant un seul élément : l’élément que l’on recherche. Vous voyez qu’il est donc fondamental que le tableau soit trié pour l’algorithme fonctionne correctement.

La dichotomie va donc comparer l’élément situé au milieu de l’ensemble trié et l’élément que l’on souhaite chercher, puis va décider dans quelle sous-partie de l’ensemble continuer la recherche. Et ainsi de suite jusqu’à trouver notre élément. La dichotomie affine donc l’espace de recherche de moitié à chaque comparaison, réduisant ainsi au final le nombre comparaisons effectuées.

Encore une fois, la dichotomie est très utile sur des grandes entrées, imaginez avoir une base de données composées de milliards de milliards de nombres et d’avoir la parcourir à chaque recherche serait bien trop long. Mais même sur de plus petits exemples, on peut voir la différence entre une recherche banale (parcourant tous les éléments jusqu’à trouver celui qu’on cherche) et une recherche dichotomique.

## Exemple

Nous avons un tableau d’entier trié : 1, 8, 15, 42, 99, 160, 380, 512, 678, 952, 1304, 7662. Et nous souhaitons trouver la valeur 512. Utilisons la dichotomie pour trouver 512 dans notre tableau efficacement :

On commence donc par comparer l’élément centrale du tableau avec l’élément que l’on souhaite trouver :

1, 8, 15, 42, 99, **160**, 380, 512, 678, 952, 1304, 7662 : Ici l’élément situé au milieu du tableau est 160, or 160 est inférieur à 512, et puisque le tableau est trié, on déduit donc que 512 ne se trouve pas à gauche de 160 (inclus), on continue donc de chercher dans le sous-tableau constitué des éléments 380, 512, 678, 952, 1304, 7662.

~~1, 8, 15, 42, 99, 160~~ | 380, 512, **678**, 952, 1304, 7662 : Ici l’élément situé au milieu du sous-tableau est 678, or 678 est supérieur à 512, on déduit donc que 512 ne se trouve pas à droite de 678 (inclus), on continue donc de chercher dans le sous-sous-tableau constitué des éléments 380, 512.

~~1, 8, 15, 42, 99, 160~~ | **380**, 512 | ~~678, 952, 1304, 7662~~ : Ici l’élément situé au milieu du sous-sous-tableau est 380, or 380 est inférieur à 512, on déduit donc 512 ne se trouve pas à droite de 380 (inclus), on continue donc de chercher dans le sous-sous-sous-tableau constitué de l’élément 512.

~~1, 8, 15, 42, 99, 160~~ | ~~380~~ | **512** | ~~678, 952, 1304, 7662~~ : Ici il ne reste plus qu’un seul élément, on a donc trouvé notre élément : 512.


Vous voyez donc qu’il nous a fallu trois comparaisons seulement pour trouver le nombre 512 dans notre tableau trié.

## Pseudo-code

Le pseudo-code de la dichotomie :

```
Soit N la taille du tableau à trier

dichotomie(Tableau, N, Recherche) :

début -> 0
fin -> N - 1

Faire

milieu -> (début + fin) / 2

Si l'élément milieu de Tableau est inférieur à Recherche
début -> milieu + 1
Sinon si l'élément milieu de Tableau est supérieur à Recherche
fin -> milieu - 1
Sinon si l'élément milieu de Tableau est égal à Recherche
Retourner milieu

Tant que l'élément milieu de Tableau est différent de Recherche
```

Dans ce pseudo-code, j’ai choisit de retourner la position de l’élément que l’on cherche dans le tableau, on pourrait aussi renvoyer 1 si l’élément est bien dans le tableau et 0 sinon.

## Complexité

La dichotomie peut être représenté comme un [arbre](/pages/algo/structure/arbre.html) créé à partir du tableau. L’algorithme parcourt le chemin lui permettant d’arriver à l’élément recherché :

1, 8, 15, 42, 99, 160, 380, 512, 678, 952, 1304, 7662

/  \
/    \
/      \

1, 8, 15, 42, 99, 160       380, 512, 678, 952, 1304, 7662

/ \                              / \
/   \                            /   \
/     \                          /     \

1, 8, 15      42, 99, 160     380, 512, 678     952, 1304, 7662

/ \             / \              / \                / \
/   \           /   \            /   \              /   \
/     \         /     \          /     \            /     \

1, 8     15    42, 99     160   380, 512   678    952, 1304   7662

|  |      |    |    |      |     |    |     |      |    |       |
|  |      |    |    |      |     |    |     |      |    |       |
|  |      |    |    |      |     |    |     |      |    |       |
1  8     15    42  99     160   380  512   678    952  1304    7662

Ici, vous pouvez voir que pour arriver à l’élément 512, on suit bien les mêmes étapes que j’ai expliquées dans la partie **Exemple**.

La complexité dépend donc de la hauteur de l’arbre comme vous l’avez vu dans le schéma juste au dessus. Elle est donc en *O(log(N))*, ce qui est extrêmement rapide.

## Implémentation

Le lien vers une implémentation itérative en C d’une recherche dichotomique  :

main.c : <http://git.io/vtzIf>

Ainsi que le lien vers une implémentation récursive en C :

main.c : <http://git.io/vtzIk>

## Conclusion

La dichotomie est donc un algorithme de recherche efficace, rapide, et facile à implémenter.
