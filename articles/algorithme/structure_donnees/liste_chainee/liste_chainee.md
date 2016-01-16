Liste chaînée
=============
algo/structure/

Publié le : 08/06/2014  
*Modifié le : 16/01/2016*

## Introduction

Imaginons un tableau contenant des milliards d'éléments. Comment supprimer un élément en plein milieu du tableau ? Pourquoi pas créer un deuxième tableau dans lequel on recopie toutes nos valeurs (sauf celles que l'on veut supprimer) ? Cela marche bien, mais cette opération est longue et coûteuse en mémoire. On peut essayer de décaler le tableau en réécrivant sur la valeur que l'on veut supprimer, grâce à ça on fait des économies de mémoire mais cela prend beaucoup de temps. Et comment ajouter un élément dans notre tableau ? De même, on peut recréer un tableau en recopiant nos valeurs et en ajoutant au passage le nouvel élément. On peut aussi faire des économies de mémoire en décalant les éléments vers la droite pour laisser un espace au milieu afin d'insérer notre nouvel élément. Cependant, cette solution prend trop de temps et ceci nous pousse à comprendre que les tableaux ne sont pas adaptés à toutes les situations.

Face à ces problèmes de temps, et de mémoire, on a besoin d'une nouvelle structure de données souple, dynamique, et qui nous permet d'insérer et de supprimer des éléments facilement : la liste chaînée.

## Principe de la liste chaînée

Une liste chaînée (*linked list* en anglais) est une structure de données auto référentielle, c'est-à-dire que chacun de ses éléments pointent vers l'élément suivant que l'on appelle des **nœuds** (*node*). A partir de cette définition on peut déjà établir le contenu d'un élément d'une liste chaînée :

- **Des données** : ces données peuvent être de n'importe quels types (entier, flottant, chaîne de caractère, etc.), et il peut en y avoir autant que possible par élément.
- **Un pointeur** : ce pointeur pointe vers l'élément suivant de la liste, et permet de lier les nœuds entre eux.

