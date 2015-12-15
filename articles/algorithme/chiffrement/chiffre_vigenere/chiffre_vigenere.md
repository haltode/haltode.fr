Chiffre de Vigenère
===================
algo/chiffrement

Publié le : 28/05/2014  
*Modifié le : 15/12/2015*

## Introduction

TODO : faire intro

## Principe de l'algorithme

Le chiffre de Vigenère est un [chiffrement symétrique](https://en.wikipedia.org/wiki/Symmetric-key_algorithm) utilisant une [substitution poly-alphabétique](https://en.wikipedia.org/wiki/Substitution_cipher#Polyalphabetic_substitution) pour chiffrer et déchiffrer le message secret. Ce qui signifie que la clé de chiffrement n'est plus un nombre (comme avec le [chiffre de César](/algo/chiffrement/chiffre_cesar.html)), mais une chaîne de caractères entière. L'algorithme repose sur ce principe, pour offrir plus de sécurité car une même lettre ne sera alors pas forcément chiffrée de la même façon (elle dépendra de sa place dans le message, mais aussi de la clé utilisée).

## Exemple

Prenons comme message secret le mot "Programmation", et comme clé de chiffrement "Linux". La première étape à faire est de rendre notre clé aussi longue que notre message à chiffrer, pour cela, on répète simplement autant de fois la clé que nécessaire :

![Visualisation de la clé de chiffrement complète](//static.napnac.ga/img/algo/chiffrement/chiffre_vigenere/exemple_cle_chiffrement.png)

Désormais on peut chiffrer notre message :

![Exemple de chiffrement](//static.napnac.ga/img/algo/chiffrement/chiffre_vigenere/exemple_chiffrement.png)

Le rang dans l'alphabet commence à 0 car *26 mod 26 = 0*, il faut donc que la lettre A soit la lettre 0. A chaque tour, on prend le rang de la lettre du message, et on l'additionne à la lettre correspondante de la clé. On n'oublie pas d'appliquer notre [modulo](https://en.wikipedia.org/wiki/Modulo_operation) 26 pour revenir au début de l'alphabet si on dépasse Z.

Et pour le déchiffrement du message :

![Exemple de déchiffrement](//static.napnac.ga/img/algo/chiffrement/chiffre_vigenere/exemple_dechiffrement.png)

L'idée est la même sauf qu'on soustrait au lieu d'ajouter le rang de la lettre de la clé.

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

Notez qu'on doit vider le buffer, car notre message et notre clé sont deux chaînes de caractères (pouvant donc contenir des espaces) et séparées par un retour à la ligne. Ensuite, au lieu de créer une seconde clé de chiffrement de la taille du message, on peut tout simplement utiliser un index que l'on réinitialise à 0 à chaque fois qu'il a atteint le bout de la clé (grâce à `% tailleCle`).

Notre message et notre clé :

[INSERT]
test01.in

Le chiffrement et le déchiffrement :

[INSERT]
test01.out

## Cassage

Les attaques du chiffre de César ne fonctionnent pas sur le chiffre de Vigenère pour plusieurs raisons :

- La clé est une chaîne de caractères de taille variable, ce qui signifie que le nombre de possibilités de clés de chiffrement est énorme, et une attaque par force brute n'est tout simplement pas envisageable.
- L'algorithme utilise une substitution poly-alphabétique, rendant ainsi une analyse fréquentielle impossible car une lettre ne sera pas forcément chiffrée de la même manière dans un texte.

Il nous faut donc de nouvelles méthodes, afin de casser cet algorithme réputé incassable jusqu'à la fin du XIXe siècle où une méthode fut officiellement découverte.

TODO : faire cassage

### Trouver la longueur de la clé de chiffrement

#### Test de Kasiski

#### Indice de coïcidence

### Déduire la clé

#### Analyse fréquentielle

## Conclusion

TODO : faire conclusion
