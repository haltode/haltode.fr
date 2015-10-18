Liste chaînée
=============
algo/structure/

Publié le : 08/06/2014
*Modifié le *

## Introduction

Une liste chaînée (*linked list* en anglais) est une structure de données très utilisée en programmation et est fondamentale pour implémenter d'autres structure de données. On utilise une liste chaînée principalement pour permettre l'insertion et la suppression d'éléments bien plus facilement qu'avec un tableau par exemple.

## Principe de la liste chaînée

Une liste chaînée est une structure de données auto-référentielle, c'est-à-dire que chacun de ses éléments pointe vers l'élément suivant que l'on appelle alors des **noeuds**. A partir de cette définition on peut donc déjà définir le contenu d'un élément d'une liste chaînée :

- **Des données** : ces données peuvent être de n'importe quels types (entier, flottant, chaîne de caractère etc.), et il peut en y avoir autant que possible par élément.
- **Un pointeur** : ce pointeur pointe vers l'élément suivant de la liste.

Voici une représentation d'une liste chaînée que l'on pourrait faire :

+---------------+        +---------------+        +---------------+
|Pointeur       |+------>|Pointeur       |+------>|Pointeur (NULL)|
|---------------|        |---------------|        |---------------|
|Données        |        |Données        |        |Données        |
|               |        |               |        |               |
|               |        |               |        |               |
|               |        |               |        |               |
+---------------+        +---------------+        +---------------+

Le dernier pointeur de la liste chaînée pointe sur la valeur *NULL*, pour indiquer la fin de la liste.

Les listes chaînées vous font sans doute penser à un tableau, mais elles sont très différentes :

- Imaginez qu'un tableau est comme un cahier de cours : vous commencez au début du cahier, et vous écrivez votre cours au fur et à mesure jusqu'à la fin du cahier. Si vous avez été absent, et que vous souhaitez rattraper le cours vous avez deux choix : soit vous laisser de l'espace pour vous permettre de recopier le cours, mais dans ce cas l'espace sera soit trop petit (plus de place), soit trop grand (gaspillage d'espace). Soit vous recopier tout votre cahier en incluant la partie ou vous étiez absent, cependant cette méthode est longue et coûteuse.
- Imaginez qu'une liste chaînée est comme un classeur : vous commencez où vous souhaitez dans votre classeur, vous écrivez votre cours sur des feuilles toutes indépendantes les unes des autres et vous pouvez les insérer ou les supprimer dans votre classeur très simplement. Si vous êtes malade, il vous suffit donc d'ouvrir les anneaux du classeur, de placer les feuilles du cours que vous avez manquées, et de refermer les anneaux.

Voici comment se déroule l'ajout d'un élément dans une liste chaînée :

Nouvel élément
v
+---------------+
+--->|Pointeur       +----+
|    |---------------|    |
|    |Données        |    |
|    |               |    |
|    |               |    |
|    |               |    |
|    +---------------+    |
|                         |
|                         v
+------+--------+        +---------------+        +---------------+
|Pointeur       |        |Pointeur       |+------>|Pointeur (NULL)|
|---------------|        |---------------|        |---------------|
|Données        |        |Données        |        |Données        |
|               |        |               |        |               |
|               |        |               |        |               |
|               |        |               |        |               |
+---------------+        +---------------+        +---------------+

Et voici comment se passe la suppression d'un élément :

+-------------------------------------------------+
|                                                 |
|                                                 |
|                Élément supprimé                 |
|                       v                         v
+-------+-------+        +---------------+        +---------------+
|Pointeur       |        |Pointeur       |        |Pointeur (NULL)|
|---------------|        |---------------|        |---------------|
|Données        |        |Données        |        |Données        |
|               |        |               |        |               |
|               |        |               |        |               |
|               |        |               |        |               |
+---------------+        +---------------+        +---------------+

## Quelques fonctions pour manipuler les listes chaînées

Dans cette partie je vais vous présenter des fonctions de bases vous permettant de manipuler facilement les listes chaînées comme ajouter un élément, supprimer un élément, rechercher un élément etc.

### Créer une liste

Créer une nouvelle structure de donnée de type liste chaînée
Initialiser le premier élément de la liste
Retourner la nouvelle structure

### Supprimer la liste

Parcourir la liste jusqu'à la fin
Supprimer l'élément actuel

### Ajouter un élément en tête de liste

Créer le nouvel élément
Affecter les données souhaitées à l'élément
Faire pointer le nouvel élément vers le début de la liste

### Ajouter un élément en fin de liste

Créer le nouvel élément
Affecter les données souhaitées à l'élément
Parcourir la liste jusqu'à la fin
Faire pointer l'élément actuel (l'élément de fin de liste) au nouvel élément
Faire pointer le nouvel élément à la valeur NULL (pour indiquer la fin de la liste)

