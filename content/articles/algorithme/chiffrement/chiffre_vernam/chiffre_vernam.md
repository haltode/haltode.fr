Path: algo/chiffrement  
Title: Chiffre de Vernam  
Published: 29/05/2014  
Modified: 20/12/2015  

## Introduction

Le chiffre de Vernam est considéré comme une amélioration significative du [chiffre de Vigenère](/algo/chiffrement/chiffre_vigenere.html) car cet algorithme de chiffrement est théoriquement impossible à casser. Cependant, aucuns systèmes de chiffrement n'est parfait, et même si ce dernier semble sécurisé, il n'est pas toujours facile de remplir les conditions pour avoir un message chiffré totalement sûr.

## Principe de l'algorithme

Le chiffre de Vernam (ou *masque jetable*) est un [chiffrement symétrique](https://en.wikipedia.org/wiki/Symmetric-key_algorithm) utilisant, comme le chiffre de Vigenère, une [substitution poly-alphabétique](https://en.wikipedia.org/wiki/Substitution_cipher#Polyalphabetic_substitution). Son efficacité réside dans le choix de la clé de chiffrement, qui doit respecter plusieurs règles fondamentales :

- Chaque clé est **unique**, et cette dernière ne doit pas être réutilisée (d'où le nom de masque jetable).
- La clé doit avoir au moins autant de caractères que le message que l'on veut chiffrer.
- Chacun des caractères de la clé doit être choisi totalement aléatoirement.

## Exemple

Le mot que l'on va chiffrer est "Algorithme", et la première étape du chiffre de Vernam est de créer notre clé en respectant les trois contraintes. J'ai donc généré de mon côté une clé de chiffrement (que je n'ai jamais utilisé avant, qui fait la même taille que le message et que j'ai choisi aléatoirement) : "shrtvsgviw".

Le mode de fonctionnement du chiffrement et du déchiffrement est exactement le même que pour le chiffre de Vigenère, je vous invite donc à la lire la partie [exemple](/algo/chiffrement/chiffre_vigenere.html#exemple) à ce propos.

Finalement, j'obtiens comme texte chiffré "Ssxhmazcua".

## Pseudo-code

On peut tout à fait reprendre le même pseudo-code que le chiffre de Vigenère pour la partie chiffrement/déchiffrement, en revanche, il nous faut une nouvelle fonction permettant de générer notre clé :

```nohighlight
creerCle :

   Tant que la clé générée a déjà été utilisée

      Pour chaque lettre du message 
         Generer une lettre aléatoire pour notre clé
```

Pour savoir si on a déjà utilisé une clé, plusieurs solutions s'offrent à nous. On peut tout d'abord utiliser un simple tableau qui stockera toutes les clés utilisées, et à chaque fois que l'on en génère une nouvelle, on vérifie qu'elle n'est pas dans notre tableau avant de l'ajouter. Il est aussi possible d'améliorer cette solution en utilisant une [recherche dichotomique](/algo/recherche/dichotomie.html), nous permettant dans notre tableau (trié par ordre alphabétique) de chercher rapidement si une clé a déjà été générée ou non.

## Implémentation

L'implémentation en C d'un programme générant une clé de chiffrement pour le chiffre de Vernam :

[[secret="chiffre_vernam.c"]]

```c
#include <stdio.h>
#include <ctype.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define TAILLE_MAX 1000
#define NB_CLE_MAX 1000

char message[TAILLE_MAX];
char cle[TAILLE_MAX];

char utilisee[NB_CLE_MAX][TAILLE_MAX];
int nbCle;

void initCleUtilisee(void)
{
   FILE *fichierCle;

   fichierCle = fopen("cle_utilisee.txt", "r");

   nbCle = 0;
   while(fscanf(fichierCle, "%s\n", utilisee[nbCle]) != EOF)
      ++nbCle;

   fclose(fichierCle);
}

bool estDejaUtilisee(void)
{
   int iCle;

   for(iCle = 0; iCle < nbCle; ++iCle)
      if(strcmp(cle, utilisee[iCle]) == 0)
         return true;

   return false;
}

void creerCle(void)
{
   int iCle, iLettre;

   do
   {
      iCle = 0;

      for(iLettre = 0; message[iLettre] != '\0'; ++iLettre) {
         if(isalpha(message[iLettre])) {
            cle[iCle] = (rand() % 26) + 'a';
            ++iCle;
         }
      } 

      cle[iCle] = '\0';

   } while(estDejaUtilisee());
}

void ajouterCle(void)
{
   FILE *fichierCle;

   fichierCle = fopen("cle_utilisee.txt", "a");
   fprintf(fichierCle, "%s\n", cle);
   fclose(fichierCle);
}

int main(void)
{
   scanf("%[^\n]s\n", message);

   srand(time(NULL));

   initCleUtilisee();
   creerCle();

   printf("%s\n", cle);
   ajouterCle();

   return 0;
}
```

[[/secret]]

En entrée :

```nohighlight
Algorithme
```

La sortie que j'ai obtenue (elle change à chaque fois) :

```nohighlight
shrtvsgviw
```

Le fichier de clés qui ont déjà été générées (et donc inutilisable maintenant) :

```nohighlight
dovcexdoba
ckdexeiezr
zmagzxogpx
unrhlaiurn
imizbftejl
ewqeuyhcro
concvckybe
oplngklamk
mwesglgezw
ervpcfgzqj
jyivvrlokb
duunlvvlkt
amyopgkotw
wfwwnvpjvn
qssplvtpkj
shrtvsgviw
```

J'utilise une simple recherche (et non une recherche dichotomique) car le nombre de clés que je vais manipuler est assez faible (j'ai fixé une limite virtuelle à 1000 clés).

## Cassage

Les attaques du chiffre de Vigenère (ou du chiffre de César) ne sont plus possibles sur le chiffre de Vernam, et c'est ce qui le rend incassable :

- Le test de Kasiski ne fonctionne plus car notre clé doit être au moins aussi longue que notre message, donc il n'y aura pas de répétition de ladite clé.
- Il est impossible de deviner la clé de chiffrement, car elle est totalement aléatoire et n'importe quelle lettre du message peut être chiffrée avec n'importe quelle autre lettre de l'alphabet.
- Une analyse fréquentielle ne peut pas marcher car le texte ne nous donne aucunes indications à cause de la clé aléatoire employée.
- Une attaque par force brute ne serait pas envisageable non plus, vu le nombre de possibilités.

## Défauts

Notre algorithme de chiffrement est donc techniquement impossible à casser si les règles permettant de choisir une clé de chiffrement sont respectées. Cependant, suivre les contraintes peut parfois être difficile :

- La création de clés uniques demande une grande organisation et beaucoup de coordination pour mettre à jour une base de données (secrète de préférence) qui contient les clés déjà utilisées, et qui est accessible et commune aux personnes autorisées.
- Créer une clé parfaitement aléatoire est **difficile**, en effet nos ordinateurs ne font que simuler l'aléatoire grâce à des calculs mathématiques et génèrent donc des clés *pseudo-aléatoires*. Il est possible de savoir à l'avance la clé générée par l'ordinateur si l'on connait suffisamment d'informations dessus (algorithme utilisé, graine d'initialisation, etc.). Par exemple en C, la fonction `rand` utilise un [algorithme de génération de nombre pseudo-aléatoire](https://en.wikipedia.org/wiki/Linear_congruential_generator) basé sur des congruences et une fonction linéaire, et il est possible de deviner le résultat si l'on connait la graine initialisée avec `srand`. Une solution permettant de générer une clé totalement aléatoire serait d'utiliser des phénomènes physiques dont le résultat ne peut être déterminé à l'avance comme des [bruits thermiques](https://en.wikipedia.org/wiki/Thermal_fluctuations), des [bruits atmosphériques](https://en.wikipedia.org/wiki/Atmospheric_noise) ou encore une [réaction radioactive](https://en.wikipedia.org/wiki/Radioactive_decay).

## Conclusion

Le chiffre de Vernam est donc un algorithme de chiffrement symétrique offrant une sécurité optimale si les contraintes de cet algorithme sont respectées. Mais pour que son efficacité soit à son maximum, il faut disposer d'importantes ressources afin de créer un générateur totalement aléatoire, mais aussi un système assurant une utilisation unique des clés de chiffrement générées. Cependant, même avec un algorithme de chiffrement incassable, un problème persiste au niveau de l'échange de clé. En effet, tous les algorithmes de chiffrement symétriques nécessitent un échange de clé entre les deux personnes souhaitant communiquer afin de pouvoir chiffrer et déchiffrer les messages échangés. Mais c'est justement cet échange qui pose problème, car comment être sûr que personne d'autre ne connait la clé ? Comment la transmettre en toute sécurité ? L'intérêt d'un algorithme de chiffrement symétrique est donc limité, car si notre adversaire connait la clé de chiffrement, on aura beau mettre en place un algorithme de chiffrement incassable comme le chiffre de Vernam, il pourra sans aucunes difficultés comprendre les messages secrets. C'est pourquoi des mathématiciens ont travaillé sur de nouveaux algorithmes dit **asymétriques** (comme le [RSA](/algo/chiffrement/rsa.html)), ne nécessitant alors aucun échange de clé et rendant les communications secrètes bien plus sûres.
