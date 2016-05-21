Algorithme de Bellman-Ford
==========================
algo/structure/graphe/plus_court_chemin

Publié le : 21/05/2016  
*Modifié le : 21/05/2016*

## Introduction

## Principe

L'approche gloutonne du précédent algorithme est excellente car elle permet d'aborder le problème de manière intelligente, ce qui lui donne une complexité très intéressante, tout en étant optimale. Cependant, elle ne s'applique pas à toutes les configurations de graphe, et il nous faut donc un nouvel algorithme pour gérer ce cas.

Reprenons depuis le début. On a un graphe pondéré (positivement ou négativement), et on cherche le plus court chemin entre deux nœuds distincts. Une approche **naïve** serait d'explorer toutes les combinaisons possibles de chemin et de choisir celle qui obtient une pondération totale minimale. Le problème ici est évidemment la complexité en temps exponentielle. Dans ce genre de situation, il est fondamental de se poser cette question : qu'est-ce qui rend notre algorithme si lent ? Lorsqu'on explore toutes les possibilités de chemins, on repasse très souvent sur d'anciens nœuds et arcs, ce qui nous fait parcourir notre graphe plusieurs fois inutilement.

Désormais, on connaît la raison de la lenteur de notre précédent algorithme, et il faut alors chercher à améliorer ce point, si possible, ou bien à changer de concept. L'algorithme de Bellman-Ford va améliorer l'algorithme naïf, en utilisant une approche différente du problème : la [**programmation dynamique**](/algo/general/approche/dynamique.html). L'idée est justement de ne pas repasser plusieurs fois sur des parties du graphe, en gardant les informations utiles en mémoire à l'aide d'un algorithme dynamique.

