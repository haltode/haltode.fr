RSA
===
algo/chiffrement

Publié le : 31/05/2014  
*Modifié le : 06/01/2016*

## Introduction

Tous les algorithmes de chiffrement **symétriques** ont un problème commun : la transmission de clé. Quelque soit l'algorithme utilisé, si la clé est interceptée par l'ennemi, alors il peut lire les communications, mais aussi se faire passer pour le destinataire du message. Ce problème est fondamental car transmettre une clé de chiffrement est très délicat, et même impossible dans certains cas (par exemple avec Internet, c'est compliqué d'aller voir le responsable de chaque serveur physiquement pour qu'il vous transmette une clé), il était donc nécessaire de trouver une autre solution face à ce problème : les chiffrements **asymétriques**.

L'idée du chiffrement asymétrique est d'utiliser deux clés au lieu d'une, et que l'on va attribuer à chaque personne :

- Une clé **publique** qu'on peut diffuser, transmettre et montrer à absolument tout le monde sans que cela pose un problème de sécurité (c'est d'ailleurs conseillé de la rendre la plus accessible possible).
- Une clé **privée** qu'il ne faut en aucun cas évoquer, cette clé doit rester secrète et vous ne devez la communiquer à personne.

Les bases du chiffrement asymétrique furent introduites grâce à Whitfield Diffie et Martin Hellman quelques années avant l'algorithme RSA, et ils montrent comment résoudre le problème d'échange de clés de manière sécurisé. La particularité est qu'il est simple de générer des couples de clés, mais quasiment impossible de retrouver la clé privée à partir de la clé publique (que n'importe qui peut en théorie voir).

L'algorithme RSA sera l'un des premiers algorithmes de chiffrement asymétriques utilisant ce concept et à en faire une implémentation possible pour la communication de messages grâce à des principes mathématiques. Cet algorithme est encore très utilisé de nos jours, surtout sur Internet (dans le commerce en ligne, les transactions sécurisées, etc.).

TODO : retravailler intro une fois l'article fini

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

$f(x) = x^e \mod n$

Avec $x$ la lettre du message en clair, et $f(x)$ la lettre chiffrée.

Et pour le déchiffrement, on utilise la fonction suivante :

$f'(x) = x^d \mod n$

Avec cette fois $x$ la lettre chiffrée et $f'(x)$ la lettre déchiffrée.

## Exemple

Choisissons comme message "Bienvenue", et chiffrons-le avec l'algorithme RSA.

### Génération des clés

La première étape est de générer notre clé publique et privée car je n'en possède pas encore, et comme je n'ai pas d'ami nommé Bob à qui envoyer des messages secrets, je vais m'envoyer le message chiffré à moi-même (pour simplifier les explications et ne pas être embrouillé dans toutes les valeurs numériques). On applique donc notre algorithme de création de clés :

Soit $p$ et $q$ deux nombres premiers que je choisis aléatoirement :

$p = 61$ et $q = 137$

A partir de cela, on peut calculer notre module de chiffrement :

$n = p \times q$  
$n = 8357$

Ainsi que l'indicatrice d'Euler de $n$ :

$m = (p - 1) \times (q - 1)$  
$m = 8160$

Ensuite, il faut choisir notre exposant de chiffrement $e$ qui doit être premier avec $m$ et strictement inférieur à ce dernier, je choisis donc 7 :

$e = 7$

Désormais nous devons trouver notre exposant de déchiffrement. Cette partie est un peu plus compliquée, car elle nécessite quelques notions de maths.

On cherche donc $d$ qui est l'inverse modulaire de $e \mod m$, on a :

$d \equiv e^{-1} \pmod m$

Ce qui est équivalent à :

$de \equiv 1 \pmod m$

