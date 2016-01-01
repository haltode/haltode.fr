RSA
===
algo/chiffrement

Publié le : 31/05/2014  
*Modifié le : 01/01/2016*

## Introduction

Tous les algorithmes de chiffrement **symétriques** ont un problème commun : la transmission de clé. Quelque soit l'algorithme utilisé, si la clé est interceptée par l'ennemi, alors il peut lire les communications, mais aussi se faire passer pour le destinataire du message. Ce problème est fondamental car transmettre une clé de chiffrement est très délicat, il était donc nécessaire de trouver une autre solution face à ce problème : les chiffrements **asymétriques**.

TODO : évoquer Diffie et Hellman (supplément conférence ccc ?)

L'idée du chiffrement asymétrique est d'utiliser deux clés au lieu d'une, et que l'on va attribuer à chaque personne :

- Une clé **publique** qu'on peut diffuser, transmettre et montrer à absolument tout le monde sans que cela pose un problème de sécurité (c'est d'ailleurs conseillé de la rendre la plus accessible possible).
- Une clé **privée** qu'il ne faut en aucun cas évoquer, cette clé doit rester secrète et vous ne devez la communiquer à personne.

Les bases du chiffrement asymétrique furent introduites grâce à Whitfiled Diffie et Martin Hellman quelques années avant l'algorithme RSA, et ils montrent comment résoudre le problème d'échange de clés de manière sécurisé. La particularité est qu'il est simple de générer des couples de clés, mais quasiment impossible de retrouver la clé privée à partir de la clé publique.

