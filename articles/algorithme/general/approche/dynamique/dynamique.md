Algorithme dynamique
====================
algo/general/approche

Publié le : 02/04/2016  
*Modifié le : 02/04/2016*

## Introduction

Le principe du [diviser pour régner](https://en.wikipedia.org/wiki/Divide_and_conquer_algorithms) est assez commun en algorithmique, et celui-ci repose sur une idée simple :

- Découper un problème compliqué en sous-problème plus simple (de manière [récursive](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29)).
- Résoudre les sous-problèmes et combiner leurs solutions pour résoudre le problème initial.

Il y a de nombreux domaines dans laquelle cette méthode excelle ([dichotomie](/algo/recherche/dichotomie.html), [tri fusion](/algo/tri/tri_fusion.html), [tri rapide](/algo/tri/tri_rapide.html), etc.), mais là où elle atteint ses limites c'est lorsque les sous-problèmes rencontrés ne sont pas forcément unique. Dans ce cas, on en vient à recalculer beaucoup de sous-problèmes qu'on a déjà résolus, ce qui rend notre programme très lent, voir inutilisable. 

La programmation dynamique est un moyen de pallier ce problème d'efficacité du programme, en offrant une solution simple et facile à mettre en place.

## Principe

La programmation dynamique (*dynamic programming* ou encore *dynamic optimization* en anglais) est une technique d'optimisation d'un algorithme visant à éviter de recalculer des sous-problèmes en stockant les résultats en mémoire. L'idée est simple, mais le gain sur la complexité en temps peut être considérable, et cette technique est très largement utilisée dans de nombreux algorithmes.

En réalité, vous utilisez ce principe très souvent sans même vous en rendre compte. Si je vous demande de me calculer le résultat de "1 + 1 + 1 + 1 + 1 + 1 + 1 + 1" vous mettrez un certain temps afin de trouver la somme des termes, mais si je rajoute "+ 1" à la fin de ce calcul, vous pouvez me répondre instantanément le résultat de la nouvelle expression. Vous avez naturellement stocké en mémoire le résultat de l'expression originale, que vous avez ensuite réutilisé pour trouver le résultat d'une nouvelle expression sans avoir besoin de refaire le calcul en entier.

## Exemple

Voici un exemple de fonction en C calculant le `n`ième terme de la [suite de Fibonacci](https://en.wikipedia.org/wiki/Fibonacci_sequence):

[INSERT]
fibonacci.c

J'utilise le type `unsigned long long` car on risque d'avoir des nombres très grands à manipuler. Maintenant, testons l'efficacité du programme sur différentes entrées :

| Entrée | Temps d'exécution du programme |
| ------ | ------------------------------ |
| 20     | 0.00s                          |
| 30     | 0.02s                          |
| 40     | 1.47s                          |
| 45     | 16.73s                         |
| 50     | 186.12s (ou 3min)              |
| 55     | 2080.48s (ou 34min)            |

On remarque que le temps nécessaire au programme afin de calculer le résultat croît **très rapidement**, et cela est dû au fait que notre implémentation a une complexité en temps [**exponentielle**](https://en.wikipedia.org/wiki/Time_complexity#Exponential_time).

![Représentation graphique de la croissance exponentielle](//static.napnac.ga/img/algo/general/approche/dynamique/representation_exp.png)

La lenteur du programme vient donc du nombre d'appels récursifs qui est exponentiel. Prenons l'exemple du calcul du 5ème terme de la suite :

![Appels récursifs effectués pour calculer le 5ème terme](//static.napnac.ga/img/algo/general/approche/dynamique/appels_fib5.png)

Plusieurs appels sont répétés inutilement ici (`f(2)` et `f(3)` notamment), et ce nombre de répétitions ne fait qu'augmenter au fur et à mesure que l'entrée s'agrandit. Cela résulte donc en une implémentation **extrêmement lente**.

Voici le même programme, mais dynamisé cette fois ci :

[INSERT]
fibonacci_dyn.c

On a désormais un tableau qui va retenir les résultats qu'on a déjà calculé pour éviter de faire des appels récursifs supplémentaires qui sont finalement inutiles. Ce tableau est initialisé avec la valeur `PAS_CALCULE` pour différencier le cas où on a déjà calculé le résultat et celui où on ne l'a pas encore fait (j'utilise -1 car je sais que tous les termes de cette suite sont supérieurs ou égaux à 0), puis dans notre fonction `fibonacci` on rajoute un test pour voir si on connaît le résultat pour le `n`ème terme de la suite, si c'est le cas on le retourne directement, sinon on le calcule et on le stocke dans le tableau.

Cette simple amélioration a un impact énorme sur notre programme :

| Entrée | Temps d'exécution du programme |
| ------ | ------------------------------ |
| 100    | 0.00s                          |
| 1000   | 0.00s                          |
| 10000  | 0.00s                          |
| 100000 | 0.01s                          |

*Les résultats du programme face à ces entrées ne sont pas corrects car ils sont tellement immenses qu'on ne peut pas les stocker dans nos simples variables.*

On est désormais capable de trouver le résultat sur des entrées bien plus grandes en moins d'une seconde (ce qui aurait pris une *infinité* de temps sur notre ancien programme). Notre implémentation n'a pas de complexité exponentielle, et elle est donc bien plus efficace que l'originale.

Pour bien comparer, voici l'exemple du calcul du 5ème terme, mais version dynamique :

![Appels récursifs effectués pour calculer le 5ème terme de manière dynamique](//static.napnac.ga/img/algo/general/approche/dynamique/appels_fib5_dynamique.png)

On calcule uniquement ce dont on a besoin une fois, et on le réutilise ensuite (les nœuds bleus représentent les nœuds déjà calculés pour lesquels on connait directement le résultat).

## Optimisation

La programmation dynamique est un excellent exemple de compromis entre **complexité en temps** et **complexité en mémoire** d'un algorithme.

Il peut assez souvent arriver que notre problème nécessite un tableau gigantesque pour avoir un algorithme dynamique. Mais dans la plupart des cas, on peut optimiser la complexité en mémoire du nouvel algorithme, en utilisant uniquement des parties du tableau dont on a réellement besoin.

- transformation en algo itératif + opti mémoire tableau

## Conclusion

Dynamiser un algorithme peut donc drastiquement changer sa complexité en temps, et cette technique d'optimisation peut s'appliquer à la plupart des algorithmes récursifs qui cherchent une **solution optimale** parmi beaucoup d'autres.

- ex algo dyn
- liste exos dyn
