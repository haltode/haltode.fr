Chiffre de Vigenère
===================
algo/chiffrement

Publié le : 28/05/2014  
*Modifié le : 20/12/2015*

## Introduction

Avec l'apparition des premiers systèmes de cryptanalyses, le [chiffre de César](/algo/chiffrement/chiffre_cesar.html) n'est plus un algorithme sûr pour chiffrer ses messages, et on voit l'apparition d'un nouvel algorithme de chiffrement : **le chiffre de Vigenère**. Ce dernier est immunisé aux attaques du chiffre de César, car sa clé est une chaîne de caractères et non plus un simple nombre, cependant quelques siècles après les premières utilisations de ce système, des techniques permettant de casser le chiffre de Vigenère sont découvertes le rendant alors vulnérable et inutile.

## Principe de l'algorithme

Le chiffre de Vigenère est un [chiffrement symétrique](https://en.wikipedia.org/wiki/Symmetric-key_algorithm) utilisant une [substitution poly-alphabétique](https://en.wikipedia.org/wiki/Substitution_cipher#Polyalphabetic_substitution) pour chiffrer et déchiffrer le message secret. Ceci signifie que la clé de chiffrement est une chaîne de caractères, et c'est là-dessus que repose la sécurité de l'algorithme, car une même lettre ne sera alors pas forcément chiffrée de la même façon (elle dépendra de sa place dans le message, mais aussi de la clé utilisée).

## Exemple

Prenons comme message secret le mot "Programmation", et comme clé de chiffrement "Linux". La première étape à faire est de rendre notre clé aussi longue que notre message à chiffrer, pour cela, on répète simplement autant de fois la clé que nécessaire :

![Visualisation de la clé de chiffrement complète](//static.napnac.ga/img/algo/chiffrement/chiffre_vigenere/exemple_cle_chiffrement.png)

Désormais on peut chiffrer chaque lettre de notre message :

![Exemple de chiffrement](//static.napnac.ga/img/algo/chiffrement/chiffre_vigenere/exemple_chiffrement.png)

Le rang dans l'alphabet commence à 0 (et non 1) car $26 \mod 26 = 0$, il faut donc que la lettre A soit la lettre 0. A chaque tour, on prend le rang de la lettre du message, et on l'additionne à la lettre correspondante de la clé. On n'oublie pas d'appliquer notre [modulo](https://en.wikipedia.org/wiki/Modulo_operation) 26 pour revenir au début de l'alphabet si on dépasse Z.

Pour le déchiffrement, l'idée est la même sauf qu'on soustrait au lieu d'ajouter le rang de la lettre de la clé :

![Exemple de déchiffrement](//static.napnac.ga/img/algo/chiffrement/chiffre_vigenere/exemple_dechiffrement.png)

On peut utiliser cette méthode mais de manière plus visuelle afin de chiffrer et déchiffrer nos messages :

![Table de Vigenère](//static.napnac.ga/img/algo/chiffrement/chiffre_vigenere/table_vigenere.png)

La **table de Vigenère** consiste à énumérer toutes les possibilités de décalage lors du chiffrement et du déchiffrement. Les lettres du message clair sont représentées par les colonnes, tandis que celles de la clé sont représentées par les lignes. Pour chiffrer une lettre, on regarde l'intersection de la colonne correspondante à la lettre du message clair, et de la ligne correspondante à lettre de la clé. Pour déchiffrer une lettre, on regarde sur la ligne correspondante de la clé jusqu'à trouver la lettre chiffrée qui se trouvera sur la colonne de la lettre déchiffrée.

## Pseudo-code

Le pseudo-code du chiffre de Vigenère :

```nohighlight
Modifier la clé pour qu'elle soit de la même taille que le message

chiffrer : 

   Pour chaque caractère du message
      Si c'est une lettre
         Décaler cette lettre de cle[iCle] rangs vers la droite
         Incrementer iCle

déchiffrer :

   Pour chaque caractère du message
      Si c'est une lettre
         Décaler cette lettre de cle[iCle] rangs vers la gauche 
         Incrementer iCle
```

## Implémentation

Une implémentation en C du chiffre de Vigenère :

[INSERT]
chiffre_vigenere.c

Notez qu'au lieu de créer une seconde clé de chiffrement de la taille du message, on peut tout simplement utiliser un indice que l'on réinitialise à 0 à chaque fois qu'il a atteint le bout de la clé (grâce à `% tailleCle`).

Notre message et notre clé :

[INSERT]
test01.in

Le chiffrement et le déchiffrement :

[INSERT]
test01.out

## Cassage

Les [attaques du chiffre de César](/algo/chiffrement/chiffre_cesar.html#cassage) ne fonctionnent pas sur le chiffre de Vigenère pour plusieurs raisons :

- La clé est une chaîne de caractères de taille variable, ce qui signifie que le nombre de possibilités de clés de chiffrement est énorme, et une attaque par force brute n'est tout simplement pas envisageable.
- L'algorithme utilise une substitution poly-alphabétique, rendant ainsi une analyse fréquentielle impossible car une lettre ne sera pas forcément chiffrée de la même manière dans un texte.

Il nous faut donc de nouvelles méthodes, afin de casser cet algorithme réputé incassable jusqu'à la fin du XIXe siècle où une méthode fut officiellement découverte.

Notre objectif est de casser le message ci-dessus qui a été chiffré en utilisant le chiffre de Vigenère :

[INSERT]
test02.in

Les seules informations que l'on a sont que toutes les majuscules ont été transformées en minuscules, tous les accents par des lettres non accentuées, et les espaces et signes de ponctuations ont été enlevés.

### Trouver la longueur de la clé de chiffrement

Pour casser le chiffre de Vigenère, il faut procéder par étape, et la première est de déterminer la longueur de la clé de chiffrement employée pour chiffrer le message. Une fois cette longueur connue, on peut savoir quelles lettres sont chiffrées avec la même portion de clé, rendant alors la cryptanalyse du message bien plus facile.

Un des moyens de trouver la longueur de clé est d'utiliser le **test de Kasiski**. Le but est de repérer dans le message chiffré des sous chaînes qui se répètent, car ces dernières sont sans doute des mêmes portions du texte clair, codées avec la même partie de clé. Une fois qu'on connait suffisamment de répétitions, on peut grâce à l'espacement de ces dernières en déduire les tailles de clés possibles et en combinant plusieurs analyses on peut voir qu'une taille ressortira plus souvent que les autres. Mais pour cela notre texte doit être suffisamment long afin d'avoir un traitement efficace des sous chaînes (notre méthode étant basée sur des statistiques, si on a peu de données notre résultat ne sera pas forcément correcte et représentatif de la réalité). Heureusement, notre texte semble assez long et contient environ 1000 sous chaines se répétant (de différentes tailles allant de trois caractères à quatorze), et en voici une courte partie :

| Chaine     | Ecart | 2   | 3   | 4   | 5       | 6   | 7   | 8   | 9   | 10  | ... |
| :-         | -     | :-: | :-: | :-: | :-:     | :-: | :-: | :-: | :-: | :-: | -   |
| far        | 555   |     | X   |     | X       |     |     |     |     |     | ... |
| rmx        | 20    | X   |     | X   | X       |     |     |     |     | X   | ... |
| ryp        | 20    | X   |     | X   | X       |     |     |     |     | X   | ... |
| ypd        | 95    |     |     |     | X       |     |     |     |     |     | ... |
| dwa        | 605   |     |     |     | X       |     |     |     |     |     | ... |
| wan        | 605   |     |     |     | X       |     |     |     |     |     | ... |
| anx        | 1385  |     |     |     | X       |     |     |     |     |     | ... |
| yqp        | 1630  | X   |     |     | X       |     |     |     |     | X   | ... |
| plr        | 530   | X   |     |     | X       |     |     |     |     | X   | ... |
| mxc        | 75    |     | X   |     | X       |     |     |     |     |     | ... |
| xcu        | 75    |     | X   |     | X       |     |     |     |     |     | ... |
| cur        | 20    | X   |     | X   | X       |     |     |     |     | X   | ... |
| ury        | 75    |     | X   |     | X       |     |     |     |     |     | ... |
| ryp        | 75    |     | X   |     | X       |     |     |     |     |     | ... |
| ypq        | 1000  | X   |     | X   | X       |     |     | X   |     | X   | ... |
| yzwm       | 640   | X   |     | X   | X       |     |     | X   |     | X   | ... |
| mahb       | 95    |     |     |     | X       |     |     |     |     |     | ... |
| krmp       | 980   | X   |     | X   | X       |     | X   |     |     | X   | ... |
| mnfq       | 240   | X   | X   | X   | X       | X   |     | X   |     | X   | ... |
| byme       | 870   | X   | X   |     | X       | X   |     |     |     | X   | ... |
| eiiyz      | 1465  |     |     |     | X       |     |     |     |     |     | ... |
| iiyzw      | 640   | X   |     | X   | X       |     |     | X   |     | X   | ... |
| iyzwm      | 640   | X   |     | X   | X       |     |     | X   |     | X   | ... |
| acuow      | 345   |     | X   |     | X       |     |     |     |     |     | ... |
| ihdlf      | 740   | X   |     | X   | X       |     |     |     |     | X   | ... |
| gifcm      | 450   | X   | X   |     | X       | X   |     |     | X   | X   | ... |
| yccia      | 645   |     | X   |     | X       |     |     |     |     |     | ... |
| cciaw      | 355   |     |     |     | X       |     |     |     |     |     | ... |
| dbbop      | 65    |     |     |     | X       |     |     |     |     |     | ... |
| mxcuryp    | 75    |     | X   |     | X       |     |     |     |     |     | ... |
| rholxci    | 1465  |     |     |     | X       |     |     |     |     |     | ... |
| purwxyqdo  | 50    | X   |     |     | X       |     |     |     |     | X   | ... |
| rholxcioei | 1465  |     |     |     | X       |     |     |     |     |     | ... |
| ihdlfzqbrt | 740   | X   |     | X   | X       |     |     |     |     | X   | ... |
| fcmolfeiah | 600   | X   | X   | X   | X       | X   |     | X   |     | X   | ... |
| ...        | ...   | ... | ... | ... | ...     | ... | ... | ... | ... | ... | ... |
| Total      |       | 537 | 371 | 268 | **916** | 215 | 101 | 174 | 71  | 528 | ... |

Pour chaque sous chaine, on note l'écart jusqu'à la prochaine occurrence de ladite chaine, puis on peut en déduire que la taille de notre clé est un multiple de cet espace (en effet, il y a une répétition en général quand une même portion du message est chiffrée avec une même portion de la clé). On marque alors pour chaque sous chaine les diviseurs de notre écart, et lorsqu'on additionne tous les résultats on voit que le nombre 5 est celui qui apparait le plus de fois. Ce test nous apprend donc que la clé de chiffrement que l'on cherche a de très fortes chances de posséder 5 caractères.

Une implémentation en C du test de Kasiski :

[INSERT]
test_kasiski.c

Tout d'abord, on commence à chercher des sous chaines d'une taille de trois caractères minimum car les sous chaines de deux caractères ne sont pas réellement efficaces et représentatives (ça peut simplement être un coup de chance). Ensuite, la recherche de sous chaine n'est pas optimisée car le but de cette implémentation est de montrer comment appliquer le test de Kasiski. Si vous voulez casser un texte plus important, je vous conseille de revoir la recherche de sous chaine en vous aidant d'algorithmes plus efficaces comme [KMP](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm), [Rabin-Karp](https://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm), ou encore [Z](http://codeforces.com/blog/entry/3107). Le code s'exécute instantanément dans notre exemple, mais sur des textes aussi grands que des livres, il risque de prendre plus de temps s'il n'est pas optimisé.

La sortie de l'implémentation (j'ai commenté l'affichage des sous chaines/écart, et celui du tableau des possibilités car sinon plus de 1000 lignes sont affichées en sortie) :

[INSERT]
test02.out

### Déduire la clé

Une fois qu'on a notre longueur de clé, on peut savoir quelles lettres du message ont été chiffrées avec les mêmes lettres de la clé (puisqu'on connait sa longueur, on sait donc où se répète la clé).

On va alors découper le message chiffré en plusieurs catégories de lettres :

- Celles chiffrées avec la 1ère lettre de la clé (soit la 1ère, la 6ème, la 11ème, etc.)
- Celles chiffrées avec la 2ème lettre de la clé (soit la 2ème, la 7ème, la 12ème, etc.)
- ...
- Celles chiffrées avec la 5ème lettre de la clé (soit la 5ème, la 10ème, la 15ème, etc.)

Notre message découpé en 5 lignes :

[INSERT]
test03.out

Finalement, on peut dire que chaque ligne a été chiffrée à l'aide d'un simple chiffre de César, puisque toutes les lettres d'une même ligne sont chiffrées avec la même lettre de la clé, et cette lettre peut être vue comme un simple nombre. Une fois que l'on sait cela, on peut effectuer une analyse fréquentielle pour trouver la clé de chiffrement, comme pour le chiffre de César, sur chacune des lignes découpées.

On cherche pour chaque ligne, la lettre apparaissant le plus, puis l'on déduit que cette lettre représente la lettre E dans l'alphabet normal, on peut donc facilement retrouver l'alphabet chiffré utilisé avec cette lettre. Prenons l'exemple de la première ligne :

```nohighlight
1 : wpttzfydwpcqlzcrcyzyerwlpcdtlewxcpzndlpfxmpwnlppptoyyxwpypynwtltppdzyfpwldylfllfdtnlypyzpeftwyztwcowddlteotyzzbfwzdpfgtcpcfcwxjfdldptyulzlcylwpafwepwypccpwfcnwcebtecypewepwcwdtdpycddnrpaxlccsfzleppdnllwcnrpycyppqdweedzlynatlydwjplancfptodftlpyyzyylgappydtwexpxyoweplcywqcpoctdfpccebbptdfgfxdpctpypefcndpfpxepgytplffypjgpclexzwgwoplctolppdyllxusaclzy
```

La lettre la plus utilisée ici est le P, on peut donc faire une correspondance entre l'alphabet normal et l'alphabet chiffré, nous permettant de trouver la première lettre de la clé de chiffrement, le L :

![Exemple de correspondance](//static.napnac.ga/img/algo/chiffrement/chiffre_vigenere/exemple_ligne.png)

Si on applique ce principe à chacune de nos lignes on obtient :

![Recherche de clé de chiffrement](//static.napnac.ga/img/algo/chiffrement/chiffre_vigenere/exemple_trouver_cle.png)

La clé apparait alors à la verticale en lisant simplement la correspondance de la lettre A dans chaque alphabet chiffré. En effet la lettre A représente la lettre 0 de l'alphabet et donc la correspondance représente le décalage utilisé (c'est-à-dire la clé) pour créer l'alphabet chiffré.

L'implémentation en C de l'analyse fréquentielle :

[INSERT]
trouver_cle.c

Le programme prend en entrée le message chiffré et la longueur de clé précédemment trouvée, et retourne en sortie la découpe du message, les lettres les plus utilisées pour chaque ligne, et la clé de chiffrement :

[INSERT]
test04.out

### Déchiffrer le message

Désormais, on connait la clé de chiffrement que l'auteur du message a employée pour chiffrer ce texte :

[INSERT]
test02.in

On déchiffre le message :

[INSERT]
test05.out

On rajoute les majuscules, les accents, puis la ponctuation et notre texte apparait :

```nohighlight
Les chefs qui, depuis de nombreuses années, sont à la tête des armées françaises, ont formé un gouvernement.

Ce gouvernement, alléguant la défaite de nos armées, s'est mis en rapport avec l'ennemi pour cesser le combat.
 
Certes, nous avons été, nous sommes, submergés par la force mécanique, terrestre et aérienne, de l'ennemi.

Infiniment plus que leur nombre, ce sont les chars, les avions, la tactique des Allemands qui nous font reculer. Ce sont les chars, les avions, la tactique des Allemands qui ont surpris nos chefs au point de les amener là où ils en sont aujourd'hui.

Mais le dernier mot est-il dit ? L'espérance doit-elle disparaître ? La défaite est-elle définitive ? Non !

Croyez-moi, moi qui vous parle en connaissance de cause et vous dis que rien n'est perdu pour la France. Les mêmes moyens qui nous ont vaincus peuvent faire venir un jour la victoire.

Car la France n'est pas seule ! Elle n'est pas seule ! Elle n'est pas seule ! Elle a un vaste Empire derrière elle. Elle peut faire bloc avec l'Empire britannique qui tient la mer et continue la lutte. Elle peut, comme l'Angleterre, utiliser sans limites l'immense industrie des Etats-Unis.

Cette guerre n'est pas limitée au territoire malheureux de notre pays. Cette guerre n'est pas tranchée par la bataille de France. Cette guerre est une guerre mondiale. Toutes les fautes, tous les retards, toutes les souffrances, n'empêchent pas qu'il y a, dans l'univers, tous les moyens nécessaires pour écraser un jour nos ennemis. Foudroyés aujourd'hui par la force mécanique, nous pourrons vaincre dans l'avenir par une force mécanique supérieure. Le destin du monde est là.

Moi, Général de Gaulle, actuellement à Londres, j'invite les officiers et les soldats français qui se trouvent en territoire britannique ou qui viendraient à s'y trouver, avec leurs armes ou sans leurs armes, j'invite les ingénieurs et les ouvriers spécialistes des industries d'armement qui se trouvent en territoire britannique ou qui viendraient à s'y trouver, à se mettre en rapport avec moi.

Quoi qu'il arrive, la flamme de la résistance française ne doit pas s'éteindre et ne s'éteindra pas.

Demain, comme aujourd'hui, je parlerai à la Radio de Londres.
```

*Ce message est le discours du Général de Gaulle prononcé le 18 juin 1940.*

## Conclusion

Le chiffre de Vigenère offre donc plus de sécurité que le chiffre de César, grâce à une clé plus complexe. Cependant, ce dernier n'est pas infaillible, et il est assez facile de trouver la clé de chiffrement à partir du simple texte chiffré. Cet algorithme n'est donc plus utilisé depuis qu'il a été cassé, mais il existe une amélioration à ce système qui est techniquement incassable : le [chiffre de Vernam](/algo/chiffrement/chiffre_vernam.html).
