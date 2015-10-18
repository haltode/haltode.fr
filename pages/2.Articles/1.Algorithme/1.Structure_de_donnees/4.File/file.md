File
====
algo/structure/

Publié le : 08/06/2014  
*Modifié le :*

## Introduction

Une file (*queue* en anglais) est une structure de données de type **FIFO** (**F**irst **I**n **F**irst **O**ut, *premier entré premier sorti*).

## Principe de la file

Une file fonctionne exactement comme une file d’attente dans un magasin :

- Le premier client arrivé dans la file sera le premier servi.
- Le dernier client arrivé dans la file sera le dernier servi.

Voici comment on pourrait représenter une file :

+---------+    +---------+    +---------+
Entrée +-> | Pointeur|+-->| Pointeur|+-->| Pointeur| +-> Sortie
|---------|    |---------|    |---------|
| Données |    | Données |    | Données |
|         |    |         |    |         |
+---------+    +---------+    +---------+

L’action d’ajouter un élément dans la file est appelé : **enfiler** (ou *enqueue* en anglais) :

+---------+    +---------+    +---------+
Entrée +-> | Pointeur|+-->| Pointeur|+-->| Pointeur| +-> Sortie
^      |---------|    |---------|    |---------|
|      | Données |    | Données |    | Données |
|      |         |    |         |    |         |
|      +---------+    +---------+    +---------+
|
|
+
+---------+
| Pointeur|
|---------|
| Données |
|         |
+---------+

Nouvel élément

L’action d’enlever un élément de la file est appelé : **défiler** (ou *dequeue* en anglais) :

+---------+    +---------+    +---------+
Entrée +-> | Pointeur|+-->| Pointeur|+-->| Pointeur| +-> Sortie
|---------|    |---------|    |---------|       ^
| Données |    | Données |    | Données |       |
|         |    |         |    |         |+------+
+---------+    +---------+    +---------+

Élément à enlever

Cette fois-ci je ne vous montrerai qu’un seul moyen d’implémenter la file : la [liste chaînée](http://napnac.ga/algo/structure/liste_chainee.html). Tout simplement car les tableaux ne sont pas du tout adaptés à ce genre de structure de données car il faudrait décaler chaque élément lorsqu’on enfilera un élément ce qui est lourd et inutile en opérations.

## Quelques fonctions pour manipuler une file

### Créer une file

Créer une nouvelle structure de données de type File
Initialiser la structure
Retourner la nouvelle structure

### Supprimer une file

Parcourir la file jusqu'à la fin
Supprimer l'élément actuel

### Enfiler

Créer le nouvel élément
Affecter les données souhaitées au nouvel élément
Faire pointer le nouvel élément vers le début de la file

### Défiler

Parcourir la file jusqu'à l'avant dernier élément
Sauvegarder les données du dernier élément
Faire pointer l'avant dernier élément vers NULL 
Supprimer le dernier élément
Retourner les données sauvegardées

### Afficher

Parcourir la file jusqu'à la fin
Afficher l'élément actuel

### Est vide ?

Si le premier élément de la file pointe vers NULL
Retourner 1
Sinon
Retourner 0

### Nombre d’élément dans la file

Parcourir la file
Incrémenter un compteur (initialisé à 0)
Retourner le compteur

## Implémentation

Le lien vers une implémentation en C d’une file :

main.c : http://git.io/vtzUE
main.h : http://git.io/vtzUg

Aucun commentaires à faire sur cette implémentation.

## Conclusion

La file est donc une structure de données utile lorsqu’il s’agit d’implémenter une file d’attente.
