Liste chaînée
=============
algo/structure/

Publié le : 08/06/2014  
*Modifié le : 22/10/2015*

## Introduction

Une liste chaînée (*linked list* en anglais) est une structure de données très utilisée en programmation et permet d'implémenter d'autres structures plus complexes. On utilise une liste chaînée principalement pour stocker des données de manière souple et dynamique, c'est-à-dire pour nous permettre l'insertion et la suppression d'éléments facilement (contrairement à un tableau).

## Principe de la liste chaînée

Une liste chaînée est une structure de données auto référentielle, c'est-à-dire que chacun de ses éléments pointe vers l'élément suivant que l'on appelle alors des **nœuds** (*node* en anglais). A partir de cette définition on peut déjà établir le contenu d'un élément d'une liste chaînée :

- **Des données** : ces données peuvent être de n'importe quels types (entier, flottant, chaîne de caractère, etc.), et il peut en y avoir autant que possible par élément.
- **Un pointeur** : ce pointeur pointe vers l'élément suivant de la liste, et permet de lier les nœuds entre eux.

![Exemple de représentation d'une liste chaînée](/static/img/algo/structure/liste_chainee/exemple_liste_chainee.png)

Le dernier pointeur de la liste chaînée pointe sur la valeur `NULL`, pour indiquer la fin de la liste.

## Différence avec les tableaux

Les listes chaînées vous font sans doute penser à un tableau, mais elles sont très différentes. Les deux ont leurs avantages et leurs inconvénients, aucune n'est meilleure que l'autre mais il faut savoir quand utiliser la bonne structure de données au bon moment :

- **Tableau** : les éléments sont contigus en mémoire, la taille du tableau ne change pas et est connu à l'avance, l'ajout et la suppression d'un élément du tableau sont des opérations couteuses en temps et en mémoire, en revanche on peut aisément accéder à un élément du tableau en temps constant (par exemple en C : `tableau[2]`).
- **Liste chaînée** : les éléments ne sont pas contigus en mémoire, la taille peut varier, on peut facilement insérer/supprimer des éléments de la liste en temps constant, mais on ne peut pas accéder à un élément précis de la liste instantanément (il faut parcourir la liste jusqu'à cet élément).

Pour illustrer les différences entre liste chaînée et tableau, prenons l'exemple d'un étudiant qui prend ses cours :

- Un tableau est comme un cahier de cours : on commence au début du cahier pour ne pas gaspiller de l'espace, et on écrit son cours au fur et à mesure jusqu'à ne plus avoir de place. Si on rate un cours, on a deux choix : soit on laisse de l'espace pour permettre de recopier le cours plus tard, mais dans ce cas l'espace sera soit trop petit (plus de place), soit trop grand (gaspillage d'espace), soit on recopie tout le cahier en incluant la partie qui manque, cependant cette méthode est longue et demande un autre cahier.
- Une liste chaînée serait comme un classeur : on commence où on souhaite dans le classeur, on écrit son cours sur des feuilles volantes toutes indépendantes les unes des autres et on peut les insérer ou les supprimer dans le classeur facilement. Si on est absent pendant un cours, il suffit de copier le cours sur une feuille à part, puis de la placer entre deux feuilles dans le classeur.

![Exemple d'ajout d'élément dans une liste chaînée](/static/img/algo/structure/liste_chainee/exemple_ajout.png)

![Exemple de suppression d'un élément dans une liste chaînée](/static/img/algo/structure/liste_chainee/exemple_suppression.png)

## Quelques fonctions pour manipuler les listes chaînées

Pour manipuler correctement les listes chaînées, il faut connaître quelques fonctions basiques pour ajouter un élément, le supprimer, rechercher un élément précis dans la liste, etc.

```
creerListe :
   Créer un premier élément
   Initialiser les données de l'élément
   Le faire pointer sur NULL (pour indiquer la fin de la liste)
   Retourner l'élément
supprimerListe :
   Pour chaque élément de la liste
      Supprimer l'élément actuel

ajoutEnTete (élément) :
   Faire pointer le nouvel élément vers le premier élément de la liste
ajoutEnFin (élément) :
   Parcourir la liste jusqu'à la fin
   Faire pointer le dernier élément vers l'élément donné en paramètre
   Faire pointer l'élément donné en paramètre sur NULL
ajoutElement (élément, index) :
   Parcourir la liste jusqu'à arriver à l'élément situé avant l'index donné
   Faire pointer l'élément actuel sur le nouvel élément
   Faire pointer le nouvel élément sur le prochain élément

supprimerEnTete :
   Supprimer l'élément en tête de liste
supprimerEnFin :
   Parcourir la liste jusqu'à l'avant-dernier élément
   Faire pointer l'élément sur NULL (pour indiquer la fin de la liste)
   Supprimer l'élément suivant
supprimerElement (index) :
   Parcourir la liste jusqu'à arriver à l'élément situé avant l'index donné
   Faire pointer l'élément actuel sur le pointeur de l'élément à supprimer 
   Supprimer l'élément suivant

afficher :
   Pour chaque élément de la liste
      Afficher les données de l'élément actuel

estVide :
   Si l'élément en début de liste pointe vers NULL
      Retourner vrai
   Sinon
      Retourner faux

taille :
   Pour chaque élément de la liste
      Incrémenter nbElement
   Retourner nbElement
```

## Complexité

Soit *N* le nombre d'éléments de la liste chaînée.

- `creerListe` : *O(1)*
- `supprimerListe` : *O(N)*
- `ajoutEnTete` : *O(1)*
- `ajoutEnFin` : *O(N)*
- `ajoutElement` : *O(N)*
- `supprimerEnTete` : *O(1)*
- `supprimerEnFin` : *O(N)*
- `supprimerElement` : *O(N)*
- `afficher` : *O(N)*
- `estVide` : *O(1)*
- `taille` : *O(N)*

## Implémentation

Une implémentation en C des fonctions présentées au-dessus :

main.c :

Le code est relativement simple à comprendre et à utiliser, une connaissance des pointeurs est cependant nécessaire.

Si vous programmez en C++, la [STL](https://fr.wikipedia.org/wiki/Standard_Template_Library) (*Standard Template Library*) fournit une implémentation de liste chaînée ainsi que des fonctions de base pour les manipuler : <http://www.cplusplus.com/reference/list/list/>.

## Variantes de la liste chaînée

Il existe plusieurs variantes de la liste chaînée qui sont pratiques dans certains problèmes précis.

### Liste doublement chaînée

La liste double chaînée (*doubly linked list*) consiste à ce que chaque élément de la liste possède deux pointeurs :

- Un pointeur vers le **prochain** élément.
- Un pointeur vers le **précédent** élément.

Cette structure est légèrement plus coûteuse en mémoire et en opération, mais rend le déplacement au sein de la liste plus pratique car on peut la parcourir dans les deux sens et on peut insérer/supprimer des éléments avant d'autres et non uniquement après.

![Exemple de représentation d'une liste doublement chaînée](/static/img/algo/structure/liste_chainee/exemple_liste_doublement_chainee.png)

### Liste chaînée circulaire

La liste chaînée circulaire (*circular linked list*) est une liste chaînée ne possédant pas de fin. En effet, le pointeur de fin de liste pointe vers le début de la liste formant ainsi un cycle.
 
![Exemple de représentation d'une liste chaînée circulaire](/static/img/algo/structure/liste_chainee/exemple_liste_chainee_circulaire.png)

Lorsque vous utilisez des listes chaînées circulaires, il faut faire attention à ne pas tomber dans une boucle infinie lors du parcours de la liste.

### Liste doublement chaînée circulaire

Une liste doublement chaînée circulaire (*doubly circular linked list*) est simplement un regroupement des deux dernières variantes.

![Exemple de représentation d'une liste doublement chaînée circulaire](/static/img/algo/structure/liste_chainee/exemple_liste_doublement_chainee_circulaire.png)

### D'autres variantes plus complexes

En plus de ces variantes assez "courantes", on peut retrouver d'autres variantes plus compliquées mais utiles dans certains cas précis :

- **Liste à enjambements** (*skip list*) : ensemble de listes chaînées stockées "parallèlement" et qui permet de sauter des éléments en fonction de nos besoins, pratique pour trier et rechercher. (<https://en.wikipedia.org/wiki/Skip_list>).
- **Chaînage XOR** (*XOR linked list*) : permet de diminuer le coût en mémoire des listes doublement chaînées grâce à l'opération bit à bit XOR (<https://en.wikipedia.org/wiki/XOR_linked_list>).
- **Liste chaînée déroulée** (*unrolled linked list*) : cette variante stocke plusieurs éléments au lieu d'un seul par nœud, et fait office de compromis entre un tableau et une liste que l'on peut modifier pour qu'elle se rapproche plus de l'un que de l'autre selon les besoins (<https://en.wikipedia.org/wiki/Unrolled_linked_list>).
- **VList** : comme la précédente c'est un compromis qui stocke des tableaux d'éléments plutôt qu'un unique élément dans chaque nœud, excepté que cette fois ci les tableaux sont de tailles variables contrairement à une liste chaînée déroulée où les tableaux sont tous de tailles fixes (<https://en.wikipedia.org/wiki/VList>).

## Conclusion

La liste chaînée est donc une structure de données très souple, et efficace pour insérer et supprimer des éléments simplement. De plus, on peut la modifier afin de créer de nouvelles structures de données différentes comme la liste doublement chaînée, la liste chaînée circulaire, mais aussi pour créer une [pile](http://napnac.ga/algo/structure/pile.html) ou encore une [file](http://napnac.ga/algo/structure/file.html).

Les listes chaînées sont aussi la base de structures de données plus complexes comme les [tables de hachage](http://napnac.ga/algo/structure/table_hachage.html), les [arbres](http://napnac.ga/algo/structure/arbre.html), les [graphes](http://napnac.ga/algo/structure/graphe.html), et de nombreuses variantes de listes chaînées existent.