L'algorithme RSA sera l'un des premiers algorithmes de chiffrement asymétriques utilisant ce concept à en faire une implémentation possible pour la communication de messages grâce à des principes mathématiques. Cet algorithme est encore très utilisé de nos jours, surtout sur Internet (où l'échange de clé symétrique est physiquement impossible), dans le commerce en ligne, les transactions sécurisées, etc.

TODO : approfondir intro (survoler les caractéristiques, sécurité, application, etc.).

## Principe de l'algorithme

L'algorithme du RSA va dans un premier temps générer deux couples de clés asymétriques, l'un pour l'émetteur qu'on appellera *Alice*, et l'autre pour le destinataire qu'on appellera *Bob*. Une fois que chaque personne a ses deux clés, on peut procéder à une communication sécurisée. Alice va chercher la clé publique de Bob (soit en lui demandant, soit en la trouvant dans un annuaire contenant les clés publiques de tout le monde, etc.), et elle va chiffrer son message avec cette clé. Ensuite le message chiffré est transmis à Bob, et il va le déchiffrer grâce à sa clé privée (qu'il n'a communiqué à personne). Aucun échange de clé n'est nécessaire, et seule la clé privée de Bob peut déchiffrer le message, la communication est alors sécurisée.

La sécurité du chiffrement se trouve dans l'utilisation d'une fonction de chiffrement et de déchiffrement **[à sens unique](https://en.wikipedia.org/wiki/One-way_function)**. Cette fonction est, comme pour la génération de clé, très simple à appliquer dans un sens (chiffrement/déchiffrement avec la clé), mais extrêmement complexe dans l'autre (chiffrement/déchiffrement sans la clé).

Tout d'abord, regardons comment générer nos clés :

- Choisir deux [nombres premiers](https://en.wikipedia.org/wiki/Prime_number) distincts $p$ et $q$.
- Calculer le produit $p \times q$ appelé **module de chiffrement** et abrégé $n$.
- Calculer l'[indicatrice d'Euler](https://en.wikipedia.org/wiki/Euler's_totient_function) de $n$, qu'on notera $m = (p - 1) \times (q - 1)$ (l'indicatrice d'Euler est une fonction permettant de compter les nombres premiers à $x$ situés entre 1 et $x$ compris).
- Choisir un **exposant de chiffrement** noté $e$, qui soit premier avec $m$ et strictement inférieur à ce dernier.
- Calculer l'**exposant de déchiffrement** noté $d$, qui est l'[inverse modulaire](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse) de $e \mod m$ (en savoir plus sur le [modulo](https://en.wikipedia.org/wiki/Modulo_operation)).

La clé publique correspond au couple ($n$, $e$) et la clé privée au couple ($n$, $d$).

Pour chiffrer notre message, on utilisera alors cette relation :

$f(x) = x^{e} \mod n$

Avec $x$ la lettre du message en clair, et $f(x)$ la lettre chiffrée.

Et pour le déchiffrement, on utilise la fonction suivante :

$f'(x) = x^{d} \mod n$

Avec cette fois $x$ la lettre chiffrée et $f'(x)$ la lettre déchiffrée.

## Exemple

Choisissons comme message "Bienvenue", et chiffrons-le avec l'algorithme RSA :

### Génération des clés

La première étape est de générer notre clé publique et privée car je n'en possède pas encore, et comme je n'ai pas d'ami nommé Bob à qui envoyer des messages secrets, je vais m'envoyer le message chiffré à moi même (pour simplifier les explications et ne pas être embrouillé dans toutes les valeurs numériques). On applique donc notre algorithme de création de clés :

Soit $p$ et $q$ deux nombres premiers que je choisis aléatoirement :

$p = 61$ et $q = 137$

A partir de cela, on peut calculer notre module de chiffrement :

$n = p \times q$  
$n = 8357$

Ainsi que l'indicatrice d'Euler de n :

$m = (p - 1) \times (q - 1)$  
$m = 8160$

Ensuite, il faut choisir notre exposant de chiffrement $e$ qui doit être premier avec $m$ et strictement inférieur à ce dernier, je choisis donc 7 :

$e = 7$

Désormais nous devons trouver notre exposant de déchiffrement. Cette partie est un peu plus compliquée, car elle nécessite quelques notions de maths.

On cherche donc $d$ qui est l'inverse modulaire de $e \mod m$, on a :

$d \equiv e^{-1} \pmod m$

Ce qui est équivalent à :

$d \times e \equiv 1 \pmod m$

Par définition de la [congruence](https://en.wikipedia.org/wiki/Congruence_relation), $m$ est un diviseur de $d \times e - 1$, ce que l'on peut donc écrire comme ceci :

$d \times e - 1 = q \times m$ avec $q$ le quotient de $(d \times e - 1) / m$

On a finalement :

$d \times e - q \times m = 1$

On connait $e$, $m$, et on cherche $d$ :

On remarque que cette expression est de la forme de l'[identité de Bézout](https://en.wikipedia.org/wiki/B%C3%A9zout's_identity) $ax + by = pgcd(a, b)$ avec $a = e$, $b = m$, $x = d$, $y = -q$, or $e$ et $m$ sont premiers entre eux donc $pgcd(a, b) = 1$. Or on peut trouver les coefficients $x$ et $y$ (et donc $d$, qui nous intéresse) grâce à l'[algorithme d'Euclide étendu](https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm). Une implémentation de cet algorithme pour ceux que ça intéresse :

[INSERT]
algo_euclide_etendu.c

L'entrée :

[INSERT]
test01.in

La sortie :

[INSERT]
test01.out

On trouve grâce au dernier programme :

$d = -3497$

On a désormais trouvé $d$ vérifiant l'équation $d \times e \equiv 1 \pmod m$. Cependant, on préfèrera travailler avec des nombres positifs, et selon Wikipédia les coefficients $x$ et $y$ ne sont pas uniques et on peut en trouver une infinité qui respectent la relation suivante :

$x + k \times \frac{b}{pgcd(a, b)}$ avec $k$ un nombre entier relatif

Si on remplace par nos valeurs ($x = d$, $b = m$, $pgcd(a, b) = 1$), on obtient :

$d + k \times m$  
$-3497 + k \times 8160$

On veut donc trouver un nombre $d$ positif :

$-3497 + k \times 8160 > 0$  
$k > 3497 / 8160$  

Or $k$ est un nombre entier et $3497 / 8160 \approx 0,429$, je vais donc arrondir à l'entier supérieur $k = 1$ pour avoir une valeur de $d$ positive :

$d = -3497 + m$  
$d = 4663$

Notre couple de clé publique/privée est désormais généré :

- Clé publique de la forme ($n$, $e$) : (8357, 7)
- Clé privée de la forme ($n$, $d$) : (8357, 4663)

### Chiffrement/Déchiffrement

On peut maintenant chiffrer et déchiffrer notre message avec nos clés en appliquant les fonctions :

$f(x) = x^{e} \mod n$
$f'(x) = x^{d} \mod n$

Les lettres seront représentées par des nombres grâce à la [table ASCII]() permettant de résoudre les relations mathématiques.

![Exemple de chiffrement](//static.napnac.ga/img/algo/chiffrement/rsa/exemple_chiffrement.png)

![Exemple de déchiffrement](//static.napnac.ga/img/algo/chiffrement/rsa/exemple_dechiffrement.png)

## Pseudo-code

Le pseudo-code du fonctionnement de l'algorithme RSA :

```nohighlight
cléPublique(p, q) :

   Choisir aléatoirement p et q, deux nombres premiers distincts
   n = p * q
   m = (p - 1) * (q - 1)
   Choisir e strictement inférieur à m et premier avec lui

   Retourner couple (n, e)

cléPrivée(e, m, n) :

   Algorithme d'Euclide étendu pour calculer d (l'inverse de la multiplication
   de e modulo m)

   Retourner couple (n, d)

chiffrer :

   Pour chaque caractère du message
      lettreChiffrée = lettreClaire ^ e mod n 

déchiffrer :

   Pour chaque caractère du message
      lettreClaire = lettreChiffrée ^ d mod n 
```

Une dernière question se pose cependant face à ce pseudo-code... Comment calculer des nombres à des puissances aussi énormes ? En effet, $d = 4663$ dans notre exemple et élever un nombre à la puissance 4663 est tout simplement fou (surtout qu'en situation réelle, notre $e$ et $d$ peuvent comporter plusieurs centaines de chiffres chacun). Heureusement un algorithme nous permet de calculer facilement le résultat d'une opération du style $x^a \mod b$, c'est l'[exponentiation modulaire](https://en.wikipedia.org/wiki/Modular_exponentiation) ce qui est parfait dans notre cas car on ne veut pas calculer la puissance puis lui appliquer le modulo séparément car ça serait trop lent et compliqué à faire sur de grands nombres.

## Implémentation

Une implémentation en C de l'algorithme de RSA :

[INSERT]
rsa.c

## Sécurité

## Cassage

## Conclusion
