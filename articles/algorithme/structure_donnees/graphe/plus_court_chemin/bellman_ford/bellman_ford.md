Algorithme de Bellman-Ford
==========================
algo/structure/graphe/plus_court_chemin

Publié le : 26/05/2016  
*Modifié le : 26/05/2016*

## Introduction

L'approche gloutonne de l'[algorithme de Dijkstra](/algo/structure/graphe/plus_court_chemin/dijkstra.html) est excellente car elle permet d'aborder le problème du plus court chemin de manière intelligente, ce qui lui donne une complexité en temps intéressante, tout en étant optimale. Cependant, elle ne s'applique pas à toutes les configurations de graphes (par exemple ceux avec des pondérations négatives), et il nous faut donc un nouvel algorithme pour gérer ces cas.

## Principe

Reprenons depuis le début. On a un graphe pondéré (positivement ou négativement), et on cherche le plus court chemin entre deux nœuds distincts. Une approche **naïve** serait d'explorer toutes les combinaisons possibles de chemin et de choisir celle qui obtient une pondération totale minimale. Le problème ici est évidemment la complexité en temps exponentielle. Dans ce genre de situation, il est fondamental de se poser cette question : qu'est-ce qui rend notre algorithme si lent ? Lorsqu'on explore toutes les possibilités de chemins, on repasse très souvent sur d'anciens nœuds et arcs, ce qui nous fait parcourir notre graphe plusieurs fois inutilement.

Désormais, on connaît la raison de la lenteur de notre précédent algorithme, et il faut alors chercher à améliorer ce point, si possible, ou bien à changer de concept. L'algorithme de Bellman-Ford va améliorer l'algorithme naïf, en utilisant une approche différente du problème : la [**programmation dynamique**](/algo/general/approche/dynamique.html). L'idée est justement de ne pas repasser plusieurs fois sur des parties du graphe, mais plutôt de garder les informations utiles en mémoire à l'aide d'un algorithme dynamique.

*Il est intéressant de noter que [Richard Bellman](https://en.wikipedia.org/wiki/Richard_E._Bellman), l'un des inventeurs de cet algorithme, est le père fondateur de la programmation dynamique.*

## Exemple

Un exemple de l'algorithme de Bellman-Ford serait assez peu intéressant car il n'adopte pas de stratégie particulière au niveau du parcours du graphe (contrairement à l'algorithme de Dijkstra). Il se contente uniquement de tester chaque possibilité de chemin avec une **implémentation dynamique** le rendant plus rapide qu'une implémentation naïve.

## Pseudo-code

*Pour appréhender au mieux cette partie, il est nécessaire d'être familier à la programmation dynamique (ou au moins d'en connaître la base). Si ce n'est pas le cas, je vous renvoie vers mon article sur le sujet dont le lien est situé au-dessus.*

Pour mettre en place un algorithme dynamique correctement, il est essentiel de rédiger la version récursive d'abord afin d'établir explicitement la récursion pour bien comprendre ce que cherche à réaliser l'algorithme.

### Cycle améliorant

Avant de se plonger dans le pseudo-code, il faut noter que le problème du plus court chemin sur un graphe pondéré positivement et négativement introduit un nouveau souci : les **cycles améliorants** (ou *negative cycle* en anglais). En effet, vu qu'une pondération peut désormais être négative, il est possible de tomber dans une boucle infinie (qu'on appelle plus précisément un cycle améliorant) qui va sans cesse diminuer la distance parcourue. Ceci pose un réel problème puisqu'on peut améliorer la distance à chaque fois qu'on passe dans ce cycle, et il existera toujours un meilleur chemin à emprunter. Lorsqu'un graphe contient ce genre de cycle, il n'y a pas de solution à cause de cette boucle infinie, il faut donc pouvoir le détecter.

![Exemple de cycle améliorant](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/bellman_ford/exemple_cycle_ameliorant.png)

