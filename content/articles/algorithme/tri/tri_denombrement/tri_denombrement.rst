Introduction
------------

Le tri par dénombrement (*counting sort* en anglais) est l’un des
algorithmes de tri le plus rapide, et pourtant il est loin d'être
compliqué, même s'il a quelques restrictions et défauts. Le tri
s'exécute en un temps linéaire, mais uniquement sur des nombres entiers.
La particularité du tri est qu'il est la base d'autres algorithmes de
tri en temps linéaires, permettant de s'adapter aux besoins en temps et
en mémoire.

Principe de l’algorithme
------------------------

Le principe est simple, on parcourt le tableau et on compte le nombre de
fois que chaque élément apparaît. Une fois qu’on a le tableau des
effectifs *E* (avec *E[i]* le nombre de fois où *i* apparaît dans le
tableau), on peut le parcourir dans le sens croissant (pour un tri
croissant), ou décroissant (pour un tri décroissant) et placer dans le
tableau trié *E[i]* fois l’élément *i* (avec *i* allant de l’élément
minimum du tableau jusqu’à l’élément maximum).

Exemple
-------

Voici un tableau d’entier que l’on souhaite trier dans l’ordre croissant
en utilisant le tri par dénombrement : 8, 6, 1, 3, 8, 1, 1.

La première étape est de créer notre tableau des effectifs *E*, la
deuxième est simplement de le parcourir et de recopier dans le tableau
trié les valeurs :

+---+------+------------------------+---------------+
| i | E[i] | Action                 | Tableau trié  |
+===+======+========================+===============+
| 0 | 0    | on ne fait rien        |               |
+---+------+------------------------+---------------+
| 1 | 3    | on ajoute trois fois 1 | 1 1 1         |
+---+------+------------------------+---------------+
| 2 | 0    | on ne fait rien        | 1 1 1         |
+---+------+------------------------+---------------+
| 3 | 1    | on ajoute une fois 3   | 1 1 1 3       |
+---+------+------------------------+---------------+
| 4 | 0    | on ne fait rien        | 1 1 1 3       |
+---+------+------------------------+---------------+
| 5 | 0    | on ne fait rien        | 1 1 1 3       |
+---+------+------------------------+---------------+
| 6 | 1    | on ajoute une fois 6   | 1 1 1 3 6     |
+---+------+------------------------+---------------+
| 7 | 0    | on ne fait rien        | 1 1 1 3 6     |
+---+------+------------------------+---------------+
| 8 | 2    | on ajoute deux fois 8  | 1 1 1 3 6 8 8 |
+---+------+------------------------+---------------+

On a atteint le maximum de notre tableau des effectifs *E*, notre
tableau est donc trié :

1, 1, 1, 3, 6, 8, 8.

Défauts
-------

Cependant cet algorithme possède des défauts (même s'il s’exécute en
temps linéaire) :

-  Il ne s’applique que si les nombres du tableau sont des entiers, car
   je vous rappelle qu'on a *E* un tableau des effectifs avec *E[i]* le
   nombre de fois où *i* apparaît dans le tableau, donc si *i* est un
   nombre décimal on ne pourra pas le stocker dans notre tableau des
   effectifs car il faut que l’indice du tableau soit un nombre entier.
   Pour ce qui est des nombres négatifs, on peut contourner le problème
   si on connait le minimum du tableau, dans ce cas on peut le
   considérer comme le "nouveau 0" et on décale tous les autres éléments
   de *min* rangs vers la droite afin de toujours avoir des nombres
   positifs (il ne faut pas oublier de décaler vers la gauche lorsqu'on
   veut accéder à notre nombre initial).
-  La complexité en mémoire est mauvaise car l'algorithme peut prendre
   très vite beaucoup de place. En effet, le tableau des effectifs *E* a
   pour taille la valeur maximale du tableau, or si cette valeur est
   très grande, le tableau *E* prendra énormément de place en mémoire.
   De plus si les valeurs du tableau sont éloignées entre elles, alors
   beaucoup d’espace mémoire restera inutilisé.

