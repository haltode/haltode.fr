Tri par tas
===========
algo/tri

Publié le : 14/05/2014  
*Modifié le : 26/12/2015*

## Introduction

Le tri par tas (*heapsort* en anglais) est un algorithme de tri par comparaison, plutôt efficace et qui a une complexité en $O(N \log _2 N)$. C’est un algorithme de tri [non stable](https://en.wikipedia.org/wiki/Sorting_algorithm#Stability) mais [en place](https://en.wikipedia.org/wiki/In-place_algorithm).

## Principe de l’algorithme

L'algorithme du tri par tas repose sur un élément fondamental : le [tas](/algo/structure/arbre/tas.html) (d'où son nom). En effet, ce tri crée un tas max du tableau donné en entrée, et le parcourt afin de reconstituer les valeurs triées dans notre tableau.

## Exemple

On prend la suite de nombres suivante que l’on va trier dans l’ordre croissant avec le tri par tas : 1, 9, 3, 7, 6, 1, 4.

*1ère étape* : créer le tas (max dans notre cas)

![Tas max correspondant au tableau](//static.napnac.ga/img/algo/tri/tri_tas/exemple_tas_max.png)

*2ème étape* : parcourir le tas pour trier les éléments

Pour trier les éléments grâce à notre tas, on retire la racine à chaque tour (l'élément le plus grand de notre tas, et donc de notre tableau), on le range à sa place définitive, et on entasse le dernier élément du tas pour combler le trou de la racine mais aussi respecter les règles d'un tas.

![1er tour](//static.napnac.ga/img/algo/tri/tri_tas/exemple_tour1.png)

La racine du tas (en vert) est placée dans le tableau *(1)* et le dernier élément (en bleu) va remplacer la racine *(2)*, mais il ne faut pas oublier de l'entasser pour respecter les règles du tas max *(3)*.

On continue ces opérations tant que le tas contient des éléments :

![Exemple de tri par tas](//static.napnac.ga/img/algo/tri/tri_tas/exemple_tour2.png)

## Pseudo-code

Voici le pseudo-code du tri par tas :

```nohighlight
triTas :

   Contruire le tas max du tableau

   Pour chaque élément du tableau (en partant de la fin)
      Placer la racine du tas dans le tableau
      Entasser le dernier élément du tas à la place de la racine
```

## Complexité

La complexité de l’algorithme du tri par tas est en $O(N \log _2 N)$. En effet, la boucle principale parcourt $N$ tours ($N$ étant la taille du tableau), et appelle à chaque tour une fonction pour entasser qui a une complexité logarithmique.

*Si vous n’avez pas lu mon article sur le [tri rapide](/algo/tri/tri_rapide.html), je vous conseille au moins de lire la partie [complexité](/algo/tri/tri_rapide.html#complexité) dans laquelle j’explique pourquoi le tri rapide peut être jusqu’à deux fois plus efficace que le tri par tas.*

## Implémentation

Une implémentation en C++ (afin d'avoir le type `priority_queue`) du tri par tas :

[INSERT]
tri_tas.cpp

On utilise la [`priority_queue`](http://www.cplusplus.com/reference/queue/priority_queue/) de la STL afin d'avoir un tas max facilement dans notre implémentation.

Notre tableau d'entrée :

[INSERT]
test01.in

La sortie du programme :

[INSERT]
test01.out

## Améliorations et variantes

### Optimisation de la mémoire

On peut économiser de la mémoire en évitant de créer un tas à part entière du tableau. En effet, on peut tout simplement réorganiser notre tableau afin de le parcourir comme un tas max, et ensuite il suffit de recréer les fonctions du tas à la main (`construireTasMax`, `entasser`, etc.) pour faire nos opérations dessus. Le tas aura une taille virtuelle qui occupe initialement toute la place du tableau, mais diminue progressivement au fur et à mesure que les racines du tas sont fixées à leurs places définitives dans le tableau trié.

```nohighlight
triTas :

   Contruire le tas max dans le tableau

   Pour chaque élément du tableau (en partant de la fin)
      Echanger l'élément actuel avec la racine
      Décrémenter la taille du tas
      Entasser l'élément placé à la racine
```

On parcourt le tableau à l'envers afin d'échanger la racine actuelle avec l'élément occupant sa place définitive.

### Mélange d'algorithme

Comme pour le tri rapide, le tri par tas peut être mélangé avec un autre algorithme de tri lorsque le tableau possède peu d’éléments afin de le rendre plus efficace. Pour en savoir plus à ce sujet, je vous invite à lire la partie [mélange d'algorithme](/algo/tri/tri_rapide.html#mélange-dalgorithme) de mon article sur le tri rapide.

### Smoothsort

TODO : pourquoi suite de léonard ? image + pseudo-code + meilleures explications

Le Smoothsort est une variante du tri par tas permettant d'améliorer la complexité en temps dans le meilleur des cas en $O(N)$ (le cas où les nombres en entrée sont déjà triés ou quasi triés par exemple). Le principe de ce tri se base non plus sur un seul tas, mais sur plusieurs ayant un comportement différent et s'appuyant sur la [suite de Léonard](https://en.wikipedia.org/wiki/Leonardo_number).

Cette suite se définit comme ceci :

$L(0) = 1$  
$L(1) = 1$  
$L(n) = L(n - 1) + L(n - 2) + 1$

Les premiers éléments sont : 1, 1, 3, 5, 9, 15, 25, 41, 67, etc.

On va utiliser cette suite afin de créer plusieurs tas, dont la taille est un nombre de la suite de Léonard. En plus de cette taille spécifique, les tas auront des opérations d'insertions et de suppressions différentes, pour pouvoir facilement trier notre tableau ensuite.

**Insertion** (création des tas) :

L'insertion d'un élément se décompose en deux étapes, premièrement l'ajout et deuxièmement la réorganisation de nos tas.

L'ajout se déroule selon des règles bien spécifiques, que l'on répète pour chaque élément du tableau :

- Si les deux derniers tas sont de taille $L(n + 1)$ et $L(n)$, alors le nouvel élément devient la racine des deux tas, et forme un tas plus grand de taille $L(n + 2)$.
- Sinon si le dernier tas a une taille différente de $L(1)$, alors le nouvel élément est un tas de taille $L(1)$.
- Sinon, le nouvel élément est un tas de taille $L(0)$.

Une fois l'ajout de notre élément, on va réorganiser les tas créés :

- On considère notre dernier tas créé comme le tas dit **actuel**.
- Tant qu'il y a un tas avant le tas actuel, et que la racine de ce tas est supérieure à la racine du tas actuel et à ses deux premiers enfants : échanger les deux racines et l'autre tas devient le tas actuel.
- Tant que le tas actuel a plus d'un élément et que l'un des deux enfants de la racine de ce tas est supérieur à la racine du tas actuel : échanger le plus grand des deux fils avec la racine, et ce fils devient la racine du nouveau tas actuel.

**Suppression** (réorganisation des éléments dans le tableau désormais trié) :

Une fois nos tas créés, il faut les parcourir afin d'en tirer les éléments du tableau mais trié.

On recommence ces opérations tant qu'il reste un tas :

- Si le dernier tas a une taille de $L(0)$ ou $L(1)$, alors on peut simplement le retirer et le placer dans notre tableau.
- Sinon, retirer la racine du tas et réorganiser les éléments des deux sous tas si besoin.

Toutes ces explications peuvent paraître assez abstraites, et voici un exemple pour mieux comprendre le fonctionnement du Smoothsort :

## Conclusion

Le tri par tas est donc un algorithme de tri efficace en $O(N \log _2 N)$ non stable mais en place. En pratique, cet algorithme est moins utilisé que le tri rapide, même si en théorie il a une meilleure complexité dans le pire des cas. Il sert en revanche à l'amélioration du tri rapide, dans sa variante l'[introsort](/algo/tri/tri_rapide.html#introsort) et reste donc un algorithme de tri essentiel à connaître.