### Ajouter un élément à un endroit précis de la liste

Créer le nouvel élément
Affecter les données souhaitées à l'élément
Parcourir la liste jusqu'à arriver à l'élément situé avant l'index indiqué en paramètre
Faire pointer l'élément actuel vers le nouvel élément
Faire pointer le nouvel élément vers l'élément suivant

### Supprimer un élément en tête de liste

Faire pointer l'élément de tête de liste vers le pointeur de l'élément suivant
Supprimer l'élément en tête de liste

### Supprimer un élément en fin de liste

Parcourir la liste jusqu'à arriver à l'avant dernier élément
Faire pointer l'élément actuel à la valeur NULL (pour indiquer la fin de la liste)
Supprimer l'élément suivant (le dernier élément)

### Supprimer un élément à un endroit précis de la liste

Parcourir la liste jusqu'à arriver à l'élément situé avant l'index indiqué en paramètre
Faire pointer l'élément actuel vers le pointeur de l'élément suivant
Supprimer l'élément suivant (celui indiqué par l'index en paramètre)

### Afficher la liste

Parcourir la liste jusqu'à la fin
Afficher les données de l'élément actuel

### Est vide ?

Si l'élément en début de liste pointe vers NULL (indique la fin de liste)
Retourner 1
Sinon
Retourner 0

### Nombre d'élément dans la liste

Parcourir la liste jusqu'à la fin
Incrémenter un compteur (initialiser à 0)
Retourner le compteur

## Implémentation

Voici une implémentation en C des fonctions que je vous ai présentées :

main.c : <http://git.io/vtzfd>
main.h : <http://git.io/vtzJW>

Le code est relativement simple à comprendre et à utiliser, une connaissance des pointeurs est nécessaire.

## Variantes de la liste chaînée

Il existe plusieurs variantes de la liste chaînée qui sont pratiques dans certains problèmes.

### Liste doublement chaînée

Cette variante consiste à ce que chaque élément de la liste possède deux pointeurs :

- Un pointeur vers le prochain élément.
- Un pointeur vers le précédent élément.

Cette structure est plus coûteuse en mémoire et en opération, cependant elle permet d'insérer un élément avant un autre bien plus facilement à l'aide du nouveau pointeur.

+---------------+        +---------------+        +---------------+
|Pointeur       |+------>|Pointeur       |+------>|Pointeur (NULL)|
|---------------|        |---------------|        |---------------|
|Données        |        |Données        |        |Données        |
|               |        |               |        |               |
|---------------|        |---------------|        |---------------|
|Pointeur (NULL)|<------+|Pointeur       |<------+|Pointeur       |
+---------------+        +---------------+        +---------------+

### Liste chaînée circulaire

La liste chaînée circulaire est une liste chaînée ne possédant pas de "fin". En effet, le pointeur de fin de liste pointe vers le début de la liste formant ainsi un cycle.

+-------------------------------------------------+
|                                                 |
|                                                 |
v                                                 +
+---------------+        +---------------+        +---------------+
|Pointeur       |+------>|Pointeur       |+------>|Pointeur       |
|---------------|        |---------------|        |---------------|
|Données        |        |Données        |        |Données        |
|               |        |               |        |               |
|               |        |               |        |               |
|               |        |               |        |               |
+---------------+        +---------------+        +---------------+

Lorsque vous utilisez des listes chaînées circulaires, il faut faire attention à ne pas tomber dans une boucle infinie.

### Liste doublement chaînée circulaire

Cette variante combine tout simplement les deux dernières.

+-------------------------------------------------+
|                                                 |
|                                                 |
v                                                 +
+---------------+        +---------------+        +---------------+
|Pointeur       |+------>|Pointeur       |+------>|Pointeur       |
|---------------|        |---------------|        |---------------|
|Données        |        |Données        |        |Données        |
|               |        |               |        |               |
|---------------|        |---------------|        |---------------|
|Pointeur       |<------+|Pointeur       |<------+|Pointeur       |
+---------------+        +---------------+        +---------------+
			  +                                                 ^
					|                                                 |
					|                                                 |
					+-------------------------------------------------+

## Conclusion

La liste chaînée est donc une structure de données très modulable, et efficace pour insérer et supprimer des éléments. De plus, la liste chaînée est la base de nombreuses autres structures de données.

