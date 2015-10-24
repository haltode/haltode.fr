ASCII Funfair
=============
projets/

Date du projet : juin 2013 à septembre 2013  
*Modifié le 11/10/2015*

## Introduction

ASCII Funfair est l’un de mes premiers projets en C, et c’était la première fois que j’utilisais Github (vous noterez aussi que je ne savais pas encore utiliser plusieurs fichiers sources, comme quoi on apprend tous un jour n'est-ce pas ?), donc ne vous étonnez pas de la qualité assez basse de ce projet. ASCII Funfair était plus un projet d’entraînement (je me mettais à la programmation en C) et de test. En effet, j’ai codé plusieurs IA de différents niveaux ainsi que les jeux allant avec, et j’ai voulu commencer à utiliser les couleurs et d’autres éléments de la console (pour le pacman notamment).

## Qu'est-ce que ASCII Funfair ?

ASCII Funfair est une plate-forme de jeux, avec un système de solo et de multijoueur.

Dans le **solo** vous devrez débloquer les jeux à l’aide de points que vous gagnez au fur et à mesure des parties que vous réalisez. Des sauvegardes sont mises en places pour vous permettre de jouer à plusieurs sur le même ordinateur. Vous pouvez facilement créer/charger/supprimer une sauvegarde depuis le menu.

Il y a 8 jeux différents dans ASCII Funfair :

- **Plus ou moins** : Consiste à trouver un nombre tiré au hasard par l’ordinateur.
- **Pendu** : Le très célèbre jeu du Pendu, où le but est de trouver le mot tiré au hasard par l’ordinateur.
- **Morpion** : Le but du morpion est d’aligner 3 pions (horizontalement, verticalement et en diagonale) sur une grille de 3 par 3 avant que l’ordinateur ne le fasse.
- **Puissance 4** : Consiste à aligner 4 pions (horizontalement, verticalement et en diagonale) sur une grille de 6 par 7 avant que l’ordinateur ne puisse le faire.
- **Mastermind** : Le but du jeu ici est de trouver une combinaison de couleur tirée au hasard par l’ordinateur en moins de 10 coups, celui-ci vous indiquera à chaque fois le nombre de pions de la bonne couleur et bien placés, et le nombre de pions de la bonne couleur mais mal placés.
- **Bataille navale** : Placez vos navires sur une grille de 10 par 10 et détruisez les navires ennemis à coup de torpille avant que les vôtres ne le soient.
- **Pacman** : Vous incarnez pacman, un personnage dont le but est de ramasser toutes les pac-gommes sans se faire manger par les fantômes.
- **Roulette russe** : Vous avez du courage ? Alors placez 2 balles dans un revolver, tournez le barillet, faites le pointer sur votre tempe et tirez ! Si vous êtes chanceux vous en serez récompensé mais dans le cas contraire ...

Tous les jeux (où l’IA est nécessaire, c’est-à-dire le plus ou moins, le morpion, le puissance 4 et la bataille navale) disposent de 3 niveaux de difficultés (facile, normal, difficile). Plus le niveau est élevé, plus vous gagnerez de points.

Il y a deux sortes de points :

- **Les points normaux** : Ils se gagnent en jouant à n’importe quels jeux.
- **Les points VIP** : Ils se gagnent plus difficilement, et permettent de débloquer le prochain jeu directement sans utiliser vos points normaux. Pour en gagner il faut par exemple trouver le nombre mystère du plus ou moins en moins de deux coups, etc. (une liste complète est disponible dans l’aide du jeu).

Un magasin est mis à votre disposition, pour vous permettre de débloquer vos jeux.

Dans le **multijoueur**, vous pouvez accéder à tous les jeux (compatibles en multijoueur) pour y jouer à deux. Dans ce mode de jeux, il n’y a pas de points à gagner ou autre, vous avez simplement à choisir le jeu auquel vous souhaitez jouer.

ASCII Funfair est un programme réalisé en **console**, **libre de droit**, et n’utilise **aucune librairie externe** !

## Lien

Le lien vers la page Github du projet : <https://github.com/iTech-/ASCII-Funfair>
