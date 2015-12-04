Pseudo-C
========
projets/

Publié le : 01/03/2015  
*Modifié le : 01/11/2015*

## Introduction

Le Pseudo-C est la toute première idée de projet qui m'est venue à l'esprit. J'ai eu cette idée au début de mon apprentissage de la programmation quand je découvrais pour la première fois [France-IOI](http://www.france-ioi.org/) et que j'apprenais à utiliser du [pseudo-code](https://en.wikipedia.org/wiki/Pseudocode). Je me suis dis que je pouvais mélanger mes connaissances en C avec ce nouveau langage que je venais de découvrir afin de m'entraîner, et j'ai ainsi créé le Pseudo-C.

## Qu'est-ce que le Pseudo-C ?

Le Pseudo-C est un traducteur/interpréteur permettant de transformer du code écrit en pseudo-code (l'entrée) directement en langage C (la sortie).

Le Pseudo-C permet de traduire des programmes entiers pouvant contenir :

- Des variables (entiers, flottants, caractères, et chaînes de caractères)
- Des tableaux (de n'importe quels types de variables)
- Des affectations
- Des appels à des fonctions (pour lire, écrire, etc.)
- Des conditions
- Des boucles
- etc.

Voici par exemple le fameux programme affichant "Hello World !" en pseudo-code (entrée) :

```nohighlight
Debut
  Afficher "Hello World !\n"
Fin
```

Et voici le fichier en C obtenu (sortie) :

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

int main(void)
{
    printf("Hello World !\n");
    return 0;
}
```

Le Pseudo-C inclut une gestion des erreurs dans l'entrée, ainsi qu'un système de paramètre permettant de choisir le mode de l'entrée et le mode de sortie (depuis un fichier ou directement dans la console).

## Anecdote

J'avais implémenté quelques fonctions bien particulières (`Aleatoire`, `Pause`, `Effacer`) pour un petit concours organisé sur le [forum](https://openclassrooms.com/forum/sujet/atelier-fond-anime-space-invaders?security_interactive_login=1&page=1) du feu site du zéro dans le but d'afficher des petits aliens de space invader, le programme est toujours présent sur la page du projet et il marche encore (mon post sur le forum : <https://openclassrooms.com/forum/sujet/atelier-fond-anime-space-invaders?security_interactive_login=1&page=7#message-84297475>).

## Lien

Le lien vers la page Github du projet (avec une description plus précise de la syntaxe et du fonctionnement de ce programme) : <https://github.com/iTech-/Pseudo-C>
