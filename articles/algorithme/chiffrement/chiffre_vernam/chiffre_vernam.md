Chiffre de Vernam
=================
algo/chiffrement

Publié le : 29/05/2014  
*Modifié le : 17/12/2015*

## Introduction

Le chiffre de Vernam est considéré comme une amélioration significative du [chiffre de Vigenère](/algo/chiffrement/chiffre_vigenere.html) car cet algorithme de chiffrement est théoriquement impossible à casser. Cependant, aucuns systèmes de chiffrement n'est parfait, et même si ce dernier semble sécurisé, il n'est pas toujours facile de remplir les conditions pour avoir un message chiffré totalement sûr.

TODO : bosser intro

## Principe de l'algorithme

Le chiffre de Vernam (ou *masque jetable*) est un [chiffrement symétrique](https://en.wikipedia.org/wiki/Symmetric-key_algorithm) utilisant, comme le chiffre de Vigenère, une [substitution poly-alphabétique](https://en.wikipedia.org/wiki/Substitution_cipher#Polyalphabetic_substitution). Son efficacité réside dans le choix de la clé de chiffrement, qui doit respecter plusieurs règles fondamentales :

- Chaque clé est **unique**, et cette dernière ne doit pas être réutilisée (d'où le nom de masque jetable).
- La clé doit avoir au moins autant de caractères que le message que l'on veut chiffrer.
- Chacun des caractères de la clé doit être choisi totalement aléatoirement.

## Exemple

Le mot que l'on va chiffrer est "Algorithme", et la première étape du chiffre de Vernam est donc de créer notre clé en respectant les trois contraintes. J'ai donc créé de mon côté une clé de chiffrement (que je n'ai jamais utilisé avant, qui fait la même taille que le message et que j'ai choisi aléatoirement) : "shrtvsgviw".

Le mode de fonctionnement du chiffrement et du déchiffrement est exactement le même que pour le chiffre de Vigenère, je vous invite donc à la lire la partie [exemple](/algo/chiffrement/chiffre_vigenere.html#exemple) à ce propos.

J'obtiens donc finalement comme texte chiffré "Ssxhmazcua".

## Pseudo-code

La seule partie à modifier du pseudo-code du chiffre de Vigenère est la création de la clé :

```nohighlight
creerCle :

   Tant que la clé générée a déjà été utilisé

      Pour chaque lettre du message 
         Generer une lettre aléatoire pour notre clé
```

## Implémentation

TODO : implé génération + évoquer solution pour vérifier si déjà utilisé ou non (dichotomie, table de hachage, etc.).

## Cassage ?

## Conclusion