Cet algorithme est donc très efficace, mais il faut savoir faire un
choix entre rapidité et stockage (en plus de ne pas pouvoir l'utiliser
sur autres choses que des entiers).

Pseudo-code
-----------

Le pseudo-code de l’algorithme :

.. code:: nohighlight

   triDénombrement :

      Chercher l'élément maximum du tableau
      Créer un tableau E de taille Max + 1, initialisé à 0

      Pour chaque élément du tableau
         Incrémenter E[Tableau[i]]

      Pour chaque élément de E
         Recopier E[i] fois le nombre i dans le tableau trié

Complexité
----------

La complexité en temps de cet algorithme se calcule assez facilement. En
effet, les seules opérations que l'on effectue dans notre fonction se
font en temps linéaire. L'initialisation du tableau des effectifs se
fait en :math:`O(N)` (avec :math:`N` la taille du tableau en entrée), et
la copie des éléments dans notre tableau trié en :math:`O(M)` (avec
:math:`M` correspondant à ``Max``).

La complexité finale de notre algorithme est donc :math:`O(N + M)`, soit
une complexité en temps linéaire.

Implémentation
--------------

L'implémentation en C du tri par dénombrement :

[[secret="tri_denombrement.c"]]

.. code:: c

   #include <stdio.h>
   #include <stdlib.h>

   #define TAILLE_MAX 1000

   int tableau[TAILLE_MAX];
   int taille;

   void triDenombrement(void)
   {
      int iTab, iEffectif;
      int max;
      int *effectif;

      max = -42;
      for(iTab = 0; iTab < taille; ++iTab)
         if(tableau[iTab] > max)
            max = tableau[iTab];

      effectif = calloc(max + 1, sizeof(int));

      for(iTab = 0; iTab < taille; ++iTab)
         ++effectif[tableau[iTab]];

      for(iEffectif = 0, iTab = 0; iEffectif <= max; ++iEffectif) {
         int iCopie;
         for(iCopie = 0; iCopie < effectif[iEffectif]; ++iCopie) {
            tableau[iTab] = iEffectif;
            ++iTab;
         }
      }

      free(effectif);
   }

   int main(void)
   {
      int iTab;

      scanf("%d\n", &taille);

      for(iTab = 0; iTab < taille; ++iTab)
         scanf("%d ", &tableau[iTab]);

      triDenombrement();

      for(iTab = 0; iTab < taille; ++iTab)
         printf("%d ", tableau[iTab]);
      printf("\n");

      return 0;
   }

J'utilise la fonction `calloc
<http://www.cplusplus.com/reference/cstdlib/calloc/>`__ lors de l'allocation
afin d'avoir mon tableau directement initialisé à 0.

[[/secret]]

Notre tableau en entrée :

.. code:: nohighlight

   7
   8 6 1 3 8 1 1

La sortie obtenue :

.. code:: nohighlight

   1 1 1 3 6 8 8

Conclusion
----------

Le tri par dénombrement est donc un algorithme de tri assez restrictif
(il ne travaille qu'avec des nombres entiers), et doit obliger des
compromis de mémoire pour avoir une complexité en temps linéaire.
Cependant, quand on connait l'entrée, on peut utiliser cet algorithme
afin d'avoir un temps d'exécution très rapide, mais on peut aussi
changer le fonctionnement de ce tri afin d'améliorer la complexité en
mémoire, sans trop impacter la complexité en temps, et c'est ce que fait
le `tri par base </algo/tri/tri_base.html>`__ qui est un autre
algorithme en temps linéaire inspiré du tri par dénombrement. On le
retrouve aussi dans le `tri par
paquets <https://en.wikipedia.org/wiki/Bucket_sort>`__ qui permet de
faire des améliorations de manières générales en temps et en mémoire à
ce dernier.
