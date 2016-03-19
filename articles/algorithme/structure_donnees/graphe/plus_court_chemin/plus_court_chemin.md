Plus court chemin
=================
algo/structure/graphe/

Publié le : 19/03/2016  
*Modifié le : 19/03/2016*

## Introduction

Comment votre GPS peut-il connaître le plus court chemin entre Paris et Grenoble aussi facilement ? De manière générale, on peut se demander comment calculer l'itinéraire entre deux points donnés d'une carte de telle sorte que la distance soit minimale ? On pourrait aller encore plus loin dans la généralisation, en représentant notre carte comme un [graphe](/algo/structure/graphe.html) et en transformant la question en : quel est le plus court chemin entre un nœud A et B dans un graphe pondéré ?

Il existe différentes manières de répondre à cette question, et la réponse varie souvent en fonction du graphe donné en entrée de notre algorithme (pondéré positivement, négativement, dense, creux, etc.). Savoir reconnaître un problème de plus court chemin est donc important, et utiliser le bon algorithme l'est encore plus. Ces algorithmes ne se limitent pas à la création d'un simple GPS rudimentaire, mais peuvent aller bien plus loin et servent de base à de nombreuses autres applications.

## Dijkstra

### Principe

L'algorithme de Dijkstra est sans doute l'un des algorithmes de plus court chemin le plus connu. Ce dernier se base sur le [parcours en largeur](/algo/structure/graphe/parcours.html#le-parcours-en-largeur) afin de trouver le plus court chemin dans un graphe pondéré **positivement** (ce point est très important, mais nous y reviendrons plus en détails après). On sait qu'un parcours en largeur permet de trouver le plus court chemin sur un graphe non pondéré (où on associe chaque arc avec une longueur arbitraire de 1 unité) et qu'il utilise une file pour stocker les éléments afin de les parcourir profondeur par profondeur. L'algorithme de Dijkstra s'appuie sur la même idée, sauf qu'il ne va pas utiliser une simple file (car tous les arcs n'ont pas la même pondération) mais une [file à priorité](/algo/structure/file.html#file-à-priorité). Cette dernière permet de toujours avoir le nœud avec la distance minimale par rapport au départ en tête de file, et garantie alors qu'on a trouvé le plus court chemin lorsqu'on atteint le nœud de sortie. La file à priorité a aussi l'avantage d'être une structure de données très efficace, et rapide ce qui rend notre algorithme d'autant plus intéressant.

### Exemple

Soit le graphe suivant :

![Exemple de graphe pondéré positivement](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/dijkstra/exemple_graphe.png)

On a en bleu le nœud de départ, et en vert le nœud d'arrivée. Ici, on peut facilement trouver le plus court chemin à la main : 1, 3, 4, 6 (pour un coût total de 7 unités).

L'algorithme de Dijkstra commence donc par le nœud de départ (1), et regarde ses voisins :

![Tour 1 de l'algorithme](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/dijkstra/exemple_tour_1.png)

Le nœud en bleu représente désormais le nœud en tête de notre file à priorité (j'ai aussi représenté la distance parcourue depuis le nœud initial en indice). Le nœud 1 a deux arcs, qui représentent donc deux possibilités pour le moment, si l'on prend en compte la distance depuis le nœud de départ, et le poids des arcs, il faut faire un choix entre le résultat de 0 + 1 (nœud 1 vers nœud 2) et 0 + 1 (1 vers 3). Dans notre cas donc les deux nœuds sont équivalents en terme d'efficacité, mais pour notre exemple on va imaginer que notre implémentation va choisir le nœud 2 en premier (le nœud 3 menant directement au plus court chemin, il est plus intéressant de voir comment notre algorithme va rectifier son tir). On enlève donc le nœud 1 qu'on vient de visiter de notre file à priorité, et on place le nœud 2 :

![Tour 2](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/dijkstra/exemple_tour_2.png)

Notre algorithme nous mène au nœud 2, avec comme distance totale 1. Le point très important ici, est que lors du dernier tour, on avait deux choix possibles d'arcs à emprunter, en choisissant l'un des deux on n'oublie pas de conserver l'autre au cas où justement ce n'est pas le chemin le plus optimal qu'on vient d'emprunter. Lorsqu'on regarde les voisins du nœud 2 (en plus du voisin de 1 qu'on n'a pas visité), on doit choisir entre : 0 + 1 (nœud 1 vers 3), 1 + 3 (2 vers 3), ou 1 + 10 (2 vers 6). On voit que le minimum est atteint pour 0 + 1, soit le nœud 1 vers le 3. On enlève le nœud 2 de la file à priorité (tout en conservant les arcs non empruntés), et on y insère le nœud 3 :

![Tour 3](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/dijkstra/exemple_tour_3.png)

Nous sommes au nœud 3 avec une distance totale depuis le nœud de départ de 1, comme d'habitude on va chercher à comparer nos anciennes possibilités à celles qui se sont rajoutées (les voisins de 3). L'algorithme doit donc choisir entre : 1 + 2 (nœud 3 vers 4), 1 + 4 (3 vers 5), 1 + 3 (2 vers 3), 1 + 10 (2 vers 6). Le choix avec une distance minimale est donc le premier : allant du nœud 3 vers le nœud 4. On continue l'algorithme :

![Tour 4](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/dijkstra/exemple_tour_4.png)

On a enlevé le nœud 3 de notre file à priorité et placé le nœud 4. On se retrouve avec un nouvel arc possible, et on va comparer de nouveau les différents chemins : 3 + 4 (nœud 4 vers 6), 1 + 4 (3 vers 5), 1 + 3 (2 vers 3), 1 + 10 (2 vers 6). L'algorithme choisit donc le chemin 2 vers 3 : 

![Tour 5](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/dijkstra/exemple_tour_5.png)

Cependant lorsqu'on arrive sur le nœud 3, on s'aperçoit qu'on a déjà visité ce nœud (il est donc tout à fait inutile de recommencer cette opération), et l'algorithme va immédiatement choisir un autre chemin entre : 3 + 4 (nœud 4 vers 6), 1 + 4 (3 vers 5), 1 + 10 (2 vers 6). Le chemin choisi est donc celui reliant le nœud 3 au 5 :

![Tour 6](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/dijkstra/exemple_tour_6.png)

Comme auparavant, le nœud 3 est enlevé de la file à priorité, et le 5 rajouté. On prend en compte le nouvel arc possible et on choisit entre : 3 + 4 (nœud 4 vers 6), 5 + 3 (5 vers 6) et 1 + 10 (2 vers 6). Le premier choix étant celui avec le plus petit résultat, c'est ce qu'on décide de réaliser :

![Tour 7](//static.napnac.ga/img/algo/structure/graphe/plus_court_chemin/dijkstra/exemple_tour_7.png)

On arrive au nœud vert (et donc celui d'arrivée), notre algorithme est donc terminé et on a forcément trouvé le plus court chemin pour s'y rendre (les autres possibilités restants étant forcément des chemins avec une plus longue distance).

TODO : pourquoi il est rapide, et on ne peut pas vraiment faire mieux

### Pseudo-code

Le pseudo-code de l'algorithme de Dijkstra est donc identique à celui du parcours en profondeur, sauf qu'on utilise une file à priorité au lieu d'une file, afin d'organiser les éléments en fonction de leur distance au nœud de départ :

```nohighlight
Dijkstra (départ, arrivée) :

   départ.distance = 0
   Enfiler le nœud de départ

   Tant que la file à priorité n'est pas vide
      Défiler le nœud au début de la file

      Si c'est le nœud d'arrivée
         Retourner nœud.distance

      Marquer le nœud comme visité
      Pour chaque voisin du nœud
         Si le voisin n'est pas visité
            voisin.distance = nœud.distance + arc
            Enfiler le voisin
```

### Complexité

### Implémentation

Une implémentation en C++ (pour avoir [`priority_queue`](http://www.cplusplus.com/reference/queue/priority_queue/)) de cet algorithme :

[INSERT]
dijkstra/dijkstra.cpp

Le graphe d'entrée est décrit selon une liste d'arcs du style *nœud1 nœud2 poids* :

[INSERT]
dijkstra/test01.in

Et le plus court chemin en sortie :

[INSERT]
dijkstra/test01.out

La structure du code est identique à celle du parcours en profondeur, on doit juste utiliser une structure afin de représenter nos nœuds (du graphe, et de notre file) et aussi décrire l'opérateur `<` pour que l'implémentation de la `priority_queue` puisse fonctionner correctement en fonction de la variable `distance` de chacun des nœuds.

### Cas d'utilisation

## Ford-Bellman

## A* ?

## Floyd-Warshall ?

## Conclusion