Sur cet exemple de graphe (avec le nœud de départ en bleu, et celui d'arrivée en vert), on remarque que le chemin surligné en rouge est un cycle améliorant. En effet, dès qu'on parcourt ce cycle, la distance parcourue en sortie sera toujours inférieure à celle en entrée, d'où l'intérêt de le visiter à nouveau afin de diminuer encore la distance, et ainsi de suite, ce qui entraine une boucle infinie. Il est impossible de trouver le plus court chemin entre le nœud 1 et 4 dans ce graphe, car on peut améliorer la distance parcourue à l'infini sans jamais arriver au nœud en vert.

Pour contrer cela, on va imposer une limite de recherche à notre récursion qui ne pourra pas dépasser l'exploration de $K$ nœuds. Une limite de $N$ nœuds maximum à explorer permet à notre algorithme de ne jamais tomber dans une boucle infinie (avec $N$ le nombre de nœuds du graphe), puisqu'un plus court chemin, qui ne contient pas de cycle améliorant, ne passe jamais plus de deux fois par un même nœud. On peut désormais reformuler clairement notre problème de plus court chemin entre un nœud A et B, en un problème cherchant à minimiser la distance entre A et B en réalisant $K$ étapes au maximum. La reformulation est importante puisqu'elle limite la recherche afin de ne pas tomber dans une boucle infinie.

### Version récursive

Voici un premier pseudo-code simplifié de la récursion (on suppose que le graphe en entrée est orienté et ne possède pas de cycles améliorantes pour établir une première idée de l'algorithme général).

```nohighlight
Bellman-Ford (nbEtape, nœud) :

   Si nbEtape = 0
      Si c'est le nœud d'arrivée
         Retourner 0
      Sinon
         Retourner INFINI car le chemin est invalide

   cheminMin = Bellman-Ford(nbEtape - 1, nœud)
   Pour chaque voisin du nœud
      cheminVoisin = pondérationArc + Bellman-Ford(nbEtape - 1, voisin)
      cheminMin = min(cheminMin, cheminVoisin)

   Retourner cheminMin
```

Ce pseudo-code traduit une simple récursion permettant d'explorer tous les chemins en moins de `nbEtape` jusqu'à l'arrivée, tout en sélectionnant le plus court d'entre eux. Pour cela, l'algorithme utilise une simple boucle sur tous les voisins d'un nœud ainsi qu'une variable `cheminMin` qu'on actualise pour toujours avoir le chemin avec la pondération minimale entre tous les choix possibles.

### Version dynamique récursive

Maintenant, on passe à l'étape de dynamisation de cet algorithme puisque ce dernier est terriblement lent et possède une complexité en temps exponentielle car il ne fait que répéter des appels récursifs inutilement. On va donc créer un tableau 2D stockant le plus court chemin pour tous les paramètres possibles de notre fonction, afin de ne jamais avoir à recalculer le résultat d'un même appel.

```nohighlight
plusCourtChemin[NB_ETAPE_MAX][NB_NOEUD_MAX] (initialisé à -1)

Bellman-Ford (nbEtape, nœud) :

   Si nbEtape = 0
      Si c'est le nœud d'arrivée
         Retourner 0
      Sinon
         Retourner INFINI car le chemin est invalide
   Si plusCourtChemin[nbEtape][nœud] != -1
      Retourner plusCourtChemin[nbEtape][nœud]

   cheminMin = Bellman-Ford(nbEtape - 1, nœud)
   Pour chaque voisin du nœud
      cheminVoisin = pondérationArc + Bellman-Ford(nbEtape - 1, voisin)
      cheminMin = min(cheminMin, cheminVoisin)

   plusCourtChemin[nbEtape][nœud] = cheminMin
   Retourner cheminMin
```

On a seulement ajouté les trois points fondamentaux qu'on retrouve dans un processus de dynamisation d'un algorithme :

- L'**initialisation** du tableau `plusCourtChemin` à -1 pour marquer toutes les valeurs comme non calculées.
- Une **condition** au début de notre récursion afin de vérifier si la valeur n'a pas déjà été calculée (et si c'est le cas, on la retourne directement).
- Une **mise à jour** du tableau après avoir trouvé une nouvelle valeur.

### Version dynamique itérative

TODO : revoir deux dernières sous-parties

Une fois qu'on a réussi à obtenir une complexité en temps non exponentielle (puisque désormais on ne parcourt pas inutilement des parties du graphe), il est toujours intéressant de tenter de réduire notre complexité en mémoire si possible. Actuellement, dans notre dernier pseudo-code, on a une complexité mémoire de l'ordre de $KN$, ce qui est équivalent à du $N^2$, car on choisit la limite $K$, tel que $K = N$ pour éviter les cycles améliorants. Cet ordre de grandeur est tout à fait correct en termes d'espace mémoire, surtout vu le gain de temps qu'on acquiert grâce au tableau, mais il peut être encore largement amélioré.

Le passage à la version itérative de l'algorithme dynamique est essentiel à cette réduction de l'espace mémoire utilisé, et c'est ce qu'on va réaliser dans un premier temps :

```nohighlight
Bellman-Ford :

   plusCourtChemin[NB_ETAPE_MAX][NB_NOEUD_MAX] (initialisé à INFINI)
   plusCourtChemin[0][arrivée] = 0

   Pour chaque étape
      Pour chaque nœud
         cheminMin = plusCourtChemin[étape - 1][nœud]
         Pour chaque voisin du nœud
            cheminVoisin = pondérationArc + plusCourtChemin[étape - 1][voisin]
            cheminMin = min(cheminMin, cheminVoisin)
         plusCourtChemin[étape][nœud] = cheminMin

   Retourner plusCourtChemin[nbEtapeMax - 1][départ]
```

Plusieurs points importants à comprendre dans cette version itérative de l'algorithme :

- Le tableau `plusCourtChemin` est initialisé à `INFINI` car on n'a plus besoin de détecter le cas où l'on retombe sur un appel de fonction déjà rencontré auparavant, puisque désormais on utilise des boucles (passage de la version récursive à itérative). On choisit donc la valeur `INFINI` pour noter qu'on ne connaît pas de plus court chemin pour un nœud donné à une étape précise.
- On a transformé les appels récursifs en deux boucles imbriquées, une sur les étapes, et l'autre sur les nœuds. En réalité, on parcourt simplement notre tableau `plusCourtChemin`, et c'est exactement ce que réalisait implicitement notre fonction récursive puisqu'on retrouve la première boucle grâce au paramètre de la fonction `nbEtape` (que l'on diminuait à chaque fois de 1, et qui nous permettait d'arrêter la récursion lorsqu'elle atteignait 0), et la boucle sur les nœuds lors des appels récursifs sur les nœuds voisins. Notre structure au niveau de la boucle des voisins n'a pas changé, et on cherche toujours à garder le minimum dans notre tableau `plusCourtChemin`.

