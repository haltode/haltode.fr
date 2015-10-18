Pile
====
algo/structure

Publié le : 08/06/2014  
*Modifié le :*

## Introduction

Une pile (*stack* en anglais) est une structure de données de type **LIFO** (**L**ast **I**n **F**irst **O**ut, *dernier arrivé premier sorti*).

## Principe de la pile

Une pile fonctionne exactement comme une pile d’assiettes :

- Quand on ajoute une assiette sur la pile on l’ajoute en haut.
- Quand on enlève une assiette de la pile on enlève celle du haut pour ne pas faire tomber le reste.

C’est le principe LIFO, lorsqu’on ajoute un élément sur une pile il est en haut, et lorsqu’on retire un élément de la pile, on retire l’élément tout en haut.

Voici comment on pourrait représenter une pile :

+----------------------+
|                      |
|                      |
3  |        Données       |
|                      |
+----------------------+
|                      |
|                      |
2  |        Données       |
|                      |
+----------------------+
|                      |
|                      |
1  |        Données       |
|                      |
+----------------------+
|                      |
|                      |
0  |        Données       |
|                      |
+----------------------+

L’action d’ajouter un élément dans la pile est appelée : **empiler** (ou *push* en anglais) :

+------------------------------+
|                              |
v                              |
+----------------------+                   |
|                      |                   |
|                      |                   |
2  |           16         |                   |
|                      |                   +
+----------------------+        +----------------------+
|                      |        |                      |
|                      |        |                      |
1  |           7          |        |           9          |
|                      |        |                      |
+----------------------+        +----------------------+
|                      |
|                      |              Nouvel élément
0  |           42         |
|                      |
+----------------------+

Pile

L’action d’enlever un élément de la pile est appelée : **dépiler** (ou *pop* en anglais) :

+----------------------+
|                      |
|                      |
3  |           9          |+-----------+
|                      |            |
+----------------------+            |
|                      |            |
|                      |            |
2  |           16         |            |
|                      |            |
+----------------------+            |
|                      |            |
|                      |            |
1  |           7          |            |
|                      |            |
+----------------------+            v
|                      |
|                      | L'élément est enlevé de la pile et supprimé
0  |           42         |
|                      |
+----------------------+

Pile

Pour représenter une pile, je vais vous présenter deux moyens :

- Avec une liste chaînée.
- Avec un tableau ainsi qu’un index nous indiquant le prochain élément libre dans la pile. Cet index est appelé pointeur de pile (ou *stack pointer* en anglais, abrégé *SP*).

## Quelques fonctions pour manipuler une pile

### Créer une pile (liste chaînée)

Créer une nouvelle structure de données de type Pile
Initialiser la structure
Retourner la nouvelle structure

### Créer une pile (tableau)

Créer un tableau d'une taille suffisamment grande pour la pile
Initialiser PP à 0

### Supprimer une pile (liste chaînée)

Parcourir la pile jusqu'à la fin
Supprimer l'élément actuel de la pile

### Supprimer une pile (tableau)

Supprimer le tableau

### Empiler (liste chaînée)

Créer le nouvel élément
Affecter les données souhaitées au nouvel élément
Faire pointer le haut de la pile vers l'élément

### Empiler (tableau)

Affecter les données souhaitées à l'index PP du tableau
Incrémenter PP

### Dépiler (liste chaînée)

Sauvegarder les données de l'élément situé en haut de la pile
Faire pointer le haut de la pile vers l'élément suivant
Supprimer l'élément en haut de la pile
Retourner les données sauvegardées

### Dépiler (tableau)

Décrémenter PP
Retourner l'élément d'index PP du tableau

### Afficher

Parcourir la pile
Afficher les données de l'élément actuel

### Est vide ? (liste chaînée)

Si le premier élément de la pile pointe vers NULL
Retourner 1
Sinon
Retourner 0

### Est vide ? (tableau)

Si PP est égal à 0
Retourner 1
Sinon
Retourner 0

### Nombre d’élément dans la pile (liste chaînée)

Parcourir la pile jusqu'à la fin
Incrémenter un compteur (initialisé à 0)
Retourner le compteur

### Nombre d’élément dans la pile (tableau)

Retourner PP

## Implémentation

### Liste chaînée

Le lien vers une implémentation en C d’une pile à l’aide d’une liste chaînée :

main.c : http://git.io/vtzJj
main.h : http://git.io/vtzUk

Le code est simple et ne nécessite pas d’explication.

### Tableau

Le lien vers une implémentation en C d’une pile à l’aide d’un tableau :

main.c : http://git.io/vtzUG
main.h : http://git.io/vtzUn

Cette implémentation a pour but d’être extrêmement simple à utiliser, comprendre et à implémenter.

## Conclusion

La pile est donc une structure de données très pratique, et facile à implémenter.
