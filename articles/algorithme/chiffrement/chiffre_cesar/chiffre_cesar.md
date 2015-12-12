Chiffre de César
================
algo/chiffrement

Publié le : 21/05/2014  
*Modifié le : 12/12/2015*

## Introduction

TODO : faire intro

Les premiers algorithmes de chiffrement ne datent pas de Jules César, mais ce dernier 

Le chiffre de César (aussi appelé *chiffrement par décalage*) est un algorithme de chiffrement **symétrique** très simple utilisé par Jules César pour communiquer des messages secrets. Cet algorithme n’est pas du tout sécurisé pour deux raisons que nous aborderons après avoir vu le chiffrement et le déchiffrement.

## Principe de l’algorithme

Le chiffre de César (aussi appelé *chiffrement par décalage*) utilise une [substitution mono-alphabétique](https://en.wikipedia.org/wiki/Substitution_cipher) pour chiffrer et déchiffrer un message, c’est-à-dire que l’on décale de *x* rangs vers la droite dans l’alphabet la lettre du message lors du chiffrement, et de *x* rangs vers la gauche lors du déchiffrement. On appelle *x* la **clé de chiffrement**, et cette dernière doit être la même pour le chiffrement et le déchiffrement car le chiffre de César est un [chiffrement symétrique](https://en.wikipedia.org/wiki/Symmetric-key_algorithm).

## Exemple

Prenons le mot "Linux", que l’on va chiffrer puis déchiffrer à l’aide du chiffre de César et avec une clé de chiffrement de 2.

![Exemple de chiffrement](//static.napnac.ga/img/algo/chiffrement/chiffre_cesar/exemple_chiffrement.png)

On a deux alphabets représentés, un normal et un autre décalé de 2 rangs vers la droite (car c'est notre clé de chiffrement). Cette représentation permet de facilement visualiser le décalage puisqu'il suffit de regarder la case correspondante dans le nouvel alphabet pour chiffrer notre message. Chaque lettre (représentée en bleu) de notre message en clair aura donc une lettre équivalente (représentée en vert) dans le nouvel alphabet.

![Exemple de déchiffrement](//static.napnac.ga/img/algo/chiffrement/chiffre_cesar/exemple_dechiffrement.png)

De la même manière, pour le déchiffrement il suffit de faire correspondre les lettres de notre nouvel alphabet, à celui normal afin de lire notre message chiffré.

## Pseudo-code

Le pseudo-code du chiffre de César est très simple :

```nohighlight
chiffrer :

   Pour chaque caractère du message
      Si c'est une lettre
         Décaler cette lettre de x rangs vers la droite

déchiffrer :

   Pour chaque caractère du message
      Si c'est une lettre
         Décaler cette lettre de x rangs vers la gauche 
```

Il faut cependant faire attention à une chose, lorsqu'on dépasse la lettre Z pendant le chiffrement, il faut pouvoir revenir au début de l'alphabet, comme une sorte de boucle et inversement avec la lettre A lors du déchiffrement.

## Implémentation

Une implémentation en C du chiffre de César :

[INSERT]
chiffre_cesar.c

TODO : explication code

## Cassage

Cet algorithme de chiffrement possède cependant des failles, et il est tout à fait possible de le "casser", c'est-à-dire d'obtenir le message original sans posséder la clé de chiffrement.

### Force brute

L'attaque par force brute (*brute force attack* en anglais), consiste simplement à tester toutes les possibilités de clé de chiffrement une par une, jusqu'à trouver la bonne.

Le problème avec le chiffre de César est qu'il n'existe en réalité que 26 uniques possibilités de clé de chiffrement. En effet, si l'on utilise une clé supérieure à 26 cela revient à utiliser une clé de *x mod 26*, par exemple si je chiffre le mot "Linux" avec une clé de chiffrement de 28 j'obtiens exactement le même résultat qu'avec ma clé de 2 car *28 mod 26 = 2*. Il est de même pour les clés négatives, si j'utilise une clé de -1 cela revient à utiliser une clé de 25.

Notre attaque nécessite donc l'analyse d'uniquement 26 clés de chiffrement, ce qui n'est rien pour un ordinateur qui peut faire des milliards d'opérations à la seconde :

```nohighlight
forceBrute :

   Pour chaque clé allant de 1 à 26, à pas de 1
      déchiffrer(message)
      Afficher message déchiffré
```

Une implémentation en C de cette attaque :

[INSERT]
force_brute.c

Ici vu qu'il n'y a que 26 possibilités, on se contente d'afficher tous les messages déchiffrés pour que l'utilisateur voit directement lequel ressemble à du français (on pourrait aussi implémenter un système qui différencie des phrases en français de phrases sans aucuns sens, mais l'implémentation se focalise uniquement sur l'attaque).

Cette méthode est assez bourrin, car tester toutes les combinaisons possibles est souvent une mauvaise idée, cependant dans notre cas où on sait qu’il n’y a que 26 possibilités à tester, cette méthode devient tout de suite le choix parfait pour casser le chiffre de César. En plus d’être extrêmement rapide, elle est aussi très simple à mettre en place car une simple boucle suffit.

### Analyse fréquentielle

L'analyse fréquentielle (*frequency analysis* en anglais) examine la fréquence d'apparition des lettres employées dans le message chiffré afin d'en deviner la clé pour le déchiffrer ensuite.

Cette attaque est possible sur le chiffre de César car c'est un système de chiffrement à **substitution mono-alphabétique** ce qui signifie que si l’on chiffre plusieurs fois la lettre A avec une même clé de chiffrement *x*, alors la lettre chiffrée sera toujours la même. Ce type de système s’oppose donc à la **substitution poly-alphabétique** utilisée par le [chiffre de Vigenère](/algo/chiffrement/chiffre_vigenere.html) par exemple. De plus, l'analyse fréquentielle repose sur le fait que chaque langue possède des lettres plus utilisées que d'autres (en français par exemple la lettre E est plus utilisée que la lettre D, la lettre H l'est moins que la lettre O, etc.).

On peut donc analyser la fréquence d'apparition de chaque lettre dans notre message chiffré, et en déduire la lettre correspondante dans le message clair en établissant un lien avec les lettres les plus utilisées en français (on suppose ici que notre message a été écrit en français avant d'être chiffré).

Par exemple, si dans notre message chiffré on remarque que la lettre M est la plus utilisée, on peut en déduire que c'est la lettre E dans notre message clair. Ce qui signifie que l'on peut calculer la différence de rangs entre les deux lettres pour avoir la clé de chiffrement (si M correspond effectivement à E). Pour confirmer notre hypothèse, on peut continuer en cherchant la différence de rangs entre la deuxième lettre la plus utilisée en français (le A) et la deuxième lettre la plus employée dans notre message chiffré. Si les deux clés correspondent, il y a alors de forte chances que ce soit la bonne clé de chiffrement.

Le pseudo-code de l’attaque par analyse fréquentielle :

```nohighlight
analyseFréquentielle :

   Déterminer le nombre d’occurrence de chaque lettre

   Pour chaque lettre possible
      Déduire la lettre correspondante dans le message clair
   Afficher les possibilités de clés de chiffrement (dans l'ordre de pertinence)
```

Dans ce pseudo-code on se contente d'afficher par ordre de pertinence nos possibilités de clés pour chaque lettre.

Sur de petits textes, cette attaque risque de ne pas bien fonctionner car notre méthode repose sur des statistiques et si on n'a pas assez de données, on ne devinera pas forcément la clé du premier coup, alors que sur un long texte la première clé affichée est très souvent la bonne.

L'attaque codée en C :

[INSERT]
analyse_frequentielle.c

Cette méthode d'attaque n'est pas réellement adaptée au chiffre de César puisqu'on peut simplement utiliser l'attaque par force brute, cependant d'autres algorithmes de chiffrement n'ont pas aussi peu de possibilités de clés que le chiffre de César, et casser ces derniers nécessite donc une attaque plus réfléchie et plus intelligente comme l'analyse fréquentielle.

## Conclusion

TODO : faire conclusion

Le chiffre de César est donc un algorithme de chiffrement symétrique ancien, et très simple. Cependant, il est vulnérable à plusieurs attaques comme celle de la force brute ou celle de l’analyse fréquentielle ce qui le rend inutile de nos jours.
