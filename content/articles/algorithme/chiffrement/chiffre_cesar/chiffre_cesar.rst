Introduction
------------

Les premiers algorithmes de chiffrement ne datent pas de Jules César,
mais ce dernier va instaurer un système au sein de son empire, afin de
communiquer sans que personnes ne puissent intercepter ses messages
secrets. Pour cela, il utilisait une méthode très simple qui consistait
à décaler chaque lettre de trois rangs vers la droite dans l'alphabet
pour que le message paraisse alors incompréhensible, à part pour la
personne connaissant l'astuce. L'empereur a ainsi donné le nom à l'un
des premiers algorithmes de chiffrement : le chiffre de César.

Principe de l’algorithme
------------------------

Le chiffre de César (aussi appelé *chiffrement par décalage*) utilise
une `substitution
mono-alphabétique <https://en.wikipedia.org/wiki/Substitution_cipher>`__
pour chiffrer et déchiffrer un message, c’est-à-dire que l’on décale de
:math:`x` rangs vers la droite dans l’alphabet la lettre du **message en
clair** (= non chiffré) lors du chiffrement, et de :math:`x` rangs vers
la gauche lors du déchiffrement. On appelle :math:`x` la **clé de
chiffrement**, et cette dernière doit être la même pour le chiffrement
et le déchiffrement car le chiffre de César est un `chiffrement
symétrique <https://en.wikipedia.org/wiki/Symmetric-key_algorithm>`__.

Exemple
-------

Prenons le mot "Linux", que l’on va chiffrer puis déchiffrer à l’aide du
chiffre de César et avec une clé de chiffrement de 2.

.. figure:: /img/algo/chiffrement/chiffre_cesar/exemple_chiffrement.png
   :alt: Exemple de chiffrement

   Exemple de chiffrement

