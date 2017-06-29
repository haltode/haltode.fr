---
path: algo/general/approche
title: Algorithme dynamique
published: 03/04/2016
modified: 29/04/2016
---

## Introduction

Le principe du [diviser pour régner](https://en.wikipedia.org/wiki/Divide_and_conquer_algorithms) est assez commun en algorithmique, et celui-ci repose sur une idée simple :

- Découper un problème compliqué en sous-problème plus simple (de manière [récursive](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29)).
- Résoudre les sous-problèmes et combiner leurs solutions pour résoudre le problème initial.

Il y a de nombreux domaines dans laquelle cette méthode excelle ([dichotomie](/algo/recherche/dichotomie.html), [tri fusion](/algo/tri/tri_fusion.html), [tri rapide](/algo/tri/tri_rapide.html), etc.), mais là où elle atteint ses limites c'est lorsque les sous-problèmes rencontrés ne sont pas uniques. Dans ce cas, on en vient à recalculer beaucoup de sous-problèmes que l'on a déjà résolus, ce qui rend notre programme très lent, voire inutilisable. 

La programmation dynamique est un moyen de pallier ce problème d'efficacité du programme, en offrant une solution simple et facile à mettre en place.

## Principe

La programmation dynamique (*dynamic programming* ou encore *dynamic optimization* en anglais) est une technique d'optimisation d'un algorithme visant à éviter de recalculer des sous-problèmes en stockant les résultats en mémoire. L'idée est simple, mais le gain sur la complexité en temps peut être considérable, et cette technique est très largement utilisée dans de nombreux algorithmes.

En réalité, vous utilisez ce principe très souvent sans même vous en rendre compte. Si je vous demande de me calculer le résultat de "1 + 1 + 1 + 1 + 1 + 1 + 1 + 1" vous mettrez un certain temps afin de trouver la somme des termes, mais si je rajoute "+ 1" à la fin de ce calcul, vous pouvez me répondre instantanément le résultat de la nouvelle expression. Vous avez naturellement stocké en mémoire le résultat de l'expression originale, que vous avez ensuite réutilisé pour trouver le résultat d'une nouvelle expression sans avoir besoin de refaire le calcul en entier.

## Exemple

Voici un exemple de fonction en C calculant le `n`ième terme de la [suite de Fibonacci](https://en.wikipedia.org/wiki/Fibonacci_sequence):

```c
#include <stdio.h>

unsigned long long fibonacci(int n)
{
   if(n <= 1)
      return n;
   return fibonacci(n - 1) + fibonacci(n - 2);
}

int main(void)
{
   int n;
   
   scanf("%d\n", &n);
   printf("%lld\n", fibonacci(n));

   return 0;
}
```

J'utilise le type `unsigned long long` car on risque d'avoir des nombres très grands à manipuler. Maintenant, testons l'efficacité du programme sur différentes entrées (les résultats varient bien entendu en fonction de l'ordinateur que vous utilisez) :

| Entrée | Temps d'exécution du programme |
| ------ | ------------------------------ |
| 20     | 0.00s                          |
| 30     | 0.02s                          |
| 40     | 1.47s                          |
| 45     | 16.73s                         |
| 50     | 186.12s (ou 3min)              |
| 55     | 2080.48s (ou 34min)            |

On remarque que le temps nécessaire au programme afin de calculer le résultat croît **très rapidement**, et cela est dû au fait que notre implémentation a une complexité en temps [**exponentielle**](https://en.wikipedia.org/wiki/Time_complexity#Exponential_time).

![Représentation graphique de la croissance exponentielle](/img/algo/general/approche/dynamique/representation_exp.png)

La lenteur du programme vient donc du nombre d'appels récursifs qui est exponentiel. Prenons l'exemple du calcul du 5ème terme de la suite :

![Appels récursifs effectués pour calculer le 5ème terme](/img/algo/general/approche/dynamique/appels_fib5.png)

Plusieurs appels sont répétés inutilement ici (`f(2)` et `f(3)` notamment), et ce nombre de répétitions ne fait qu'augmenter au fur et à mesure que l'entrée s'agrandit. Cela résulte donc en une implémentation **extrêmement lente**.

Voici le même programme, mais dynamisé cette fois ci :

```c
#include <stdio.h>

#define N_MAX 100000
#define PAS_CALCULE -1

long long resultat[N_MAX + 1];

long long fibonacci(int n)
{
   if(n <= 1)
      return n;
   if(resultat[n] != PAS_CALCULE)
      return resultat[n];

   resultat[n] = fibonacci(n - 1) + fibonacci(n - 2);
   return resultat[n];
}

int main(void)
{
   int n;
   int iRes;
   
   scanf("%d\n", &n);

   for(iRes = 0; iRes <= n; ++iRes)
      resultat[iRes] = PAS_CALCULE;

   printf("%lld\n", fibonacci(n));

   return 0;
}
```

On a désormais un tableau qui va retenir les résultats qu'on a déjà calculés pour éviter de faire des appels récursifs supplémentaires qui sont finalement inutiles. Ce tableau est initialisé avec la valeur `PAS_CALCULE` pour différencier le cas où on a déjà calculé le résultat et celui où on ne l'a pas encore fait (j'utilise -1 car je sais que tous les termes de cette suite sont supérieurs ou égaux à 0, il faut donc faire attention à utiliser `long long` et non pas `unsigned long long` ici), puis dans notre fonction `fibonacci` on rajoute un test pour voir si on connaît le résultat pour le `n`ème terme de la suite, si c'est le cas on le retourne directement, sinon on le calcule et on le stocke dans le tableau.

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

![Appels récursifs effectués pour calculer le 5ème terme de manière dynamique](/img/algo/general/approche/dynamique/appels_fib5_dynamique.png)

On calcule uniquement ce dont on a besoin une fois, et on le réutilise ensuite (les nœuds bleus représentent les nœuds déjà calculés pour lesquels on connaît directement le résultat).

## Optimisation

La programmation dynamique est un excellent exemple de compromis entre **complexité en temps** et **complexité en mémoire** d'un algorithme. En effet, on sacrifie de la mémoire pour stocker notre tableau qui retiendra des résultats, afin de ne pas recalculer lesdits résultats plusieurs fois et ainsi sauver du temps. Il faut donc bien prendre en compte les deux facteurs du temps et de la mémoire car dans certains cas (et en fonction des ressources à disposition), on préférera privilégier l'un par rapport à l'autre.

Cependant, il est parfois possible d'optimiser l'espace mémoire utilisé par notre algorithme dynamique, résultant en un algorithme ayant une complexité en temps et en mémoire extrêmement intéressante. Pour cela, il va falloir changer notre manière de programmer notre algorithme dynamique. L'approche **récursive** qu'on avait précédemment utilisée était dite **descendante** dans le sens où on divise notre gros problème en sous-problème jusqu'à arriver à un problème de base à résoudre. Une autre manière de voir le problème est de façon **itérative** en partant d'un problème simple pour le complexifier au fur et à mesure qu'on avance, c'est une méthode dite **ascendante**. Et dans notre cas, cette dernière peut nous offrir des avantages énormes en mémoire car en rendant notre problème de plus en plus compliqué (jusqu'à arriver au problème initial), on peut se débarrasser des problèmes très simples et garder uniquement ceux nécessaire à la construction du plus gros problème. Il est impossible de faire ça avec l'approche descendante, car cette méthode a besoin à tout instant des sous-problèmes pour décomposer le problème initial puis pour le résoudre.

![Comparaison des deux méthodes](/img/algo/general/approche/dynamique/comparaison_methodes.png)

J'ai représenté deux tableaux en 2D fictifs représentant le stockage des calculs pour notre algorithme dynamique. À gauche, la méthode descendante, qui dépend donc de tous les éléments précédents pour former le résultat final. Et à droite, la méthode ascendante, qui elle ne dépend pas toujours de tous les résultats précédents (ici le résultat nécessite uniquement les deux derniers), on peut donc économiser une bonne partie du tableau qui n'est plus utile de garder.

Si l'on reprend notre exemple de la suite de Fibonacci, quand on a calculé disons le 5ème terme, il est tout à fait inutile de garder en mémoire les termes 2 et 3 car le 6ème terme nécessitera uniquement le 5ème et le 4ème termes. Ceci signifie qu'à tout instant dans notre suite, on a uniquement besoin des deux derniers termes pour construire le suivant.

```c
#include <stdio.h>

#define PAS_CALCULE -1

unsigned long long fibonacci(int n)
{
   unsigned long long prochain, actuel, dernier;
   int iTerme;

   actuel = 1;
   dernier = 0;

   for(iTerme = 2; iTerme <= n; ++iTerme) {
      prochain = actuel + dernier;

      dernier = actuel;
      actuel = prochain;
   }

   return actuel;
}

int main(void)
{
   int n;
   
   scanf("%d\n", &n);
   if(n == 0)
      printf("0\n");
   else
      printf("%lld\n", fibonacci(n));

   return 0;
}
```

Notre programme est désormais écrit de manière itérative (avec une simple boucle), ce qui fait qu'on a uniquement besoin des deux derniers termes `actuel` et `dernier`, afin de calculer `prochain`. On n'utilise pas de tableau ici, mais dans le cas où il faudrait plus que deux précédents éléments pour calculer le prochain, un tableau serait sans doute plus judicieux.

## Conseils d'implémentation

Quand on débute avec les algorithmes dynamiques, il est toujours préférable de procéder par étapes lorsqu'on essaie de coder un nouvel algorithme :

- Coder la version récursive naïve : cela permet de bien établir la récursion qui sera l'élément central de l'algorithme.
- Dynamiser la solution : si l'étape précédente est correctement réalisée, il suffit de créer un tableau (attention à bien choisir les bons paramètres pour ce dernier), d'ajouter une condition en cas de "déjà vu", et enfin de modifier la récursion afin de prendre en compte notre tableau.
- Coder la version itérative : parfois il est nécessaire d'utiliser cette approche pour des raisons de mémoire et d'efficacité.

Une fois réellement à l'aise, il est possible de sauter la première étape, pour aller directement à l'approche qu'on préfère (récursive ou itérative). Attention tout de même à ne pas aller trop vite au risque de perdre énormément de temps. Si vous choisissez la version récursive par exemple, il est quasiment tout le temps préférable de passer par la méthode naïve en premier pour vérifier rapidement la validité de votre algorithme. Dynamiser cette solution ne prend que quelques secondes, alors que repartir de zéro à cause d'un mauvais départ vous prendra bien plus de temps.

Il arrive aussi d'avoir du mal à trouver la version dynamique de notre algorithme naïf, et c'est souvent à cause de la récursion qui est mal définie. Pour s'aider, on peut se dire que de manière générale, les paramètres de la fonction sont les **situations** (c'est-à-dire les paramètres qu'on utilisera en indice de notre tableau), et la valeur de retour sera l'**information** (ce qu'on stocke dans notre tableau).

## Conclusion

Dynamiser un algorithme peut donc radicalement changer sa complexité en temps, et cette technique d'optimisation peut s'appliquer à la plupart des algorithmes récursifs qui cherchent une **solution optimale** parmi beaucoup d'autres. On retrouve des algorithmes dynamiques de partout et dans tous les domaines car cette optimisation s'applique à de très nombreux problèmes.

Même si l'idée de la programmation dynamique est très simple, programmer un algorithme dynamique peut être bien plus compliqué. Le seul moyen d'être vraiment à l'aise avec cette optimisation est de pratiquement **énormément**, sur des problèmes variés. Cette introduction sert uniquement d'explication brève sur le sujet, mais voici d'autres liens pouvant vous intéresser si vous souhaitez réellement en apprendre plus (il y a des **tonnes** d'informations sur la programmation dynamique en ligne, donc n'hésitez pas à faire plus de recherches si nécessaire) :

- Cours/tutoriel

    - [Tutorial for Dynamic Programming](https://www.codechef.com/wiki/tutorial-dynamic-programming)
    - [Are there any good resources or tutorials for dynamic programming besides the TopCoder tutorial?](https://www.quora.com/Are-there-any-good-resources-or-tutorials-for-dynamic-programming-besides-the-TopCoder-tutorial/answer/Michal-Danil%C3%A1k)
    - [Good examples, articles, books for understanding dynamic programming](http://stackoverflow.com/questions/4278188/good-examples-articles-books-for-understanding-dynamic-programming)
    - (avancé) [Dynamic Programming Optimizations](http://codeforces.com/blog/entry/8219)

- Exercices

    - [Dynamic Programming Type](http://codeforces.com/blog/entry/325)
    - [Codeforces - Dynamic Programming tag](http://codeforces.com/problemset/tags/dp)
    - [Codechef - Dynamic Programming tag](https://www.codechef.com/tags/problems/dp)
    - [SPOJ - Dynamic Programming Problems List](http://apps.topcoder.com/forums/;jsessionid=C684F032169B7439C8012AAB6BA2018C?module=Thread&threadID=674592)
    - [Topcoder - Dynamic Programming tag](https://community.topcoder.com/tc?module=ProblemArchive&sr=&er=&sc=&sd=&class=&cat=Dynamic+Programming&div1l=&div2l=&mind1s=&mind2s=&maxd1s=&maxd2s=&wr=)

L'idéal serait de commencer par des problèmes vraiment basiques, et de monter progressivement en complexité une fois que vous vous sentez à l'aise, pour bien appréhender cette technique d'optimisation.

Ce n'est pas une approche qu'on peut maîtriser facilement, car il a toujours des optimisations ou différentes manières d'approcher un problème de programmation dynamique. Mais ce qui est sûr, c'est que plus vous pratiquerez, meilleur vous serez.