Prenons l'exemple de ce graphe (ne contenant pas de cycle améliorant pour simplifier la chose), et appliquons notre nouveau pseudo-code itératif dessus pour bien l'appréhender :

![Exemple de graphe orienté et pondéré](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/bellman_ford/exemple_graphe_pseudo_code_iteratif.png)

On cherche le plus court chemin entre le nœud 1 (en bleu) et le nœud 5 (en vert), et notre tableau `plusCourtChemin` initial ressemble donc à cela :

![Etat initial du tableau `plusCourtChemin`](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/bellman_ford/etat_init_pseudo_code_iteratif.png)

TODO : étape 0, 1 et finale

TODO : passage des deux boucles (nœuds + voisin) à une seule boucle (arc)

TODO : transition + refaire explication réduction mémoire

Le fait que chaque ligne dépende uniquement de la précédente est fondamental dans l'économie de mémoire que l'on cherche à réaliser, car cela signifie qu'à tout moment, on a besoin uniquement d'une seule ligne pour déduire la prochaine. Il est donc possible de supprimer une dimension entière, vu que les $K$ étapes ne sont pas nécessaires à stocker car on peut se contenter de stocker simplement la dernière. Notre complexité en mémoire passe désormais à de l'ordre de $N$ :

```nohighlight
Bellman-Ford :

   plusCourtChemin[NB_NOEUD_MAX] (initialisé à -1)
   plusCourtChemin[arrivée] = 0

   Pour chaque étape
      Pour chaque arc
         cheminVoisin = pondérationArc + plusCourtChemin[nœud2arc]
         plusCourtChemin[nœud1arc] = min(plusCourtChemin[nœud1arc], cheminVoisin)

   Retourner plusCourtChemin[départ]
```

Précédemment, on utilisait une boucle sur les nœuds et une boucle sur les voisins de ces derniers, mais pour éviter ces deux boucles, on utilise simplement une sur tous les arcs du graphe.

### Détection de cycles améliorants

Cette économie de mémoire a d'autres avantages à part faire diminuer la complexité en mémoire :

- Le code est d'autant plus simplifié.
- Le problème du cycle améliorant est très simple à gérer.

En effet, pour détecter un cycle améliorant, il suffit de détecter si un chemin emprunte plus de $N$ nœuds, et on peut très simplement réaliser ce test en regardant si le tableau `plusCourtChemin` a été modifié une fois la limite atteinte (on va donc réaliser un tour de boucle en plus). Si c'est le cas, on sait que le graphe contient un cycle améliorant :

```nohighlight
Bellman-Ford :

   plusCourtChemin[NB_NOEUD_MAX] (initialisé à -1)
   plusCourtChemin[arrivée] = 0

   modification = faux
   Pour chaque étape (avec un dernier tour de boucle en plus)
      modification = faux
      Pour chaque arc
         cheminVoisin = pondérationArc + plusCourtChemin[nœud2arc]
         Si cheminVoisin < plusCourtChemin[nœud1arc]
            plusCourtChemin[nœud1arc] = cheminVoisin
            modification = vrai

   Si modification
      Le graphe contient un cycle améliorant
   Sinon
      Retourner plusCourtChemin[départ]
```

## Complexité

L'avantage de passer de l'approche récursive à l'approche itérative dans un algorithme dynamique, est qu'on peut facilement trouver la complexité en temps de ce dernier. En effet, les deux boucles imbriquées nous permettent de calculer une complexité en temps de $O(N * M)$ avec $N$ le nombre de nœuds du graphe, et $M$ le nombre d'arcs (puisqu'on sait que pour éviter un cycle améliorant il suffit que $K = N$).

Cette complexité en temps est légèrement moins efficace que celle de l'algorithme de Dijkstra, mais reste très raisonnable vu la complexité exponentielle de l'algorithme naïf. Surtout que l'algorithme de Dijkstra ne permet pas de réaliser le calcul du plus court chemin sur des graphes pondérés négativement, et que l'algorithme de Bellman-Ford gère le cas des cycles améliorants de manière très simple et élégante.

## Implémentation

L'implémentation en C++ de l'algorithme de Bellman-Ford :

[INSERT]
bellman_ford.cpp

## Conclusion