On a deux alphabets représentés, un normal et un autre décalé de 2 rangs
vers la droite (car c'est notre clé de chiffrement). Cette
représentation permet de facilement visualiser le décalage puisqu'il
suffit de regarder la case correspondante dans le nouvel alphabet pour
chiffrer notre message. Chaque lettre (représentée en bleu) de notre
message en clair aura donc une lettre équivalente (représentée en vert)
dans le nouvel alphabet.

.. figure:: /img/algo/chiffrement/chiffre_cesar/exemple_dechiffrement.png
   :alt: Exemple de déchiffrement

   Exemple de déchiffrement

De la même manière, pour le déchiffrement il suffit de faire
correspondre les lettres de notre nouvel alphabet, à celui normal afin
de lire notre message chiffré.

Pseudo-code
-----------

Le pseudo-code du chiffre de César est très simple :

.. code:: nohighlight

   chiffrer :

      Pour chaque caractère du message
         Si c'est une lettre
            Décaler cette lettre de x rangs vers la droite

   déchiffrer :

      Pour chaque caractère du message
         Si c'est une lettre
            Décaler cette lettre de x rangs vers la gauche 

Il faut cependant faire attention à une chose, lorsqu'on dépasse la
lettre Z pendant le chiffrement, il faut pouvoir revenir au début de
l'alphabet, comme une sorte de boucle, et inversement avec la lettre A
lors du déchiffrement.

Implémentation
--------------

Une implémentation en C du chiffre de César :

[[secret="chiffre_cesar.c"]]

.. code:: c

   #include <stdio.h>
   #include <ctype.h>

   #define TAILLE_MAX 1000

   char message[TAILLE_MAX];
   int cle;

   void chiffrement(void)
   {
      int iTab;

      for(iTab = 0; message[iTab] != '\0'; ++iTab) {
         if(isalpha(message[iTab])) {
            char typo;
            typo = (isupper(message[iTab])) ? 'A' : 'a';

            message[iTab] -= typo;
            message[iTab] = ((message[iTab] + cle) % 26 + 26) % 26;
            message[iTab] += typo;
         }
      }
   }

   void dechiffrement(void)
   {
      int iTab;

      for(iTab = 0; message[iTab] != '\0'; ++iTab) {
         if(isalpha(message[iTab])) {
            char typo;
            typo = (isupper(message[iTab])) ? 'A' : 'a';

            message[iTab] -= typo;
            message[iTab] = ((message[iTab] - cle) % 26 + 26) % 26;
            message[iTab] += typo;
         }
      }
   }

   int main(void)
   {
      scanf("%[^\n]s\n", message);
      scanf("%d\n", &cle);

      chiffrement();
      printf("%s\n", message);
      dechiffrement();
      printf("%s\n", message);

      return 0;
   }

Pour décaler notre lettre, on récupère déjà son rang dans l'alphabet
pour simplifier les calculs (d'où le ``- typo`` et le ``+ typo``), puis
on ajoute (pour le chiffrement) ou on enlève (pour le déchiffrement) la
valeur de la clé, et ensuite on applique un
`modulo <https://en.wikipedia.org/wiki/Modulo_operation>`__ 26 pour ne
pas dépasser le Z et revenir au début dans ce cas. Cependant, en C, le
modulo négatif est particulier, par exemple :math:`-3 \mod 2 = -1`, il
faut donc rajouter 26 au cas où le résultat est négatif (pour le rendre
positif), et ensuite on applique de nouveau notre modulo 26.

[[/secret]]

En entrée de notre programme :

.. code:: nohighlight

   Linux
   2

Et la sortie :

.. code:: nohighlight

   Nkpwz
   Linux

Cassage
-------

Cet algorithme de chiffrement possède cependant des failles, et il est
tout à fait possible de le **casser**, c'est-à-dire d'obtenir le message
original sans posséder la clé de chiffrement.

Force brute
~~~~~~~~~~~

L'attaque par force brute (*brute force attack* en anglais) consiste
simplement à tester toutes les possibilités de clé de chiffrement une
par une, jusqu'à trouver la bonne.

Le problème avec le chiffre de César est qu'il n'existe en réalité que
26 uniques possibilités de clé de chiffrement. En effet, si l'on utilise
une clé supérieure à 26 cela revient à utiliser une clé de
:math:`x \mod 26`, par exemple si je chiffre le mot "Linux" avec une clé
de chiffrement de 28 j'obtiens exactement le même résultat qu'avec ma
clé de 2 car :math:`28 \mod 26 = 2`. Il est de même pour les clés
négatives, si j'utilise une clé de -1 cela revient à utiliser une clé de
25.

Notre attaque nécessite donc l'analyse d'uniquement 26 clés de
chiffrement, ce qui n'est rien pour un ordinateur qui peut faire des
milliards d'opérations à la seconde :

.. code:: nohighlight

   forceBrute :

      Pour chaque clé allant de 1 à 26, à pas de 1
         déchiffrer(message)
         Afficher message déchiffré

Une implémentation en C de cette attaque :

[[secret="force_brute.c"]]

.. code:: c

   #include <stdio.h>
   #include <string.h>
   #include <ctype.h>

   #define TAILLE_MAX 1000

   char message[TAILLE_MAX];
   char copie[TAILLE_MAX];

   void dechiffrement(int cle)
   {
      int iTab;

      for(iTab = 0; copie[iTab] != '\0'; ++iTab) {
         if(isalpha(copie[iTab])) {
            char typo;
            typo = (isupper(copie[iTab])) ? 'A' : 'a';

            copie[iTab] -= typo;
            copie[iTab] = ((copie[iTab] - cle) % 26 + 26) % 26;
            copie[iTab] += typo;
         }
      }
   }

   void forceBrute(void)
   {
      int iCle;
      for(iCle = 1; iCle < 26; ++iCle) {
         strcpy(copie, message);
         dechiffrement(iCle);
         printf("Cle de %d : %s\n", iCle, copie);
      }
   }

   int main(void)
   {
      scanf("%[^\n]s\n", message);

      forceBrute();

      return 0;
   }

[[/secret]]

Un exemple de message chiffré en entrée :

.. code:: nohighlight

   Nkpwz

Et la sortie obtenue :

.. code:: nohighlight

   Cle de 1 : Mjovy
   Cle de 2 : Linux
   Cle de 3 : Khmtw
   Cle de 4 : Jglsv
   Cle de 5 : Ifkru
   Cle de 6 : Hejqt
   Cle de 7 : Gdips
   Cle de 8 : Fchor
   Cle de 9 : Ebgnq
   Cle de 10 : Dafmp
   Cle de 11 : Czelo
   Cle de 12 : Bydkn
   Cle de 13 : Axcjm
   Cle de 14 : Zwbil
   Cle de 15 : Yvahk
   Cle de 16 : Xuzgj
   Cle de 17 : Wtyfi
   Cle de 18 : Vsxeh
   Cle de 19 : Urwdg
   Cle de 20 : Tqvcf
   Cle de 21 : Spube
   Cle de 22 : Rotad
   Cle de 23 : Qnszc
   Cle de 24 : Pmryb
   Cle de 25 : Olqxa

Ici vu qu'il n'y a que 26 possibilités, on se contente d'afficher tous
les messages déchiffrés pour que l'utilisateur voit directement lequel
ressemble à du français (on pourrait aussi implémenter un système qui
différencie des phrases en français de phrases sans aucuns sens, mais
l'implémentation se focalise uniquement sur l'attaque).

Cette méthode est assez bourrin, car tester toutes les combinaisons
possibles est souvent une mauvaise idée, cependant dans notre cas où on
sait qu’il n’y a que 26 possibilités à tester, cette méthode devient
tout de suite le choix parfait pour casser le chiffre de César. En plus
d’être extrêmement rapide, elle est aussi très simple à mettre en place
car une simple boucle suffit.

Analyse fréquentielle
~~~~~~~~~~~~~~~~~~~~~

L'analyse fréquentielle (*frequency analysis* en anglais) examine la
fréquence d'apparition des lettres employées dans le message chiffré
afin d'en deviner la clé pour le déchiffrer ensuite.

Cette attaque est possible sur le chiffre de César car c'est un système
de chiffrement à **substitution mono-alphabétique** ce qui signifie que
si l’on chiffre plusieurs fois la lettre A avec une même clé de
chiffrement :math:`x`, alors la lettre chiffrée sera toujours la même.
Ce type de système s’oppose donc à la **substitution poly-alphabétique**
utilisée par le `chiffre de
Vigenère </algo/chiffrement/chiffre_vigenere.html>`__ par exemple. De
plus, l'analyse fréquentielle repose sur le fait que chaque langue
possède des lettres plus utilisées que d'autres (en français par exemple
la lettre E est plus utilisée que la lettre D, la lettre H l'est moins
que la lettre O, etc.).

On peut donc analyser la fréquence d'apparition de chaque lettre dans
notre message chiffré, et en déduire la lettre correspondante dans le
message clair en établissant un lien avec les lettres les plus utilisées
en français (on suppose ici que notre message a été écrit en français
avant d'être chiffré).

Par exemple, si dans notre message chiffré on remarque que la lettre M
est la plus utilisée, on peut en déduire que c'est la lettre E dans
notre message clair. Ce qui signifie que l'on peut calculer la
différence de rangs entre les deux lettres pour avoir la clé de
chiffrement (si M correspond effectivement à E). Pour confirmer notre
hypothèse, on peut continuer en cherchant la différence de rangs entre
la deuxième lettre la plus utilisée en français (le A) et la deuxième
lettre la plus employée dans notre message chiffré. Si les deux clés
correspondent, il y a alors de fortes chances que ce soit la bonne clé
de chiffrement.

Le pseudo-code de l’attaque par analyse fréquentielle :

.. code:: nohighlight

   analyseFréquentielle :

      Déterminer le nombre d’occurrence de chaque lettre
      Déduire la clé de chiffrement la plus probable
      Déchiffrer le message avec la clé trouvée

Sur de petits textes, cette attaque risque de ne pas bien fonctionner
car notre méthode repose sur des statistiques et si on n'a pas assez de
données, on ne devinera pas forcément la clé du premier coup, alors que
sur un long texte la première clé affichée est très souvent la bonne.

L'attaque codée en C :

[[secret="analyse_frequentielle.c"]]

.. code:: c

   #include <stdio.h>
   #include <ctype.h>

   #define TAILLE_MAX 1000
   #define NB_LETTRE 26

   char message[TAILLE_MAX];
   int cle;

   void dechiffrement(void)
   {
      int iTab;

      for(iTab = 0; message[iTab] != '\0'; ++iTab) {
         if(isalpha(message[iTab])) {
            char typo;
            typo = (isupper(message[iTab])) ? 'A' : 'a';

            message[iTab] -= typo;
            message[iTab] = ((message[iTab] - cle) % 26 + 26) % 26;
            message[iTab] += typo;
         }
      }
   }

   void analyseFrequentielle(void)
   {
      int occurrence[NB_LETTRE];
      int iLettre, iMax;

      for(iLettre = 0; iLettre < NB_LETTRE; ++iLettre)
         occurrence[iLettre] = 0;
      for(iLettre = 0; message[iLettre] != '\0'; ++iLettre) {
         if(isalpha(message[iLettre])) {
            char typo;
            typo = (isupper(message[iLettre])) ? 'A' : 'a';
            ++occurrence[message[iLettre] - typo];
         }
      }


      iMax = 0;
      for(iLettre = 0; iLettre < NB_LETTRE; ++iLettre)
         if(occurrence[iLettre] > occurrence[iMax])
            iMax = iLettre;

      cle = 'e' - (iMax + 'a');
      if(cle < 0)
         cle = -cle;
   }

   int main(void)
   {
      scanf("%[^\n]s\n", message);

      analyseFrequentielle();
      dechiffrement();
      printf("Cle de %d : \n\n%s\n", cle, message);

      return 0;
   }

[[/secret]]

Un texte chiffré en entrée :

.. code:: nohighlight

   Lb ex mxqmx xlm xvkbm xg yktgvtbl, xm jn'be vhgmbxgm tllxs wx vtktvmxkxl, e'tgterlx ykxjnxgmbxeex xlm tllxs ybtuex xm whggx xg zxgxkte et uhggx vex wn ikxfbxk vhni. Ex ikhzktffx gx mxlmx jnx ex ikxfbxk kxlnemtm wx vex (jnb xlm et ienl ikhutuex), ftbl hg ihnkktbm itk xqxfiex tfxebhkxk e'tgterlx xg l'tiinrtgm lnk ienlbxnkl kxlnemtml wx vexl xm lb vxl wxkgbxkl vhkkxlihgwxgm tehkl be r tnkt ubxg ienl wx vatgvxl jnx vx lhbm et uhggx vex.

Le texte déchiffré :

.. code:: nohighlight

   Cle de 19 : 

   Si le texte est ecrit en francais, et qu'il contient assez de caracteres, l'analyse frequentielle est assez fiable et donne en general la bonne cle du premier coup. Le programme ne teste que le premier resultat de cle (qui est la plus probable), mais on pourrait par exemple ameliorer l'analyse en s'appuyant sur plusieurs resultats de cles et si ces derniers correspondent alors il y aura bien plus de chances que ce soit la bonne cle.

Cette méthode d'attaque n'est pas réellement adaptée au chiffre de César
puisqu'on peut simplement utiliser l'attaque par force brute, cependant
d'autres algorithmes de chiffrement n'ont pas aussi peu de possibilités
de clés que le chiffre de César, et casser ces derniers nécessite donc
une attaque plus réfléchie et plus intelligente comme l'analyse
fréquentielle.

Conclusion
----------

La cryptanalyse n'existait pas encore à l'époque de Jules César, et ce
dernier pouvait donc être serein en utilisant un système aussi simple et
peu sécurisé qu'est le chiffre de César. Cet algorithme n'est plus
utilisé depuis bien longtemps, mais a permis de base de réflexion à
d'autres algorithmes plus efficaces comme le `chiffre de
Vigenère </algo/chiffrement/chiffre_vigenere.html>`__.
