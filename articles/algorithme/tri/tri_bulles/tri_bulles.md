Path: algo/tri  
Title: Tri à bulles  
Published: 29/04/2014  
Modified: 07/12/2015  

[TOC]

## Introduction

Le tri à bulles (*bubble sort* en anglais) est un algorithme de tri par comparaison très simple à comprendre et à implémenter, cependant c’est l’un des algorithmes de tri les plus inefficaces. En effet, il a une complexité en temps quadratique : $O(N^2)$. Cet algorithme est très peu utilisé à cause de sa complexité trop lente, mais c’est un bon exemple pour commencer à travailler sur des algorithmes de tri. Il faut noter que le tri à bulles est un algorithme de tri [stable](https://en.wikipedia.org/wiki/Sorting_algorithm#Stability) et [sur place](https://en.wikipedia.org/wiki/In-place_algorithm).

## Principe de l’algorithme

Le tri à bulles consiste à *remonter* les éléments du tableau à trier jusqu’à leurs places définitives, comme des bulles qui remontent d'un liquide (d’où son nom de tri à bulles). L’algorithme compare chaque paire d’élément du tableau, et les échange si besoin en fonction du tri (croissant ou décroissant).

## Exemple

Si l’on prend 8, 7, 1, 4, 6 comme suite de nombres, et que l’on utilise l’algorithme du tri à bulles pour trier cette suite dans l’ordre croissant, voici comment l’algorithme fonctionne :

*1er tour* :

**8**, **7**, 1, 4, 6  
8 > 7 donc on échange  
7, **8**, **1**, 4, 6  
8 > 1 donc on échange  
7, 1, **8**, **4**, 6  
8 > 4 donc on échange  
7, 1, 4, **8**, **6**  
8 > 6 donc on échange  

7, 1, 4, 6, 8

*2ème tour* :

**7**, **1**, 4, 6, 8  
7 > 1 donc on échange  
1, **7**, **4**, 6, 8  
7 > 4 donc on échange  
1, 4, **7**, **6**, 8  
7 > 6 donc on échange  
1, 4, 6, **7**, **8**  
7 < 8 donc on laisse  

1, 4, 6, 7, 8  

Notre algorithme va en réalité effectuer $N$ tours de boucle (avec $N$ étant la taille du tableau), sauf qu'ici au bout de deux tours notre tableau est déjà trié, l'algorithme va donc continuer de parcourir mais en ne changeant rien puisque chaque paire de nombre est bien placée.

Pour résumer l'idée de l'algorithme :

![Exemple de tri à bulles](/img/algo/tri/tri_bulles/exemple_tri.png)

Les éléments en bleu sont ceux qu'on compare à chaque itération, la partie verte représente la partie du tableau dont on est sûr qu'elle est triée. A chaque tour, on compare chaque paire dans la partie non triée du tableau, si la paire ne respecte pas l'ordre de tri (dans notre cas croissant), on échange les éléments et on continue.

## Pseudo-code

Voici le pseudo-code très simple de l’algorithme du tri à bulles :

```nohighlight
triBulles :

   Pour chaque élément
      Parcourir le tableau
         Echanger les paires adjacentes si nécessaire
```

## Complexité

Comme dit dans l’introduction, la complexité en temps de l’algorithme du tri à bulles est de $O(N^2)$, et on peut le démontrer simplement par le fait qu’il y a deux boucles imbriquées dans le pseudo-code :

- La première boucle parcourt $N$ tours.
- La deuxième boucle parcourt $N$ tours aussi.

On se retrouve donc avec $N^2$ tours, soit une complexité finale en $O(N^2)$.

## Implémentation

L’implémentation est aussi simple que le pseudo-code :

```c
#include <stdio.h>

#define TAILLE_MAX 1000

int tableau[TAILLE_MAX];
int taille;

void echanger(int index1, int index2)
{
   int temp;

   temp = tableau[index1];
   tableau[index1] = tableau[index2];
   tableau[index2] = temp;
}

void triBulles(void)
{
   int iElement, iTab;

   for(iElement = 0; iElement < taille; ++iElement)
      for(iTab = 0; iTab < taille - 1; ++iTab)
         if(tableau[iTab] > tableau[iTab + 1])
            echanger(iTab, iTab + 1);
}

int main(void)
{
   int iTab;

   scanf("%d\n", &taille);

   for(iTab = 0; iTab < taille; ++iTab)
      scanf("%d ", &tableau[iTab]);

   triBulles();

   for(iTab = 0; iTab < taille; ++iTab)
      printf("%d ", tableau[iTab]);
   printf("\n");

   return 0;
}
```

En entrée notre tableau :

```nohighlight
5
8 7 1 4 6
```

Et on obtient bien en sortie le tableau trié :

```nohighlight
1 4 6 7 8
```

## Améliorations et variantes

### Arrêter le tri quand c'est possible

On peut améliorer le tri à bulles en faisant en sorte qu’il s’arrête lorsque le tableau est trié, et qu’il ne parcourt pas d’autres tours inutilement. Pour cela, il suffit de vérifier si l’on effectue un échange ou pas dans le tour de boucle actuel, si ce n’est pas le cas le tableau est donc trié, on peut alors sortir de la boucle.

```nohighlight
Faire
   tableauPasTrié -> faux

   Pour chaque élément du tableau
      Si l'élément i est supérieur à l'élément i + 1
         Échanger les éléments
         tableauPasTrié -> vrai

Tant que tableauPasTrié est vrai
```

La complexité reste en $O(N^2)$, puisque les quelques tours de boucle que l'on a gagnés dans certains cas ne vont pas être assez conséquents pour influer sur la complexité en temps de l'algorithme.

### Tri à bulles bidirectionnel

Le tri à bulles bidirectionnel (*bidirectional bubble sort*) est une variante qui consiste à trier dans les deux directions (d’où son nom). Là où le tri à bulles parcourt seulement de gauche à droite (ou de droite à gauche, ça n’importe pas), le tri à bulles bidirectionnel parcourt de gauche à droite **et** de droite à gauche. Cela permet d’optimiser le tri de certains éléments comme les petits éléments situés en fin de tableau, le tri à bulles les ramène d’un seul emplacement à chaque tour de boucle, alors que le tri à bulles bidirectionnel les ramène en un seul tour.

Par exemple avec la suite de nombres suivante : 2, 3, 4, 5, 1. On voit que tous les éléments sont triés sauf le dernier, on va donc se concentrer dessus pour comparer les deux tris :

*Tri à bulles*


| Tour   | Tableau           |
| ------ | ---------         |
|        | 2, 3, 4, 5, **1** |
| 1er    | 2, 3, 4, **1**, 5 |
| 2ème   | 2, 3, **1**, 4, 5 |
| 3ème   | 2, **1**, 3, 4, 5 |
| 4ème   | **1**, 2, 3, 4, 5 |

*Tri à bulles bidirectionnel*

| Tour               | Tableau           |
| ------             | ---------         |
|                    | 2, 3, 4, 5, **1** |
| 1er                |                   |
| de gauche à droite | 2, 3, 4, **1**, 5 |
| de droite à gauche | **1**, 2, 3, 4, 5 |

Dans cet exemple, le tri à bulles bidirectionnel n’a besoin que d'un seul tour de boucle alors que le tri à bulles en a besoin de quatre.

Le pseudo-code du tri à bulles bidirectionnel :

```nohighlight
Faire
   tableauPasTrié -> faux

   Pour chaque élément du tableau (gauche à droite)
      Si l'élément i est supérieur à l'élément i + 1
         Échanger les éléments
         tableauPasTrié -> vrai

   Pour chaque élément du tableau (droite à gauche)
      Si l'élément i est inférieur à l'élément i - 1
         Échanger les éléments
         tableauPasTrié -> vrai

Tant que tableauPasTrié est vrai
```

Cette variante peut être encore optimisée, en retenant l’endroit où le dernier échange s’est effectué pour ne pas aller plus loin (car c’est inutile), cependant cet algorithme a toujours pour complexité $O(N^2)$.

### Tri à peigne

Une autre variante du tri à bulles appelée le tri à peigne (*comb sort* en anglais), permet à l’algorithme du tri à bulles d’être bien plus efficace et ainsi rivaliser avec des algorithmes plus performants comme le [tri rapide](/algo/tri/tri_rapide.html), le [tri fusion](/algo/tri/tri_fusion.html), ou encore le [tri par tas](/algo/tri/tri_tas.html). Cet algorithme va comparer des éléments du tableau à un certain intervalle au lieu de comparer les éléments voisins. En effet, cette technique permet d’éliminer le problème du petit élément situé à la fin du tableau qui remonte lentement jusqu’à sa place initiale, et souvent rend les comparaisons entre éléments plus judicieuses. Un intervalle optimal est initialisé avec une valeur de $N / 1.3$ (cette valeur est reconnue comme étant une des plus optimales pour ce tri), et à chaque tour on divise de nouveau par 1.3 l'intervalle tant qu'il est supérieur à 1.

```nohighlight
Faire
   tableauPasTrié -> faux
   intervalle -> intervalle / 1.3 (valeur entière)

   Si intervalle est inférieur à 1
      intervalle -> 1

   Pour chaque élément du tableau
      Si l'élément i est supérieur à l'élément i + intervalle
         Échanger les éléments
         tableauPasTrié -> vrai

Tant que tableauPasTrié est vrai OU intervalle est supérieur à 1
```

La complexité moyenne de ce tri est $O(N \log _2 N)$, mais peut-être dans le pire des cas en $O(N^2)$ bien qu’en pratique c’est peu probable.

## Conclusion

Le tri à bulles est certes un algorithme de tri assez lent (complexité en $O(N^2)$), mais reste une idée facile à comprendre et à implémenter. De plus, quelques améliorations le rendent plus rapide jusqu'à même avoir une complexité en $O(N \log _2 N)$. Cependant en pratique, ce tri est très peu employé à cause de ses utilisations trop précises et qui sont uniquement sur des données spécifiques, que vous ne rencontrerez sans doute jamais.