Par définition de la [congruence](https://en.wikipedia.org/wiki/Congruence_relation), $m$ est un diviseur de $d e - 1$, ce qu'on peut écrire comme ceci :

$de - 1 = qm$ avec $q$ le quotient de $(de - 1) / m$

On a finalement :

$de - qm = 1$

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

On a désormais $d$ vérifiant l'équation $de \equiv 1 \pmod m$. Cependant, on préfèrera travailler avec des nombres positifs, et selon Wikipédia le coefficient $x$ n'est pas unique ($y$ non plus mais c'est $x$ qui nous intéresse), et on peut en trouver une infinité qui respectent la relation suivante :

$x + k\frac{b}{pgcd(a, b)}$ avec $k$ un nombre entier relatif

Si on remplace par nos valeurs ($x = d$, $b = m$, $pgcd(a, b) = 1$), on obtient :

$d + km$

Et avec les valeurs numériques :

$-3497 + 8160k$

On veut donc trouver un nombre $d$ positif :

$-3497 + 8160k > 0$  
$k > 0,429$ (arrondi)

Or $k$ est un nombre entier, je vais donc arrondir à l'entier supérieur $k = 1$ pour avoir une valeur de $d$ positive :

$d = -3497 + m$  
$d = 4663$

Notre couple de clé publique/privée est désormais généré :

- Clé publique de la forme ($n$, $e$) : (8357, 7)
- Clé privée de la forme ($n$, $d$) : (8357, 4663)

### Chiffrement/Déchiffrement

On peut maintenant chiffrer et déchiffrer notre message avec nos clés en appliquant les fonctions :

$f(x) = x^e \mod n$  
$f'(x) = x^d \mod n$

Les caractères seront représentés par des nombres grâce à la [table ASCII](https://en.wikipedia.org/wiki/ASCII) permettant de résoudre les relations mathématiques (on imagine dans notre cas que les caractères du message sont tous présents dans la table ASCII pour simplifier le problème).

Notre message correspond donc à ceci selon la table ASCII :

![Transformation du message en nombre](//static.napnac.ga/img/algo/chiffrement/rsa/exemple_message_ascii.png)

Le message chiffré :

![Exemple de chiffrement](//static.napnac.ga/img/algo/chiffrement/rsa/exemple_chiffrement.png)

On se retrouve avec un message ressemblant à ceci 

```nohighlight
2546 824 4962 8071 2160 4962 8071 5933 4962 
```

Que l'on peut déchiffrer :

![Exemple de déchiffrement](//static.napnac.ga/img/algo/chiffrement/rsa/exemple_dechiffrement.png)

Pour retrouver notre message (composé de nombre), qui est facilement transformable en chaîne.

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
   de e mod m)

   Retourner couple (n, d)

chiffrer :

   Pour chaque caractère du message
      lettreChiffrée = lettreClaire ^ e mod n 

déchiffrer :

   Pour chaque caractère du message
      lettreClaire = lettreChiffrée ^ d mod n 
```

Une dernière question se pose cependant face à ce pseudo-code... Comment calculer des nombres à des puissances aussi énormes ? En effet, $d = 4663$ dans notre exemple et élever un nombre à la puissance 4663 est tout simplement fou (surtout qu'en situation réelle, notre $e$ et $d$ peuvent comporter plusieurs centaines de chiffres chacun). Si on calcule séparément $a^b$ puis on applique le modulo $c$ on sera confronté à un problème de stockage car quand b est grand le résultat $a^b$ sera tellement gigantesque que notre programme ne pourra pas stocker ce nombre. Heureusement un algorithme nous permet de calculer facilement le résultat d'une opération du style $a^b \mod c$, c'est l'[exponentiation modulaire](https://en.wikipedia.org/wiki/Modular_exponentiation). 

Soit $x = a^b \mod c$, on peut trouver $x$ facilement grâce à notre nouvel algorithme :

```nohighlight
x = 1
Pour chaque exposant allant de 1 à b inclus
   x = (x * a) mod c
```

Cet algorithme nous permet donc de travailler avec des nombres bien plus petits qui ne dépasseront jamais $c$ car à chaque multiplication on effectue un modulo dessus.

## Implémentation

Une implémentation en C de l'algorithme de RSA :

[INSERT]
rsa.c

Le message d'entrée :

[INSERT]
test02.in

La sortie :

[INSERT]
test02.out

Quelques remarques sur le code :

- Le type du message est `unsigned long long` qui est le type le plus grand en C (il stocke des nombres allant de 0 à $2^64 - 1$), car un `int` ne sera pas toujours suffisant, on prend donc des précautions en utilisant un type de données très grand pour ne pas avoir de problèmes.
- Dans la fonction `clePublique`, j'utilise un tableau statique contenant tous les nombres premiers de 1 à 100 et je tire au sort pour déterminer $p$ et $q$ (j'ai rentré directement `p = 61` et `q = 137` pour que les résultats concordent avec notre exemple, mais la partie tirage au sort est commentée).
- Pour lire notre message, on va directement stocker les caractères sous forme de nombre pour que le reste du programme soit plus simple, et pour la sortie on convertit en `char` après le déchiffrement pour afficher une chaîne de caractères.

TODO : parler des libs externes de cryptographie + librairie pour gérer des grands nombres

## Démonstration

*Cette partie n'est pas essentielle pour comprendre le fonctionnement de l'algorithme, mais permet aux curieux de voir comment démontrer que notre système marche. Plusieurs notions mathématiques sont nécessaires pour la compréhension de la démonstration, mais sachez que j'ai appris au fur et à mesure en rédigeant cette partie sans connaitre à l'avance les outils mathématiques utilisés, donc il est tout à fait possible qu'un lecteur fasse de même s'il est intéressé.*

C'est bien beau toutes ces explications, mais mathématiquement comme être sûr que notre algorithme marche à tous les coups ? Comment savoir si notre message original une fois chiffré sera le même quand il est déchiffré ?

Pour cela il faut prouver que l'algorithme RSA est valide, on part donc des deux fonctions de chiffrement et de déchiffrement :

$f(x) = x^e \mod n$  
$f'(x) = x^d \mod n$

Dire que notre algorithme est valide revient à prouver que :

$f(f'(x)) = f'(f(x)) = x \mod n$

Cependant on remarque que :

$f(f'(x)) = (x^d \mod n)^e \mod n$  
$f(f'(x)) = x^{ed} \mod n$

Et :

$f'(f(x)) = (x^e \mod n)^d \mod n$  
$f'(f(x)) = x^{ed} \mod n$

On a $f(f'(x)) = f'(f(x)) = x^{ed} \mod n$, et on cherche donc à démontrer que $x^{ed} \equiv x \pmod pq$ (car $n = pq$). Or d'après le [théorème des restes chinois](https://en.wikipedia.org/wiki/Chinese_remainder_theorem), pour démontrer la congruence $pq$, il suffit de démontrer les congruences $p$ et $q$ séparées. Démontrons d'abord que $x^{ed} \equiv x \pmod p$ :

On va diviser le problème en deux cas, soit $x$ est divisible par $p$, soit il ne l'est pas, donc soit $x \equiv 0 \pmod p$, soit $x \not\equiv 0 \pmod p$, commençons par le premier cas (qui est le plus simple) :

$x$ est un multiple de $p$, donc $x^{ed} \equiv 0 \pmod p$, or $x \equiv 0 \pmod p$, donc $x^{ed} \equiv x \pmod p$.

On continue avec notre deuxième cas où $x$ n'est pas divisible par $p$ :

Tout d'abord, par définition de $e$, $d$ et $m$ :

$ed \equiv 1 \pmod m$  
$ed \equiv 1 \pmod{(p - 1)(q - 1)}$

Ceci signifie que $(p - 1)(q - 1)$ est un diviseur de $ed - 1$, on a :

$ed = 1 + k(p - 1)(q - 1)$ avec $k$ un nombre entier représentant le quotient de $(ed - 1)/(p - 1)(q - 1)$

Donc :

$x^{ed} = x^{1 + k(p - 1)(q -1)}$  
$x^{ed} = x(x^{p - 1})^{k(q -1)}$

Et d'après le [théorème de Fermat](https://en.wikipedia.org/wiki/Fermat's_little_theorem) $x^{p - 1} \equiv 1 \pmod p$ :

$x^{ed} \equiv x(1)^{k(q - 1)} \pmod p$  
$x^{ed} \equiv x \pmod p$

Donc pour tout $x$, on a $x^{ed} \equiv x \pmod p$. La démonstration pour la congruence de $q$ est exactement la même. On a démontré que $x^{eq} \equiv x \pmod{pq}$, et donc que $x^{eq} \equiv x \pmod n$, donc notre algorithme vérifie l'équation au départ confirmant la validité de RSA.

## Sécurité

### Le message

Si vous êtes observateur, vous avez peut-être remarqué que finalement le message chiffré obtenu est le résultat d'une simple [substitution mono-alphabétique](https://en.wikipedia.org/wiki/Substitution_cipher) et que par conséquent chaque lettre sera toujours chiffré de la même façon. Ceci est grave car notre message ne va pas résister longtemps à une cryptanalyse basique. Prenons l'exemple du message "Bienvenue", on a obtenu le résultat suivant `2546 824 4962 8071 2160 4962 8071 5933 4962`, cependant ce message a été chiffré avec une clé publique, et donc comme n'importe qui peut accéder à cette clé, il est facile d'établir un table de correspondance en chiffrant chaque lettre de l'alphabet avec la clé publique afin de déduire à quelle lettre de l'alphabet correspond notre lettre du message chiffré. Ce problème est dû au fait que l'on peut distinguer les différentes lettres dans notre message chiffré, si ce n'était pas le cas on aurait aucune information sur la clé privée utilisée ou encore sur le message déchiffré.

Il est donc nécessaire de procéder autrement afin de sécuriser le message en lui-même et en rendant impossible tout cryptanalyse dessus. Si vous utilisez l'algorithme RSA, il y a de fortes chances que vous êtes sur un ordinateur, cependant sur un ordinateur tout est stocké à l'aide de [bit](https://en.wikipedia.org/wiki/Bit) (une simple unité valant soit 0 soit 1, permettant de compter en [base binaire](https://en.wikipedia.org/wiki/Binary_number)), un groupe de 8 bits est appelé un [octet](https://en.wikipedia.org/wiki/Octet_%28computing%29). Quand votre ordinateur stocke une chaîne de caractère, il stocke en réalité une succession d'octets formant chaque lettre, par exemple dans la table ASCII on peut utiliser un seul octet pour représenter les 128 valeurs car elles ne nécessitent que 7 bits pour être stockées. En sachant cela, on sait qu'une suite d'octet peut être interprété comme une chaîne car pour notre ordinateur tout est un nombre, c'est nous qui lui disons que tel caractère correspond à tel octet (et inversement) avec des tables comme celle ASCII. On pourrait donc représenter notre message non plus comme une suite d'octet mais comme un groupe d'octet uni, ce qui fait qu'au lieu de chiffrer chaque octet on chiffre le tout, rendant alors la cryptanalyse impossible (avec l'ancien système un octet pouvait valoir une des 128 valeurs, mais désormais notre groupe d'octet réuni peut prendre un nombre considérable de valeurs différentes qui augmente avec la taille du message). Il n'y a aucun moyen de trouver des informations à cause de ce groupement, et la seule solution est d'essayer toutes les combinaisons, mais vu le nombre de possibilités, on se rend compte vite que c'est impossible. Prenons par exemple le message "Code" :

| Lettre       | C    | o    | d    | e    |
| -----        | -    | -    | -    | -    |
| Hexadécimale | 0x43 | 0x6F | 0x64 | 0x65 |
| Décimale     | 67   | 111  | 100  | 101  |

J'utilise la notation [hexadécimale](https://en.wikipedia.org/wiki/Hexadecimal) car cette dernière permet de stocker un octet plus simplement qu'en décimale. Notre message devient alors la suite d'octet `0x436F6465` (ce nombre correspond à 1131373669 en décimal) que notre ordinateur peut tout à fait comprendre si on lui indique d'afficher cette suite comme une chaîne. Donc au lieu de chiffrer les nombres `0x43`, `0x6F`, `0x64`, `0x65` séparément on va plutôt chiffrer `0x436F6465` uniquement. Puisqu'on sait que notre message utilise la table ASCII et que cette dernière n'utilise qu'un octet pour représenter toutes les valeurs possibles, on sait qu'une lettre en notation hexadécimale ne prendra pas plus de deux caractères (si on exclut le `0x` qui est juste là pour indiquer que c'est de l'hexadécimal). On peut donc une fois notre nombre déchiffré, le découper en plusieurs nombres (toujours représentés en notation hexadécimale) que l'on va convertir en caractère grâce à la table ASCII.

En C par exemple, il est facile de convertir une chaîne en un nombre hexadécimal et inversement :

[INSERT]
hexadecimal.c

On peut utiliser le spécificateur `x` dans [`printf`](http://www.cplusplus.com/reference/cstdio/printf/) afin de convertir notre lettre en entier hexadécimal. De même, on peut utiliser [`stroul`](http://www.cplusplus.com/reference/cstdlib/strtoul/) afin de convertir notre nombre en base 16 en base 10 et de l'afficher comme un caractère.

En entrée par exemple du programme :

[INSERT]
test03.in

On obtient bien en sortie notre message sous forme d'un nombre hexadécimal :

[INSERT]
test03.out

Cependant quand notre message est important, le nombre obtenu est beaucoup trop grand pour être chiffré, il faut alors découper notre message en plusieurs sous nombres hexadécimaux au lieu d'un seul et appliquer le même principe de chiffrement/déchiffrement.

### Les clés

Désormais qu'on sait que notre message peut être sécurisé, il ne nous reste plus qu'à prouver que notre système de clé asymétrique est fiable car si l'ennemi arrive à calculer la clé privée, il peut déchiffrer le message simplement sans avoir à le casser.

Tout le monde peut théoriquement accéder à la clé publique d'une personne et donc peut connaître $n$ et $e$, mais cela est-il réellement un problème ? Car pour trouver la clé privée il ne nous reste plus qu'à trouver $d$ car on connait déjà $n$, or pour trouver $d$, il nous faut $e$ (que l'on a), mais surtout $m$. Pour rappel $m = (p - 1) \times (q - 1)$, et les seules informations qu'on pourrait avoir sur $p$ et $q$ peuvent venir de $n$ car $n = p \times q$. Il faudrait donc factoriser $n$ en ses deux facteurs premiers $p$ et $q$. Et c'est là que l'histoire se complique, car s'il est facile de trouver et de multiplier deux nombres premiers entre eux, il l'est beaucoup moins pour [décomposer en produit de facteurs premiers](https://en.wikipedia.org/wiki/Integer_factorization). Aujourd'hui, personne n'a encore trouvé d'algorithme qui s'exécute en [temps polynomial](https://en.wikipedia.org/wiki/Time_complexity#Polynomial_time), et le meilleur algorithme qu'on connaisse a une complexité exponentielle (et qui ressemble à ça pour les curieux : $O(\exp((\frac{64b}{9})^{\frac{1}{3}}(\log b)^{\frac{2}{3}}))$). Cependant, la question de l'existence d'un algorithme de décomposition d'un nombre en ses facteurs premiers reste encore ouverte et pourrait jouer un rôle majeur en cryptographie si la réponse était découverte. En attendant, on peut jouer sur le fait qu'il est donc très long de décomposer $n$, et qu'il faudrait beaucoup de moyens pour trouver une clé de chiffrement privée en un temps raisonnable. C'est pourquoi il faut choisir la taille de ses clés avec attention et les renouveler si possible régulièrement. 

Aujourd'hui une clé est "sécurisée" si elle contient entre 2048 et 4096 bits, mais "sécurisé" n'est pas entre guillemets pour rien car certes votre voisin sera incapable de casser votre clé, certes votre groupe de hacker préféré non plus (à part s'ils ont des moyens colossaux à leur disposition), mais par contre une agence gouvernementale pourrait éventuellement y arriver. En effet des agences comme la NSA ont d'énorme moyens techniques mis en œuvre (qui évoluent, mais on a une petite idée grâce aux révélations de [Snowden](https://en.wikipedia.org/wiki/Edward_Snowden) en 2013), et même si sur une grande échelle ils ne peuvent pas casser toutes les clés aussi importantes que cela, il est possible pour eux de casser quelques-unes en particulier si elles sont d'un très haut niveau d'importance pour eux. Pour cela, l'agence utilise des [superordinateurs](https://en.wikipedia.org/wiki/Supercomputer) qui souvent sont construits et optimisés spécifiquement dans le but de casser telle ou telle clé, et ils investissent des millions (voir des milliards selon leur budget annuel) dans la recherche afin de trouver une factorisation en un temps raisonnable (d'environ un an). En plus de cela, l'agence peut faire des pressions sur des organisations contenant des données sensibles, on retiendra notamment l'affaire [lavabit](https://en.wikipedia.org/wiki/Lavabit) où la NSA a obligé le créateur de ce service de mail chiffré à divulguer des informations secrètes à propos d'Edward Snowden, le créateur ne pouvait en aucun cas parler de cette affaire au grand public sous peine d'emprisonnement et d'amende considérable, et fut finalement forcé de fermer son système de communication afin de ne pas coopérer avec la NSA. De nombreuses autres affaires de pression de la part de la NSA ou de gouvernements en général existent, et elles montrent bien la détermination de certaines agences dans le but de trouver les clés privées de certains individus.

TODO : renseigner sur le temps nécessaire pour la factorisation

### Transmission de la clé

TODO : refaire la partie signature numérique pour résoudre le problème d'usurpation d'identité

Le principe est plutôt simple, on a vu que pour un message $x$, on a $f(f'(x)) = f'(f(x)) = x \mod n$. Lorsqu'on veut signer notre message et certifier que c'est nous qu'il l'avons envoyé, on va dans un premier temps chiffré notre message avec notre clé privée, puis on le chiffre de nouveau avec la clé publique de la personne à qui on souhaite envoyer le message. Une fois que la personne le reçoit, elle va déchiffrer avec sa clé privée le message puis, elle va le déchiffrer avec votre clé publique (car on a chiffré dans un premier temps avec notre propre clé privée). Comme vous êtes le seul à connaitre votre clé privée, le destinataire est sûr que vous êtes l'auteur de ce message.

Malheureusement, sur de grands messages, ça prend beaucoup de temps de chiffrer et déchiffrer deux fois au lieu d'une. On a donc eu l'idée d'utiliser une [fonction de hachage](https://en.wikipedia.org/wiki/Hash_function), cette fonction prend en entrée un message, un nombre, une image, n'importe et lui associe une **empreinte** unique de taille fixe (il suffit de changer une partie minime du message pour avoir une empreinte totalement différente), et cette empreinte ne permet en aucun cas de retrouver l'entrée de la fonction de hachage. Il est possible que vous en ayez déjà entendu parler ou même utiliser si par exemple vous utilisez Linux car lorsque vous téléchargez l'image d'une distribution, il est souvent possible de vérifier l'intégrité et la validité de l'image grâce à un programme utilisant une fonction de hachage comme [SHA-1](https://en.wikipedia.org/wiki/SHA-1) ou encore [MD5](https://en.wikipedia.org/wiki/MD5). On va donc donner à notre fonction de hachage notre message en clair, et c'est l'empreinte que l'on va chiffrer avec notre clé privée, on la joint au message que l'on veut transmettre on chiffre le tout avec la clé publique du destinataire et on l'envoie. Une fois que la personne reçoit le message, elle le déchiffre avec sa clé privée et déchiffre l'empreinte jointe avec la clé publique de l'émetteur, elle va ensuite vérifier l'empreinte et en réalisant une de son côté (avec la même fonction de hachage que celle utilisée par l'émetteur) et va donner le message déchiffré à cette fonction, si l'empreinte est la même alors on est sûr que le message est complet, non modifié et provient bien du destinataire. Cette méthode est bien plus courte et rapide car on chiffre/déchiffre uniquement deux fois l'empreinte et non pas le message entier.

TODO : AES (cryptographie hybride)
TODO : transmission physique pour plus de sécurité (valise diplomatique)

## Cassage

Notre système est donc théoriquement sécurisé, et le seul moyen que l'on connait pour le moment est d'investir beaucoup d'argent et de temps pour factoriser $n$. Cependant, tout le monde n'utilise pas RSA à la perfection, et on peut trouver certaines failles dans des utilisations de cet algorithme qui permettent d'autres types d'attaques.

### L'attaque de l'homme du milieu

Imaginons que Alice souhaite communiquer avec Bob, pour cela ils s'échangent leurs clés publiques. Cependant, Carole qui est une méchante personne, intercepte la clé publique de Bob qu'il a envoyé à Alice, et Carole va envoyer sa propre clé publique. Désormais, lorsqu'Alice va chiffrer son message avec la soi-disant clé de Bob, elle le chiffre en réalité avec celle de Carole, ce qui signifie que lorsque Alice envoie un message chiffré à Bob, si Carole l'intercepte elle va déchiffrer le message, le lire, potentiellement le modifier, et le chiffrer avec la clé publique de Bob avant de lui renvoyer. Ainsi, Alice et Bob ne se doutent de rien et pensent que leur communication est sécurisée, mais Carole a pu lire et modifier leurs messages.

Cette attaque peut être extrêmement gênante, et avec Internet c'est encore plus simple de la réaliser car vous n'êtes jamais réellement sûr que votre communication va directement à un autre serveur sans passer par un ordinateur d'un ennemi. Mais on peut contrer cette attaque grâce à plusieurs techniques, tout d'abord l'utilisation d'un annuaire contenant toutes les clés publiques de chaque personne ne nécessiterait plus la communication de clés. Cependant, il est possible que Carole soit très puissante et soit capable de modifier cet annuaire. 

TODO : solution :
   - intermédiaire de confiance
   - identification biologique
   - transmission physique
   - autorité de certification

### L'attaque d'Håstad

## Conclusion

TODO : ouverture cryptographie quantique pour transmettre la clé de manière 100% sécurisé face à des ordinateurs non quantiques + ordinateur quantique pour casser des clés rapidement (d-wave)