*Il est intéressant de noter que [Richard Bellman](https://en.wikipedia.org/wiki/Richard_E._Bellman), l'un des inventeurs de cet algorithme, est le père fondateur de la programmation dynamique.*

## Exemple

Un exemple de l'algorithme de Bellman-Ford serait assez peu intéressant car il n'adopte pas de stratégie particulière au niveau du parcours du graphe (contrairement à l'algorithme de Dijkstra). Il se contente uniquement de tester chaque possibilité de chemin avec une **implémentation dynamique** le rendant plus rapide qu'une implémentation naïve.

## Pseudo-code

Pour mettre en place un algorithme dynamique correctement, il est essentiel de rédiger la version récursive d'abord afin d'établir explicitement la récursion pour bien comprendre ce que cherche à réaliser l'algorithme.

Le problème du plus court chemin sur un graphe pondéré positivement et négativement introduit cependant un nouveau souci : les **cycles améliorants**. En effet, vu qu'une pondération peut désormais être négative, il est possible de tomber dans une boucle infinie (qu'on appelle plus précisément un cycle améliorant) qui va sans cesse diminuer la distance parcourue. Ceci pose un réel problème car puisqu'on peut améliorer la distance à chaque fois qu'on passe dans ce cycle, il existera toujours un meilleur chemin à emprunter, et on ne peut donc pas trouver de solution à cause de cette boucle infinie.

![Exemple de cycle améliorant](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/bellman_ford/exemple_cycle_ameliorant.png)

Sur cet exemple de graphe, on remarque que le chemin surligné en rouge est un cycle améliorant, car la distance du chemin va baisser à chaque fois qu'on le parcourt ce qui fait qu'il existe toujours un chemin plus efficace, et cela entraîne une boucle infinie dans notre algorithme.

Pour contrer cela, on va imposer une limite de recherche à notre récursion qui ne pourra pas dépasser l'exploration de $K$ nœuds. Une limite de $N$ nœuds maximum à explorer permet à notre algorithme de ne jamais tomber dans une boucle infinie (avec $N$ le nombre de nœuds du graphe), puisqu'un plus court chemin, qui ne contient pas de cycle améliorant, ne passe jamais plus de deux fois par un même nœud. On peut désormais reformuler plus clairement notre problème de plus court chemin entre un nœud A et B, en un problème cherchant à minimiser la distance entre A et B en réalisant $K$ étapes au maximum. La reformulation est importante puisqu'elle limite la recherche afin de ne pas tomber dans une boucle infinie.

Voici un premier pseudo-code simplifié de la récursion (on suppose que le graphe en entrée est orienté et ne possède pas de cycles améliorantes pour établir une première idée de l'algorithme général).

```nohighlight
Bellman-Ford (nbEtape, nœud) :

   Si nbEtape = 0
      Si c'est le nœud d'arrivée
         Retourner 0
      Sinon
         Retourner -INFINI car le chemin est invalide

   cheminMin = Bellman-Ford(nbEtape - 1, nœud)
   Pour chaque voisin du nœud
      cheminVoisin = pondérationArc + Bellman-Ford(nbEtape - 1, voisin)
      cheminMin = min(cheminMin, cheminVoisin)

   Retourner cheminMin
```

Ce pseudo-code traduit une simple récursion permettant d'explorer tous les chemins en moins de `nbEtape` jusqu'à l'arrivée, tout en sélectionnant le plus court d'entre eux.

Maintenant, on passe à l'étape de dynamisation de cet algorithme puisque ce dernier est terriblement lent et possède une complexité en temps exponentielle car il ne fait que répéter des appels récursifs inutilement. On va donc créer un tableau 2D stockant le plus court chemin pour tous les paramètres possibles de notre fonction, afin de ne jamais avoir à recalculer le résultat d'un même appel.

```nohighlight
plusCourtChemin[NB_ETAPE_MAX][NB_NOEUD_MAX] (initialisé à -1)

Bellman-Ford (nbEtape, nœud) :

   Si nbEtape = 0
      Si c'est le nœud d'arrivée
         Retourner 0
      Sinon
         Retourner -INFINI car le chemin est invalide
   Si plusCourtChemin[nbEtape][nœud] != -1
      Retourner plusCourtChemin[nbEtape][nœud]

   cheminMin = Bellman-Ford(nbEtape - 1, nœud)
   Pour chaque voisin du nœud
      cheminVoisin = pondérationArc + Bellman-Ford(nbEtape - 1, voisin)
      cheminMin = min(cheminMin, cheminVoisin)

   plusCourtChemin[nbEtape][nœud] = cheminMin
   Retourner cheminMin
```

On a ajouté trois points fondamentaux qu'on retrouve dans un processus de dynamisation d'un algorithme :

- L'**initialisation** du tableau `plusCourtChemin` à -1 pour marquer toutes les valeurs comme non calculées.
- Une **condition** au début de notre récursion afin de vérifier si la valeur n'a pas déjà été calculée.
- Une **mise à jour** du tableau après avoir trouvé une nouvelle valeur.

Une fois qu'on a réussi à obtenir une complexité en temps non exponentielle (puisque désormais on ne reparcourt pas inutilement des parties du graphe), il est toujours intéressant de tenter de réduire notre complexité en mémoire si possible. Actuellement, dans le dernier pseudo-code, on a une complexité mémoire de l'ordre de $N^2$ puisque $N$ représente le nombre de nœuds du graphe, et on sait qu'on choisit la limite $K$, tel que $K = N$ pour éviter les cycles améliorants. Cet ordre de grandeur est tout à fait correct en termes d'espace mémoire, surtout vu le gain de temps qu'on acquiert grâce au tableau, mais il peut cependant être encore amélioré.

Le passage à la version itérative de l'algorithme dynamique est essentiel à cette réduction de l'espace mémoire utilisé, et c'est ce qu'on va réaliser dans un premier temps :

```nohighlight
Bellman-Ford :

   plusCourtChemin[NB_ETAPE_MAX][NB_NOEUD_MAX] (initialisé à -1)

   Pour chaque étape
      Pour chaque nœud
         cheminMin = plusCourtChemin[étape - 1][nœud]
         Pour chaque voisin du nœud
            cheminVoisin = pondérationArc + plusCourtChemin[étape - 1][voisin]
            cheminMin = min(cheminMin, cheminVoisin)
         plusCourtChemin[étape][nœud] = cheminMin

   Retourner plusCourtChemin[nbEtapeMax - 1][départ]
```

Pour comprendre comment on passe à la version itérative de l'algorithme, il est important de réaliser une représentation graphique de `plusCourtChemin` :

![Représentation graphique du tableau 2D de l'algorithme dynamique](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/bellman_ford/representation_tableau_dyn.png)

Chaque étape représente une ligne du tableau, et chaque nœud une colonne. On remarque rapidement que pour remplir une ligne entière, il suffit uniquement de la précédente. On peut donc remplir itérative ment le tableau ligne par ligne, afin d'arriver au résultat obtenu.

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

TODO : vérifier arrivée dans plusCourtChemin[arrivée] = 0

Précédemment, on utilisait une boucle sur les nœuds et une boucle sur les voisins de ces derniers, mais pour éviter ces deux boucles, on utilise simplement une sur tous les arcs du graphe.

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

L'avantage de passer de l'approche récursive à l'approche itérative dans un algorithme dynamique, est qu'on peut facilement trouver la complexité en temps de ce dernier. En effet, les deux boucles imbriquées nous permettent de calculer une complexité en temps de $O(N * M)$ avec $N$ le nombre de nœuds du graphe, et $M$ le nombre d'arcs.

TODO : comparaison dijkstra

## Implémentation

L'implémentation en C++ de l'algorithme de Bellman-Ford :

[INSERT]
bellman_ford.cpp

## Conclusion
