Arbre
=====
algo/structure

Publié le :  
*Modifié le : 08/11/2015*

## Introduction

Une famille de lapin, dont le père s'appelle Bob et la mère Alice, ont des enfants, qui a leurs tours auront des enfants, qui se marieront et auront aussi des enfants. Comment organiser cette famille afin de visualiser qui est marié avec qui, qui sont les parents, qui sont les enfants, combien un couple a-t-il d'enfants, etc. ? Vous connaissez sans doute déjà la réponse, dans notre cas on utilisera un [arbre généalogique](https://en.wikipedia.org/wiki/Family_tree), vous en avez forcément déjà vu et/ou construit, et cette structure devrait vous être familière.

Mais je vais vous présenter une structure de données plus large que l'arbre généalogique, qui permet de répondre à de nombreux autres problèmes et qui possèdent beaucoup de variantes : l'arbre.

## Principe d'un arbre

Un arbre (*tree* en anglais) est une structure de données permettant de représenter une hiérarchie. Chaque élément d'un arbre est appelé un *nœud*, et peut être relié par des *arêtes* à plusieurs nœuds enfants qu'on appelle *fils* (le nœud parent est appelé *père*, et le premier nœud de l'arbre est la *racine*, c'est le seul élément ne possédant pas de père). Si le nœud ne possède aucun fils, on parle alors de *feuille*.

![Exemple d'arbre](/static/img/algo/structure/arbre/exemple_arbre.png)

La *profondeur* d'un nœud est le nombre de nœuds le séparant de la racine, et la *hauteur* d'un arbre est simplement la profondeur maximale de ses nœuds.

Finalement, un arbre peut être vu comme un [graphe](/algo/structure/graphe.html) particulier (orienté, acyclique et chaque enfant ne peut avoir qu'un seul parent).

## Implémentation

Comme nous avons vu qu'un arbre est un graphe particulier, on peut donc l'implémenter de la même façon techniquement, je vous invite donc à lire la partie [Implémentation](/algo/structure/graphe.html#implémentation) de mon article sur les graphes pour voir et comprendre les différentes possibilités (matrice d'adjacence, liste d'adjacence et liste d'arcs).

## Parcourir un arbre

De même, parcourir un arbre revient à parcourir un graphe, on peut donc utiliser les deux algorithmes de parcours :

- [Parcours en profondeur]() : DFS (*Depth First Search*)
- [Parcours en largeur]() : BFS (*Breadth First Search*)

## Variantes

- Arbre binaire
- Tas
- Arbre de recherche
- Trie

## Conclusion