![Exemple de représentation d'une liste chaînée](//static.napnac.ga/img/algo/structure/liste_chainee/exemple_liste_chainee.png)

Le dernier pointeur de la liste chaînée pointe sur la valeur `NULL`, pour indiquer la fin de la liste.

## Différence avec les tableaux

Les deux structures de données sont différentes, et ont leurs avantages et leurs inconvénients, aucune n'est meilleure que l'autre mais il faut savoir quand utiliser la bonne structure au bon moment :

- **Tableau** : les éléments sont contigus en mémoire, la taille du tableau ne change pas et est connue à l'avance, l'ajout et la suppression d'un élément du tableau sont des opérations couteuses en temps et en mémoire, en revanche on peut aisément accéder à un élément du tableau en temps constant (par exemple en C : `tableau[2]`).
- **Liste chaînée** : les éléments ne sont pas contigus en mémoire, la taille peut varier, on peut facilement insérer/supprimer des éléments de la liste en temps constant, mais on ne peut pas accéder à un élément précis de la liste instantanément (il faut parcourir la liste jusqu'à cet élément).

![Exemple d'ajout d'un élément dans une liste chaînée](//static.napnac.ga/img/algo/structure/liste_chainee/exemple_ajout.png)

![Exemple de suppression d'un élément dans une liste chaînée](//static.napnac.ga/img/algo/structure/liste_chainee/exemple_suppression.png)

## Quelques fonctions pour manipuler les listes chaînées

Pour manipuler correctement les listes chaînées, il faut connaître quelques fonctions basiques pour ajouter un élément, le supprimer, rechercher un élément précis dans la liste, etc.

```nohighlight
créerListe :
   Initialiser la liste à NULL
supprimerListe :
   Pour chaque élément de la liste
      Supprimer l'élément actuel

ajoutTête (élément) :
   Faire pointer le nouvel élément vers le premier élément de la liste
ajoutFin (élément) :
   Parcourir la liste jusqu'à la fin
   Faire pointer le dernier élément vers l'élément donné en paramètre
   Faire pointer l'élément donné en paramètre sur NULL
ajoutElément (élément, index) :
   Parcourir la liste jusqu'à arriver à l'élément situé avant l'index donné
   Faire pointer l'élément actuel sur le nouvel élément
   Faire pointer le nouvel élément sur le prochain

supprimerTête :
   Supprimer l'élément en tête de liste
supprimerFin :
   Parcourir la liste jusqu'à l'avant-dernier élément
   Supprimer l'élément suivant
   Faire pointer l'élément sur NULL (pour indiquer la fin de la liste)
supprimerElément (index) :
   Parcourir la liste jusqu'à arriver à l'élément situé avant l'index donné
   Faire pointer l'élément actuel sur le pointeur de l'élément à supprimer 
   Supprimer l'élément suivant

estVide :
   Si le premier élément de la liste est NULL
      Retourner vrai
   Sinon
      Retourner faux
```

## Complexité

Soit $N$ le nombre d'éléments de la liste chaînée.

- `créerListe` : $O(1)$
- `supprimerListe` : $O(N)$
- `ajoutTête` : $O(1)$
- `ajoutFin` : $O(N)$
- `ajoutElément` : $O(N)$
- `supprimerTête` : $O(1)$
- `supprimerFin` : $O(N)$
- `supprimerElément` : $O(N)$
- `estVide` : $O(1)$

## Implémentation

Une implémentation en C des fonctions présentées au-dessus :

[INSERT]
liste_chainee.c

Le code est relativement simple à comprendre et à utiliser, une connaissance des pointeurs est cependant nécessaire.

Si vous programmez en C++, la [STL](https://en.wikipedia.org/wiki/Standard_Template_Library) (*Standard Template Library*) fournit une implémentation de liste chaînée ainsi que des fonctions de base pour les manipuler : <http://www.cplusplus.com/reference/list/list/>.

## Variantes de la liste chaînée

Il existe plusieurs variantes de la liste chaînée qui sont pratiques dans certains problèmes précis.

### Liste doublement chaînée

La liste double chaînée (*doubly linked list*) consiste à ce que chaque élément de la liste possède deux pointeurs :

- Un pointeur vers le **prochain** élément.
- Un pointeur vers le **précédent** élément.

Cette structure est légèrement plus coûteuse en mémoire et en opération, mais rend le déplacement au sein de la liste plus pratique car on peut la parcourir dans les deux sens et on peut insérer/supprimer des éléments avant d'autres et non uniquement après.

![Exemple de représentation d'une liste doublement chaînée](//static.napnac.ga/img/algo/structure/liste_chainee/exemple_liste_doublement_chainee.png)

La structure d'une liste doublement chaînée ressemble à cela :

```c
typedef struct Noeud Noeud;
struct Noeud
{
   Noeud *suivant;
   Noeud *precedent;
   int donnee;
}

typedef Noeud *Liste;
```

La liste doublement chaînée est notamment la base de la [file](/algo/structure/file.html) et permet une implémentation efficace de cette structure.

### Liste chaînée circulaire

La liste chaînée circulaire (*circular linked list*) est une liste chaînée ne possédant pas de fin. En effet, le pointeur de fin de liste pointe vers le début de la liste formant ainsi un cycle.
 
![Exemple de représentation d'une liste chaînée circulaire](//static.napnac.ga/img/algo/structure/liste_chainee/exemple_liste_chainee_circulaire.png)

On peut utiliser cette variante de la liste chaînée pour stocker par exemple le tour de chaque joueur dans un jeu, imaginons un jeu de carte qui se joue au tour par tour dans lequel plusieurs joueurs participent, une liste chaînée circulaire permettrait de stocker l'ordre de jeu des joueurs facilement.

### Liste doublement chaînée circulaire

Une liste doublement chaînée circulaire (*doubly circular linked list*) est simplement un regroupement des deux dernières variantes.

![Exemple de représentation d'une liste doublement chaînée circulaire](//static.napnac.ga/img/algo/structure/liste_chainee/exemple_liste_doublement_chainee_circulaire.png)

### D'autres variantes plus complexes

En plus de ces variantes assez "courantes", on peut retrouver d'autres variantes plus compliquées mais qui peuvent toujours servir :

- **Liste à enjambements** (*skip list*) : ensemble de listes chaînées stockées "parallèlement" et qui permet de sauter des éléments en fonction de nos besoins, pratique pour trier et rechercher (<https://en.wikipedia.org/wiki/Skip_list>).
- Une **liste auto-organisée** : contre le problème d'accès lent à un élément dans une liste chaînée en organisant ces derniers de façon à placer les plus importants en tête de liste (<https://en.wikipedia.org/wiki/Self-organizing_list>).
- **Chaînage XOR** (*XOR linked list*) : permet de diminuer le coût en mémoire des listes doublements chaînées grâce à l'opération bit à bit XOR (<https://en.wikipedia.org/wiki/XOR_linked_list>).
- **Liste chaînée déroulée** (*unrolled linked list*) : cette variante stocke plusieurs éléments au lieu d'un seul par nœud, et fait office de compromis entre un tableau et une liste que l'on peut modifier pour qu'elle se rapproche plus de l'un que de l'autre selon les besoins (<https://en.wikipedia.org/wiki/Unrolled_linked_list>).
- **VList** : comme la précédente, c'est un compromis qui stocke des tableaux d'éléments plutôt qu'un unique élément dans chaque nœud, excepté que cette fois ci les tableaux sont de tailles variables contrairement à une liste chaînée déroulée où les tableaux sont tous de la même taille (<https://en.wikipedia.org/wiki/VList>).

## Conclusion

La liste chaînée est donc une structure de données très souple, et efficace pour insérer et supprimer des éléments simplement. De plus, on peut la modifier afin de créer de nouvelles structures de données différentes comme la liste doublement chaînée, la liste chaînée circulaire, mais aussi pour créer une [pile](/algo/structure/pile.html) ou encore une [file](/algo/structure/file.html).

Les listes chaînées sont aussi la base de structures de données plus complexes comme les [arbres](/algo/structure/arbre.html), les [graphes](/algo/structure/graphe.html), les [tables de hachage](/algo/structure/table_hachage.html) et de nombreuses variantes de listes chaînées existent.
