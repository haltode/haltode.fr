Path: algo/structure/graphe  
Title: Plus court chemin  
Published: 22/05/2016  
Modified: 22/05/2016  

## Introduction

Comment votre GPS peut-il connaître le plus court chemin entre Paris et Grenoble aussi facilement ? De manière générale, on peut se demander comment calculer l'itinéraire entre deux points donnés d'une carte de telle sorte que la distance soit minimale ? On pourrait aller encore plus loin dans la généralisation, en représentant notre carte comme un [graphe](/algo/structure/graphe.html) et en transformant la question en : quel est le plus court chemin entre un nœud A et B dans un graphe pondéré ?

Il existe différentes manières de répondre à cette question, et la réponse varie souvent en fonction du graphe donné en entrée de notre algorithme (pondéré positivement, négativement, dense, creux, etc.). Savoir reconnaître un problème de plus court chemin est donc important, et utiliser le bon algorithme l'est encore plus. Ces algorithmes ne se limitent pas à la création d'un simple GPS rudimentaire, mais peuvent aller bien plus loin et servent de base à de nombreuses autres applications.

## Algorithmes

Une liste non exhaustive d'algorithmes essentiels permettant de résoudre le problème du plus court chemin :

- [**Dijkstra**](/algo/structure/graphe/plus_court_chemin/dijkstra.html) : un algorithme **glouton** efficace, avec une complexité en temps de $O(M \log _2 M)$ (avec $M$ le nombre d'arcs du graphe), mais qui ne fonctionne que sur des graphes pondérés positivement.
- [**Bellman-Ford**](/algo/structure/graphe/plus_court_chemin/bellman_ford.html) : un algorithme **dynamique** applicable sur n'importe quel type de pondération d'un graphe, mais avec une complexité en temps légèrement plus lente de $O(NM)$ (avec $N$ le nombre de nœuds du graphe).
- **Floyd-Warshall** :

## Conclusion

Le problème du plus court chemin est extrêmement commun en algorithmique. On le retrouve dans beaucoup de domaines divers :

- **GPS** : comme évoqué en introduction, une carte routière est sans doute l'exemple le plus explicite lorsqu'on parle de plus court chemin. On souhaite chercher un trajet entre deux villes, et on peut utiliser différents graphes pondérés en fonction du critère de sélection (chemin le plus rapide en temps, chemin le plus court en distance, etc.).
- **Jeu** : dans les jeux vidéos, il est très courant de retrouver des graphes pondérés. Que ce soit pour déplacer des unités de manière intelligente en fonction de la carte (on parle alors de *pathfinding*), ou encore pour prendre des décisions selon différents critères qui peuvent influencer le reste de la partie, un algorithme de plus court chemin est très utile à connaître.
- **Internet** : lorsque deux machines communiquent entre elles sur Internet, elles passent obligatoirement par différents serveurs (à moins qu'elles soient directement reliées entre elles, mais ce n'est pas le cas ici). Il est fondamental de pouvoir choisir le chemin à prendre afin d'avoir un délai de communication minimal. On peut alors voir ce problème comme une forme de plus court chemin où les serveurs représenteraient des nœuds du graphe, et les pondérations seraient le délai de communication.
- **Transport** : quand on livre un colis, il y a souvent plusieurs moyens de transport à notre disposition. Chacun permet de se rendre d'un point A à un point B, coûte une certaine somme d'argent et met une durée prédéfinie pour se déplacer. On peut représenter ce problème sous forme d'un graphe pondéré, et le but de l'entreprise serait de trouver un chemin entre A et B pouvant alterner les formes de transports et minimisant par exemple le temps de trajet (en général, une entreprise cherchera aussi à minimiser le coût de transport).
- **Finance** : on a vu les cycles améliorants comme un concept péjoratif, cependant ils sont parfois très utiles comme en finance, où trouver ce genre de cycle peut être avantageux et permet de gagner de l'argent facilement. Si l'on imagine un graphe pondéré de multiples transactions bancaires (par exemple lorsque vous convertissez des euros en dollars), si on arrive à trouver un cycle améliorant dans ce graphe, cela signifie qu'on peut convertir en "boucle" et gagner encore plus d'argent à chaque tour.
- **Génétique** : lorsqu'on a deux chaînes d'ADN sous la forme d'une suite de nucléotides comme "AGGCTATGGC" et "ATGCAATGCC", et que l'on souhaite trouver le nombre minimum de mutations à appliquer à une chaîne pour se retrouver avec l'autre, on peut utiliser un algorithme de plus court chemin. Ce problème n'est pas restreint au domaine de la génétique, et il est assez fréquent de vouloir transformer une chaîne en une autre en un minimum d'opérations. Le graphe représenterait les différents états de la chaîne, et les arcs pourraient être une opération (avec comme pondération le coût de cette transformation). On peut aussi appliquer cette idée de graphe implicite à des nombres, ou tout autre forme de structure pouvant subir des modifications diverses (ajout, suppression, transformation, etc.).

Les applications des algorithmes de plus court chemin sont très vastes, et il est fondamental d'en comprendre l'utilité. Ce problème de plus court chemin dans un graphe introduit aussi de nouveaux énoncés, comme le fameux problème du [**voyageur de commerce**](https://en.wikipedia.org/wiki/Travelling_salesman_problem) qui consiste à trouver un plus court chemin parcourant tous les nœuds d'un graphe pondéré une seule fois seulement, en finissant le trajet sur le nœud de départ. Cette question, d'apparence assez simpliste, représente en réalité un problème dit [NP-complet](https://en.wikipedia.org/wiki/NP-completeness) pour lequel on ne connaît pas de solution en un temps polynomial. Ce n'est pas le [seul problème dans cette catégorie](https://en.wikipedia.org/wiki/List_of_NP-complete_problems), et les utilisations connexes du plus court chemin sont loin d'être toutes aussi triviales qu'on peut l'imaginer.
