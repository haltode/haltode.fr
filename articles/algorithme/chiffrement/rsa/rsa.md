RSA
===
algo/chiffrement

Publié le : 31/05/2014  
*Modifié le : 30/12/2015*

## Introduction

Tous les algorithmes de chiffrement **symétriques** ont un problème commun : la transmission de clé. Quelque soit l'algorithme utilisé, si la clé est interceptée par l'ennemi, alors il peut lire les communications, mais aussi se faire passer pour le destinataire du message. Ce problème est fondamental car transmettre une clé de chiffrement est très délicat, il était donc nécessaire de trouver une autre solution face à ce problème : les chiffrements **asymétriques**. 

TODO : approfondir intro (survoler les caractéristiques, sécurité, application, etc.).

## Principe de l'algorithme

L'idée d'un algorithme de chiffrement asymétrique est d'attribuer à chaque personne un **couple de clés** :

- Une clé **publique** qu'on peut diffuser, transmettre et montrer à absolument tout le monde sans que cela pose un problème de sécurité. On imagine souvent un grand annuaire contenant pour chaque personne sa clé publique correspondante pour simplifier les communications.
- Une clé **privée** qu'il ne faut en aucun cas évoquer, cette clé doit rester secrète et vous ne devez la communiquer à personne.

Une fois que chaque personne a ses deux clés, on peut procéder au chiffrement et au déchiffrement de message. Imaginons qu'Alice et Bob souhaitent communiquer entre eux, et Alice veut envoyer un premier message à Bob. Pour cela, Alice va chercher la clé publique de Bob (que n'importe qui peut accéder grâce à l'annuaire), et elle va chiffrer son message avec cette clé. Ensuite le message chiffré est transmis à Bob, et il va le déchiffrer grâce à sa clé privée (qu'il n'a communiqué à personne). Aucun échange de clé n'est nécessaire, et seule la clé privée de Bob peut déchiffrer le message.

L'algorithme RSA est à l'origine de ce système de clé, et propose une approche mathématique afin de produire lesdits couples de clés :

TODO : vérifier les noms utilisés + pourquoi ça marche ? (fonction a un seul sens)
TODO : lien wiki modulo ?

- Choisir deux [nombres premiers](https://en.wikipedia.org/wiki/Prime_number) distincts *p* et *q*.
- Calculer le produit *p \* q* appelé **module de chiffrement** et abrégé *n*.
- Calculer l'[indicatrice d'Euler](https://en.wikipedia.org/wiki/Euler's_totient_function) de *n*, qu'on notera *m = (p - 1) \* (q - 1)*.
- Choisir un **exposant de chiffrement** noté *e*, qui soit premier avec *m* et strictement inférieur à ce dernier.
- Calculer l'**exposant de déchiffrement** noté *d*, qui est l'[inverse modulaire](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse) de *e mod m*.

La clé publique correspond au couple (*n*, *e*) et la clé privée au couple (*n*, *d*).

Pour chiffre notre message, on utilisera alors cette relation :

*Lettre chiffrée = lettre du message ^ e mod n*

Et pour le déchiffrement :

*Lettre déchiffrée = lettre chiffrée ^ d mod n*

## Exemple

Choisissons comme message "Bienvenue", et chiffrons-le avec l'algorithme RSA :

### Génération des clés

La première étape est de générer nos clés publiques et privés car je n'en possède pas encore. On applique donc notre algorithme de création de clés. Soit *p* et *q* deux nombres premiers que je choisis aléatoirement :

*p = 61* et *q = 137*

A partir de cela, on peut calculer notre module de chiffrement :

*n = p \* q*  
*n = 8357*

L'indicatrice d'Euler de n est calculé ensuite :

*m = (p - 1) \* (q - 1)*  
*m = 8160*

Ensuite, il faut choisir notre exposant de chiffrement *e* qui doit être premier avec *m* et strictement inférieur à ce dernier, je choisis donc 7 :

*e = 7*

Désormais nous devons trouver notre exposant de déchiffrement. Cette partie est un peu plus compliquée, car elle nécessite quelques notions de maths.

On cherche donc *d* qui est l'inverse modulaire de *e mod m*, on a :

*d ≡ e-¹ (mod m)*

Ce qui est équivalent à :

*de ≡ 1 (mod m)*

Et par définition de la [congruence](), on a :

*de - qm = 1*

On connait *e* et *m*, et on cherche *d*, *q* ici n'est qu'un nombre entier inutile à l'algorithme RSA. Cette expression est de la forme de l'[identité de Bézout]() *ax + by = pgcd(a, b)* avec *a = e*, *b = m*, *x = d*, *y = -q*, or *e* et *m* sont premiers entre eux donc *pgcd(a, b) = 1*. Or on peut trouver les coefficients *x* et *y* (et donc *d* qui nous intéresse) grâce à l'[algorithme d'Euclide étendu](). Une implémentation de cet algorithme pour ceux que ça intéresse :

[INSERT]
algo_euclide_etendu.c

L'entrée :

[INSERT]
test01.in

La sortie :

[INSERT]
test01.out

TODO : possibilité d'utiliser un algo bourrin qui teste toutes les valeurs de d entre 1 et m (démontrer qu'il existe forcément un d compris entre 1 et m) + comparer les complexités de l'algo bourrin et de l'algo d'euclide étendu.

On trouve donc grâce au dernier programme :

*d = -3497*

On a désormais trouvé *d* vérifiant l'équation *de ≡ 1 (mod m)*. Cependant, on préfèrera travailler avec des nombres positifs, et notre nombre vérifie la propriété suivante : 

*de ≡ 1 (mod m)* avec *d = -3497 + km* et *k* un nombre entier relatif.

Je rends donc *d* positif en appliquant notre formule pour *k = 1* :

*d = -3497 + m*
*d = 4663*

Notre couple de clé publique/privée est désormais généré :

- Clé publique de la forme (*n*, *e*) : (8357, 7)
- Clé privée de la forme (*n*, *d*) : (8357, 4663)

### Chiffrement/Déchiffrement

On peut maintenant chiffrer et déchiffrer notre message avec nos clés en appliquant les relations :

*Lettre chiffrée = lettre du message ^ e mod n*  
*Lettre déchiffrée = lettre chiffrée ^ d mod n*

Les lettres seront représentées par des nombres grâce à la [table ASCII]() permettant de résoudre les relations mathématiques.

![Exemple de chiffrement](//static.napnac.ga/img/algo/chiffrement/rsa/exemple_chiffrement.png)

![Exemple de déchiffrement](//static.napnac.ga/img/algo/chiffrement/rsa/exemple_dechiffrement.png)

## Pseudo-code

## Implémentation

## Cassage

## Conclusion
