Chiffre de César
================
algo/chiffrement

Publié le : 21/05/2014  
*Modifié le :*

## Introduction

Le chiffre de César (aussi appelé *chiffrement par décalage*) est un algorithme de chiffrement **symétrique** très simple utilisé par Jules César pour communiquer des messages secrets. Cet algorithme n’est pas du tout sécurisé pour deux raisons que nous aborderons après avoir vu le chiffrement et le déchiffrement.

## Principe de l’algorithme

Le chiffre de César utilise une **substitution mono-alphabétique** pour chiffrer et déchiffrer un message, c’est-à-dire que l’on décale de *x* rangs dans l’alphabet vers la droite la lettre du message lors du chiffrement, et l’on décale de *x* rangs vers la gauche la lettre lors du déchiffrement (*x* est appelé la **clé de chiffrement**, et doit bien entendu être la même lors du chiffrement et du déchiffrement puisque le chiffre de César est un chiffrement symétrique).

Le fait que la substitution soit mono-alphabétique signifie que si l’on chiffre plusieurs fois la lettre A avec une clé de chiffrement *x*, alors la lettre chiffrée sera toujours la même, ce type de système s’oppose donc à la **substitution poly-alphabétique** utilisée par le [chiffre de Vigenère](http://napnac.ga/algo/chiffrement/chiffre_vigenere.html) par exemple.

## Exemple

Prenons le mot Linux, que l’on va chiffrer puis déchiffrer à l’aide du chiffre de César et avec une clé de chiffrement de 2 (on va donc décaler les lettres du message de deux rangs dans l’alphabet).

Voici une image indiquant le rang de chaque lettre de l’alphabet (bien pratique pour ce genre d’algorithme) :
rangs-alphabet

### Chiffrement

Linux -> Ninux : La lettre L est la 12ème lettre dans l’alphabet, la clé est de 2, donc on décale de deux rangs dans l’alphabet vers la droite ce qui nous donne le rang 14 qui est la lettre N.
Ninux -> Nknux : Pareil pour la lettre I, on décale de deux rangs vers la droite et on obtient la lettre K.
Nknux -> Nkpux
Nkpux -> Nkpwx
Nkpwx -> Nkpwz

Nkpwz

Nous avons donc notre message chiffré : Nkpwz.

### Déchiffrement

Pour le déchiffrement on décale cette fois-ci de deux rangs vers la gauche :

Nkpwz -> Lkpwz : N est la 14ème lettre de l’alphabet on décale donc de deux rangs vers la gauche et on obtient la lettre L.
Lkpwz -> Lipwz : K est la 11ème lettre de l’alphabet on décale donc de deux rangs vers la gauche et on obtient la lettre I.
Lipwz -> Linwz
Linwz -> Linuz
Linuz -> Linux

Linux

On obtient bien notre message de départ : Linux.

Quelques remarques sur cet algorithme :

- Il se peut que lors du chiffrement vous dépassez la lettre Z après avoir décalé de *x* rangs vers la droite, dans ce cas il suffit juste de revenir au début de l’alphabet et de continuer à décaler à partir de la lettre A.
- Pareil lors du déchiffrement, si vous dépassez A après voir décalé vers la droite, alors continuer de décaler à partir de la lettre Z.

## Pseudo-code

Le pseudo-code du chiffre de César est très simple :

```nohighlight
chiffrer(Message, clé) :
   Pour chaque caractère de Message
      Si c'est une lettre
         Décaler cette lettre de clé rangs dans l'alphabet

déchiffrer(Message, clé) :
   Pour chaque caractère de Message
      Si c'est une lettre
         Décaler cette lettre de -clé rangs dans l'alphabet
```

Je vous explique plus en détail comment décaler une lettre dans l’alphabet dans l’implémentation en C.

## Implémentation

Le lien vers une implémentation en C du chiffre de César :

main.c : 

Ce code est simple, voici quelques remarques à propos :

- Dans la fonction `chiffrement`, on teste premièrement si le caractère actuel est une lettre (soit une majuscule, soit une minuscule), puis on récupère le rang de la lettre dans l’alphabet (pour cela on utilise la [table ASCII](http://www.table-ascii.com/) d’où le *– ‘A’*, cela facilite les calculs après), on lui ajoute la valeur de notre clé et on lui applique un [modulo]() 26 dans le cas où l’on dépasse la lettre Z pour revenir à la lettre A, de plus si la lettre est négative (dans le cas d’une clé négative par exemple car en C un modulo d’un nombre négatif est négatif) on lui ajoute 26 pour la rendre positive et on refait un modulo 26 dans le cas où elle dépasse Z. Enfin on retourne à la valeur ASCII de la lettre trouvée à l’aide du *+ ‘A’*.
- Dans la fonction `dechiffrement`, le principe est le même la seule différence avec la fonction `chiffrement` est le fait qu’au lieu d’ajouter la clé (décalage vers la droite) on la retire (décalage vers la gauche), tout le reste du code est pareil.

## Cassage

Maintenant je vais vous présenter deux manières de casser le chiffre de César, c’est-à-dire d’obtenir le message original sans la clé de chiffrement.

### Force brute

Première méthode extrêmement simple et très facile à implémenter, cette méthode consiste à tester toutes les possibilités possibles de clés et de voir laquelle permet de transformer le message chiffré en une phrase écrite en français.

Il existe en tout 26 possibilités de clé de chiffrement pour le chiffre de César. En effet, si l’on utilise une clé supérieure à 26 cela revient à utiliser une clé de *cle % 26*, par exemple si j’utilise une clé de 28 sur notre exemple (Linux), j’obtiens le même message chiffré qu’avec une clé de 2 (*28 % 26 = 2*). Pareil pour les nombres inférieurs à 26, par exemple si j’utilise une clé de -1 cela revient à utiliser une clé de 25 (vous pouvez faire le test avec le programme que je vous ai fourni).

Pour utiliser la méthode de la force brute, il vous suffit de suivre ce pseudo-code :

```nohighlight
forceBrute(Message) :
   Pour clé = 1, allant jusqu'à 26 à pas de 1
      déchiffrer(Message, clé)
      Afficher Message

déchiffrer(Message, clé) :
   Pour chaque caractère de Message
      Si c'est une lettre
         Décaler cette lettre de -clé rangs dans l'alphabet
```

Le lien vers le code pour casser le chiffre de César à l’aide de la méthode force brute :

main.c : 

Cette méthode est assez "bourrin", en effet tester toutes les possibilités possibles est souvent une mauvaise idée. Cependant, dans ce cas où l’on sait qu’il n’y a que 26 possibilités à tester, cette méthode devient tout de suite le choix parfait pour casser le chiffre de César. En plus d’être extrêmement rapide, elle est aussi très simple à mettre en place, une simple boucle suffit.

### Analyse fréquentielle

Une autre méthode pour casser le chiffre de César existe, elle consiste à analyser la fréquence d’apparition des lettres dans le message pour deviner la clé de chiffrement.

L’un des principaux points faibles du chiffre de César est que si je chiffre un message comportant dix fois la lettre A avec une clé de 1, alors j’aurais dix fois la lettre B dans le message. L’analyse fréquentielle repose sur le fait que dans chaque langue il existe des lettres plus utilisées que d’autres. En français par exemple, la lettre E est plus utilisé que la lettre D, la lettre H l’est moins que la lettre O.

Voici l’ordre par ordre croissant des lettres les plus utilisées en français : e, a, i, s, t, n, r, u, l, o, d, m, p,c, v, q, g, b, f, j, h, z, x, y, k, w.

À partir de cela on peut donc émettre des hypothèses sur le message chiffré. En effet, si ce dernier contient une grande majorité de M, alors il y a de fortes chances que le M soit dans le message original la lettre E. On peut donc facilement trouver la clé de chiffrement dans cet exemple en trouvant le nombre de lettre située entre E et M.

Le pseudo-code de l’analyse fréquentielle est plutôt simple :

```nohighlight
analyseFréquentielle(Message) :
   Déterminer le nombre d’occurrence de chaque lettre
   Déterminer pour chaque lettre la clé possible
   Afficher les clés de chiffrement dans l'ordre des lettres suivant : e, a, i, s, t, n, r, u, l, o, d, m, p,c, v, q, g, b, f, j, h, z, x, y, k, w.
```

Ce pseudo-code est très simple, on peut reprendre notre exemple pour mieux comprendre : on cherche le nombre d’occurrences pour chaque lettre (on le fait une seule fois dans le programme), on voit que la lettre qui apparaît le plus de fois est M, on émet l’hypothèse que la lettre M est la lettre E dans le message déchiffré car M apparaît le plus de fois dans le message et la lettre E est la lettre la plus utilisée en français, pour déterminer la clé (selon notre hypothèse) il suffit de trouver le nombre de rangs dans l’alphabet entre la lettre E et M qui est de 8, on affiche donc comme premier choix de clé 8. On répète cette étape d’hypothèse pour chacune des lettres, par exemple si la deuxième lettre qui apparaît le plus est I, alors on émet comme hypothèse que I est la lettre A dans le message déchiffré (car A est la deuxième lettre la plus utilisée en français), on trouve ensuite comme clé 8 que l’on affiche comme second choix de clé. On continue jusqu’à avoir les 26 clés possibles, qui ne sont pas toutes pareilles mais je vous conseille de seulement regarder les trois premières possibilités.

Cependant sur de petits textes, l’analyse fréquentielle ne fonctionne pas forcément très bien, mais sur de longs textes il n’y a pas de soucis. Les trois premières clés qui sont affichés seront presque toujours les bonnes clés de chiffrement.

Un lien vers le code C d’une implémentation d’une analyse fréquentielle :

main.c : 

Ce programme affiche les clés de chiffrement supposés dans l’ordre ainsi que le message déchiffré avec la première clé déterminée, le message n’est pas toujours le bon (sur de petits textes), mais l’est très souvent sur de plus grands. Comme vous pouvez le voir j’ai chiffré un texte plus long que le mot Linux, vous pouvez voir que le programme n’a aucun mal à trouver la bonne clé de chiffrement (affichée en premier) et m’affiche bien mon texte original que j’ai écrit.

Le programme en C est très simple, je ne pense pas que des explications soit nécessaires.

L’analyse fréquentielle reste plus longue est plus coûteuse que la force brute, cependant dans d’autres algorithmes de chiffrement où la méthode de force brute n’est pas possible l’analyse fréquentielle est fondamentale et très utile.

## Conclusion

Le chiffre de César est donc un algorithme de chiffrement symétrique ancien, et très simple. Cependant, il est vulnérable à plusieurs attaques comme celle de la force brute ou celle de l’analyse fréquentielle ce qui le rend inutile de nos jours.
