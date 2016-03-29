Algorithme dynamique
====================
algo/general/approche

Publié le : 29/03/2016  
*Modifié le : 29/03/2016*

## Introduction

Le principe du [diviser pour régner](https://en.wikipedia.org/wiki/Divide_and_conquer_algorithms) est assez commun en algorithmique, et celui-ci repose sur une idée simple :

- Découper un problème en sous-problème plus simple (de manière [récursive](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29)).
- Résoudre les sous-problèmes et combiner leurs solutions pour résoudre le problème initial.

Il y a de nombreux domaines dans laquelle cette méthode excelle ([dichotomie](/algo/recherche/dichotomie.html), [tri fusion](/algo/tri/tri_fusion.html), [tri rapide](/algo/tri/tri_rapide.html), etc.), mais là où elle atteint ses limites c'est lorsque les sous-problèmes rencontrés ne sont pas forcément unique. Dans ce cas, on en vient à recalculer beaucoup de sous-problèmes qu'on a déjà résolus, ce qui rend notre programme très lent, voir inutilisable. 

La programmation dynamique est un moyen de pallier ce problème d'efficacité du programme, en offrant une solution simple et facile à mettre en place.

## Principe

La programmation dynamique (*dynamic programming* ou encore *dynamic optimization* en anglais) est une technique d'optimisation d'un algorithme visant à éviter de recalculer des sous-problèmes en stockant les résultats en mémoire. L'idée est simple, mais le gain sur la complexité en temps peut être considérable, et cette technique est très largement utilisée dans de nombreux algorithmes.

En réalité, vous utilisez ce principe très souvent sans même vous en rendre compte. Si je vous demande de me calculer le résultat de "1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1" vous mettrez un certain temps afin de trouver la somme des termes, mais si je rajoute "+ 1" à la fin de ce calcul, vous pouvez me répondre instantanément le résultat de la nouvelle expression. Vous avez naturellement stocké en mémoire le résultat de l'expression originale, que vous avez ensuite réutilisé pour trouver le résultat d'une nouvelle expression sans avoir besoin de refaire le calcul en entier.

## Exemple

Voici un exemple de fonction en C calculant le `n`ième terme de la [suite de Fibonacci](https://en.wikipedia.org/wiki/Fibonacci_sequence):

[INSERT]
fibonacci.c

J'utilise le type `unsigned long long` car on risque d'avoir des nombres très grands à manipuler. Maintenant, testons l'efficacité du programme sur différentes entrées (20, 30, 40, 45, 50, 55) :

```bash
$ time ./fibonacci
20
6765
./fibonacci  0,00s user 0,00s system 0% cpu 1,367 total

$ time ./fibonacci
30
832040
./fibonacci  0,02s user 0,00s system 1% cpu 1,221 total

$ time ./fibonacci
40
102334155
./fibonacci  1,47s user 0,00s system 52% cpu 2,789 total

$ time ./fibonacci
45
1134903170
./fibonacci  16,73s user 0,04s system 87% cpu 19,079 total

$ time ./fibonacci
50
12586269025
./fibonacci  186,12s user 0,12s system 98% cpu 3:09,48 total

$ time ./fibonacci
55
139583862445
./fibonacci  2080,48s user 2,38s system 98% cpu 35:19,94 total
```

On remarque que le temps nécessaire au programme afin de calculer le résultat croît **très rapidement**, et cela est dû au fait que notre implémentation a une complexité **exponentielle**.

![Représentation graphique de la fonction exponentielle](//static.napnac.ga/img/algo/general/approche/dynamique/representation_exp.png)

La raison de cette lenteur est que le nombre d'appels récursifs est exponentiel, prenons l'exemple du calcul du 5ème terme de la suite :

```
fibonacci(5) = 5 :
   fibonacci(4) + fibonacci(3)

   fibonacci(4) = 3 :
      fibonacci(3) + fibonacci(2)

      fibonacci(3) = 2 :
         fibonacci(2) + fibonacci(1)

         fibonacci(2) = 1 :
            fibonacci(1) + fibonacci(0)

            fibonacci(1) = 1
            fibonacci(0) = 0

         fibonacci(1) = 1
      fibonacci(2) = 1 :
         fibonacci(1) + fibonacci(0)

         fibonacci(1) = 1
         fibonacci(0) = 0

   fibonacci(3) = 2 :
      fibonacci(2) + fibonacci(1)

      fibonacci(2) = 1 :
         fibonacci(1) + fibonacci(0)

         fibonacci(1) = 1
         fibonacci(0) = 0

      fibonacci(1) = 1
```

Plusieurs appels sont répétés inutilement ici (`fibonacci(2)` et `fibonacci(3)` notamment), et ce nombre de répétitions ne fait qu'augmenter au fur et à mesure que l'entrée s'agrandit. Cela résulte donc en une implémentation **extrêmement lente**.

Voici le même programme, mais dynamisé cette fois ci :

[INSERT]
fibonacci_dyn.c

On a désormais un tableau qui va retenir les résultats qu'on a déjà calculé pour éviter de faire des appels récursifs supplémentaires qui sont finalement inutiles. Ce tableau est initialisé avec la valeur `PAS_CALCULE` pour différencier le cas où on a déjà calculé le résultat et celui où on ne l'a pas encore fait, puis dans notre fonction `fibonacci` on rajoute un test pour voir si on connaît le résultat pour le `n`ème terme de la suite, si c'est le cas on le retourne directement, sinon on le calcule et on le stocke dans le tableau.

Cette simple amélioration a un impact énorme sur notre programme :

```bash
$ time ./fibonacci_dyn
100
3736710778780434371
./fibonacci_dyn  0,00s user 0,00s system 0% cpu 38,304 total

$ time ./fibonacci_dyn
1000
817770325994397771
./fibonacci_dyn  0,00s user 0,00s system 0% cpu 2,635 total

$ time ./fibonacci_dyn
10000
-2872092127636481573
./fibonacci_dyn  0,00s user 0,00s system 0% cpu 2,314 total

$ time ./fibonacci_dyn
100000
2754320626097736315
./fibonacci_dyn  0,01s user 0,01s system 0% cpu 5,043 total
```

*Les résultats ne sont pas corrects car ils sont tellement immenses qu'on ne peut pas les stocker dans nos simples variables.*

On est désormais capable de trouver le résultat sur des entrées bien plus grandes en moins d'une seconde (ce qui aurait pris une *infinité* de temps sur notre ancien programme). Notre implémentation n'a pas de complexité exponentielle, et elle est donc bien plus efficace que l'originale.

Pour bien comparer, voici l'exemple du calcul du 5ème terme, mais version dynamisé :

```
fibonacci(5) = 5 :
   fibonacci(4) + fibonacci(3)

   fibonacci(4) = 3 :
      fibonacci(3) + fibonacci(2)

      fibonacci(3) = 2 :
         fibonacci(2) + fibonacci(1)

         fibonacci(2) = 1 :
            fibonacci(1) + fibonacci(0)

            fibonacci(1) = 1
            fibonacci(0) = 0

         fibonacci(1) = 1
      fibonacci(2) = 1 (DEJA CALCULE)

   fibonacci(3) = 2 (DEJA CALCULE)
```

On calcule uniquement ce dont on a besoin une fois, et on le réutilise ensuite.

## Optimisation

La programmation dynamique est un excellent exemple de compromis entre **complexité en temps** et **complexité en mémoire** d'un algorithme.

Il peut assez souvent arriver que notre problème nécessite un tableau gigantesque pour avoir un algorithme dynamique. Mais dans la plupart des cas, on peut optimiser la complexité en mémoire du nouvel algorithme, en utilisant uniquement des parties du tableau dont on a réellement besoin.

- transformation en algo itératif + opti mémoire tableau

## Conclusion

Dynamiser un algorithme peut donc drastiquement changer sa complexité en temps, et cette technique d'optimisation peut s'appliquer à la plupart des algorithmes récursifs qui cherchent une **solution optimale** parmi beaucoup d'autres.

- ex algo dyn
- liste exos dyn
