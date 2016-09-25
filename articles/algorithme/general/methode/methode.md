Méthode de résolution
=====================
algo/general

Publié le : 25/09/2016  
*Modifié le : 25/09/2016*

## Introduction

TODO : conseils persos

Je ne le répèterai jamais assez, mais [France-IOI](http://www.france-ioi.org/) est **la référence francophone en algorithmique**, et une des choses qui distingue fortement cette plateforme est la méthode de résolution qu'elle cherche à transmettre au travers de ses exercices. Cet article a pour but de présenter cette méthode qui peut être terriblement efficace si correctement maitrisée. De plus, elle ne s'applique pas uniquement pour des concours ou des exercices, mais de manière générale lorsqu'on cherche un algorithme pour résoudre un problème donné.

Cependant, cette méthode peut paraître longue et fastidieuse au début, et nécessite de l'[entraînement](/algo/general/entrainement.html) ainsi que de la rigueur pour être utilisée efficacement. La vitesse viendra avec la pratique et non en bâclant les étapes de cette méthode. Il peut être frustrant au début de résoudre lentement un problème, mais cela vous sera très utile dans le futur et vous serez capable de réaliser les différentes étapes de cette méthode bien plus rapidement grâce à votre expérience.

Pour commencer, il vous faut uniquement une feuille et un crayon.

## Enoncé

### Lecture

Que ce soit un concours de programmation ou un problème que vous cherchez à résoudre, la première étape est de **lire attentivement l'énoncé**, et de ne surtout pas se précipiter. Cela peut paraitre évidant, mais c'est une erreur commune de se tromper dans la lecture du sujet, alors qu'il est facile d'éviter ceci. Relisez plusieurs fois ce dernier jusqu'à l'avoir en tête, et essayer de vous concentrer sur le sujet et non sur l'algorithme pour l'instant. Il est fréquent de commencer à lire le sujet et d'avoir une idée d'algorithme en tête qu'on cherche à développer, mais cette dernière n'est quasiment jamais la bonne car on n'a pas toutes les informations à propos de l'énoncé. **Ne cherchez pas de solutions au problème pour l'instant**, votre premier objectif est de comprendre parfaitement le sujet et de n'avoir aucuns doutes dessus. Commencer à chercher aussi tôt ne ferra que vous perturber, vous emmêler ou encore pire, vous induire en erreur.

### Reformulation

Une fois le sujet correctement lu et appréhendé, il est crucial de le **reformuler en quelques phrases** (deux ou trois en général suffisent, il ne s'agit pas ici de réécrire le problème). Ceci vous permet dans un premier temps de vérifier votre compréhension vis-à-vis de l'énoncé, mais aussi de le décrire efficacement et de manière concise. Supprimez tous les détails inutiles, et concentrez-vous sur ce qu'on vous demande concrètement de faire. Vous pouvez vous aider en écrivant deux phrases types, "On nous donne..." et "On nous demande...", puis si nécessaire notez les points importants à ne pas oublier ou spécifiques au sujet. Attention cependant, car **l'étape de reformulation ne doit pas dériver du sujet** (en le simplifiant ou en le généralisant par exemple), elle doit le décrire parfaitement comme si vous expliquiez l'énoncé à une personne.

Il est très courant dans un concours de programmation d'avoir une histoire qui accompagne le sujet, et l'étape de reformulation permet d'écarter cette dernière en explicitant le problème de manière crue et non imagée. Il faut arriver à se **détacher le plus possible de l'histoire** et de décrire le problème d'un point de vue purement algorithmique.

Voici un exemple de sujet très simple, ainsi qu'une reformulation de ce dernier :

> Alice et Bob sont de très bons amis, cependant les deux voyagent beaucoup et ils aimeraient se rencontrer afin de discuter de leurs dernières aventures. A force de voyager, Alice et Bob n'ont plus énormément d'argent, et Alice n'a pas de quoi payer pour rencontrer Bob. Ce dernier décide donc de la rejoindre, et se renseigne sur les différents moyens de transports ainsi que leurs coûts. Son but est de voyager à prix minime, pour économiser dans de futurs voyages. Après une recherche sur son navigateur favori, Bob se retrouve avec les informations suivantes :  
> 
> | Départ   | Arrivée  | Coût | Transport |
> | ------   | -------  | ---- | --------- |
> | Shanghai | Pékin    | 100€ | train     |
> | New-York | Londres  | 700€ | avion     |
> | Paris    | Shanghai | 700€ | avion     |
> | New-York | Pékin    | 800€ | avion     |
> | Moscou   | Shanghai | 450€ | avion     |
> | Pékin    | Moscou   | 300€ | train     |
> | Le Caire | Paris    | 500€ | avion     |
> | Moscou   | New-York | 700€ | avion     |
> | Paris    | Londres  | 200€ | train     |
> | Moscou   | Paris    | 300€ | train     |
> 
> Sachant que Bob est actuellement à Pékin et qu'Alice se trouve à Londres, combien Bob devra-t-il dépenser au minimum afin de rencontrer Alice ?

Un exemple de reformulation utile de ce sujet :

> On nous un graphe orienté pondéré positivement.  
> On nous demande le plus court chemin entre deux nœuds de ce graphe.

Plus d'histoire, plus d'Alice et Bob, on garde uniquement le strict minimum, sans pour autant perdre des informations. Ici, l'entrée donnée par le sujet est un graphe implicite où chaque ville est un nœud et chaque trajet un arc. Le graphe est orienté car on a une case "Départ" et "Arrivée" ce qui semble indiquer une direction à suivre. L'information du transport (avion ou train) est en réalité inutile à notre problème puisqu'on ne cherche qu'à minimiser le coût, on l'omet donc de notre description. La pondération du graphe simule le coût du trajet, or ce coût est toujours positif donc on le précise. Pour ce qui est de la sortie, on nous demande effectivement un plus court chemin reliant le nœud de départ (où se trouve Bob sur le graphe) et un nœud d'arrivée (où se trouve Alice).

Une fois le sujet reformulé, il peut être intéressant de **relire une dernière fois l'énoncé** pour s'assurer de la véracité de la reformulation. En effet, cette dernière sera l'élément central de notre réflexion, donc il faut être certain qu'elle est correcte car on basera toute notre méthode de recherche de l'algorithme dessus.

Encore une fois, on est actuellement dans la compréhension du sujet et non dans la résolution. Ne vous lancez pas à tête baissée dans une idée d'algorithme tout de suite, attendez pour vérifier votre réflexion.

### Dimensions et contraintes

Enfin, dernière sous étape qui concerne l'énoncé, il faut noter sur votre feuille les **dimensions** et les **contraintes** du sujet.

Une **dimension** est une donnée qu'on fournit dans l'énoncé du problème. Par exemple dans le cas du problème d'Alice et Bob, on pourra avoir une liste de dimensions comme :

> Soit $N$ le nombre de villes où peuvent voyager Alice et Bob, $1 <= N <= 200$  
> Soit $M$ le prix d'un trajet, $1 <= M <= 3000$€  
> Soit $K$ le coût total du trajet de Bob pour rejoindre Alice, $1 <= K <= 100000$€

On distingue plusieurs types de dimensions :

- **dimension d'entrée** : une valeur qui va concerner directement l'entrée de votre programme (ex: $N$ ou $M$)
- **dimension de sortie** : une valeur qui va concerner directement la sortie de votre programme (ex: $K$)
- **dimension implicite** : une valeur implicite de l'énoncé qui peut être intéressante de noter (ex: si on fournit en entrée des coordonnées de points dans l'espace, une dimension implicite pourrait être la distance entre deux points)

Pour chaque dimension il est utile de mettre la borne minimale et maximale, qui sont la plupart du temps données par le sujet ou qu'on peut simplement trouver avec quelques calculs.

Une **contrainte** est une limite imposée par l'énoncé, concernant généralement le temps ou la mémoire qu'on accorde à votre programme. Ces dernières sont explicites, par exemple :

> Temps : 1s sur une machine à 1Ghz  
> Mémoire : 32000 Ko

Lister les dimensions et les contraintes vous permet de vérifier rapidement si votre algorithme est assez efficace. En effet, avec ces informations il suffit de calculer la complexité d'un algorithme pour se rendre compte instantanément s'il respecte ou non le sujet.

*Attention à ne pas mettre les dimensions ou les contraintes dans la reformulation, ce sont deux sous-étapes bien distinctes.*

## Exemple

Deuxième étape de la méthode de résolution : **résoudre des exemples à la main**. Désormais, on va se concentrer sur la partie résolution du problème et non plus dans la compréhension du sujet, vous devriez maintenant avoir ce dernier bien en tête et correctement reformulé en quelques phrases relativement courtes.

### Représentation graphique du problème

Avant de se lancer dans la résolution d'exemples, on peut commencer par chercher une bonne représentation de notre problème. Visualiser ce dernier nous permettra de trouver une solution bien plus facilement, mais encore une fois, il y a de nombreuses façons de représenter une même chose mais peu sont réellement efficaces et utiles.

Une bonne visualisation indique des informations indispensables, il ne faut surtout pas surcharger la figure car elle doit rester claire et précise. Cette représentation peut prendre différentes formes selon le sujet et le contexte : graphe, arbre, tableau, graphique 2D, etc.

### Résoudre des exemples à la main

Trouver une solution est bien plus simple lorsqu'on essaie nous même de résoudre le problème plutôt que d'y réfléchir dans sa tête. En effet, notre cerveau est un outil très efficace pour ce genre de tâche, et se demander comment on ferrait personnellement pour résoudre le problème peut être un bon départ de réflexion. De plus, votre cerveau peut trouver rapidement des raccourcis pour éviter de répéter des mêmes opérations fastidieuses, et ceci nous aidera grandement pour trouver un algorithme efficace.

Il est courant d'avoir des exemples dans l'énoncé du problème, mais il en faudra plus pour trouver l'algorithme. Cependant, générer plusieurs **bons exemples** est loin d'être facile. Les exemples doivent être tous assez différents les uns des autres pour généraliser l'algorithme et faire ressortir dès idées, pas trop longs pour ne pas perdre trop de temps (surtout pendant un concours de programmation), mais ni trop courts pour ne pas être inutiles.

En plus d'aider à résoudre le problème et à trouver un algorithme, cette étape importante permet aussi de fournir des tests pour notre futur code (si les exemples à la main sont résolus correctement). On peut trouver des **cas spéciaux** ou des **cas limites** (en fonction des contraintes et des dimensions du problème) qui peuvent nous permettre de tester l'efficacité de l'algorithme. Un exemple de cas limite pour le problème d'Alice et Bob serait une entrée avec des millions (voire des milliards) d'itinéraires possibles. L'idée est de tester si notre algorithme respecte ou non les contraintes du sujet.

## Algorithme

Si à partir des exemples, vous n'avez encore aucunes réelles idées de l'algorithme à employer, il est possible d'utiliser différentes stratégies afin de changer d'approche.

### Algorithme naïf

Un algorithme dit **naïf** est la première méthode bourrin qui vous vient à l'esprit quand on vous pose un problème, ce dernier ne se soucie pas des contraintes, des dimensions, ou autre, et cherche uniquement à résoudre l'énoncé. Par exemple, si l'on reprend notre reformulation du sujet :

> On nous un graphe orienté pondéré positivement.  
> On nous demande le plus court chemin entre deux nœuds de ce graphe.

Imaginons qu'on ne connaisse aucun algorithme de plus court chemin sur un graphe, il faut donc qu'on arrive à en créer un nous même. L'algorithme naïf serait alors de tester bêtement tous les chemins et de sélectionner le plus court. Rien de plus simple, et même si cet algorithme est terriblement peu efficace, il est souvent très intéressant de partir de cela pour ensuite l'améliorer et découvrir un algorithme qui respecte les contraintes et les dimensions (c'est d'ailleurs la stratégie que j'adopte dans mon article sur l'algorithme de plus court chemin [Bellman-Ford](/algo/structure/graphe/plus_court_chemin/bellman_ford.html)).

L'avantage de cette méthode est qu'il est évident de trouver l'algorithme naïf pour résoudre un problème, et que ses points faibles sont très rapidement soulignés lorsqu'on cherche à réaliser un exemple à la main avec ce dernier. En effet, on va vite remarquer ce que notre algorithme répète inutilement, et il suffit d'optimiser ces points en trouvant une méthode plus réfléchie et moins naïve.

*Un ou deux exemples devraient suffir, pas besoin de recommencer entièrement l'étape précédente. En revanche, choisissez des exemples un minimum long pour avoir le temps de trouver les points faibles.*

N'oubliez pas de calculer la complexité en temps et en mémoire de votre algorithme bourrin pour deux raisons principalement :

- Il arrive que l'algorithme naïf soit une solution suffisante dans des cas simplistes. En concours, il est alors inutile de chercher à améliorer l'algorithme s'il respecte déjà les contraintes, d'autant plus que l'algorithme bourrin est souvent rapide et simple à programmer.
- Connaître la complexité en temps et en mémoire permet de se rendre compte des améliorations nécessaires pour que le nouvel algorithme soit efficace.

### Simplifier le problème

Si vous bloquez sur le sujet, essayez de le simplifier car cela permettra de faire ressortir plus d'idées qui sont souvent très utiles pour le problème original. Pour cela, on réalise un tableau des dimensions fondamentales du sujet, et on essaie d'appliquer différentes opérations sur chaque dimensions :

- **Supprimer** : l'auteur d'un problème peut rajouter des dimensions afin de rendre un sujet plus complexe, il peut donc être judicieux de supprimer entièrement une dimension pour rendre le processus de réflexion plus simple et plus efficace. Prenons un exemple où l'on vous fournit des intervalles de temps, on pourrait supprimer une dimension en faisant en sorte d'utiliser des points fixes dans le temps au lieu d'intervalle.
- **Fixer** : pour mieux généraliser le problème, on peut fixer une ou plusieurs dimensions à des valeurs bien précises. Par exemple, si le sujet implique des rectangles à dimensions variables, que se passe-t-il si tous les rectangles ont la même largeur et la même hauteur ? Ou encore, si tous les rectangles deviennent des carrés ?
- **Réduire** : si on n'arrive pas à trouver un algorithme assez efficace, il faut commencer avec un algorithme plus simple mais moins intelligent (attention ici on ne veut pas retomber sur l'algorithme naïf). Réduire des dimensions par 2, 10, etc. peut aider à trouver un début d'algorithme, qu'on pourra ensuite améliorer.

### Changer de point de vue

Enfin, si vous n'avez vraiment aucunes idées correctes, c'est que votre point de vue n'est pas bon. Tentez de résoudre le problème avec des algorithmes *classiques*, car souvent deux sujets peuvent sembler totalement différent mais en réalité il est possible de les représenter grâce à une seule même structure et ainsi de les résoudre pratiquement de la même façon. Les sujets impliquant des graphes dit *implicites* en sont l'exemple parfait. Imaginez qu'on vous donne un nombre $N$ et un nombre $M$, ainsi que différentes opérations mathématiques (comme ajouter $A$, soustraire $B$, ou encore multiplier $C$), et vous devez déterminer s'il est possible d'utiliser les opérations données pour passer du nombre $N$ au nombre $M$. Présenté comme ceci, on ne se doute pas qu'il s'agit en réalité d'un problème de graphe, mais lorsqu'on adopte ce nouveau point de vue, on se rend compte qu'on peut représenter ce problème sous la forme d'un graphe où chaque nœud correspond à un résultat, et chaque arc est une opération. Le but apparaît alors comme trivial, on veut se rendre d'un nœud de départ $N$ au nœud d'arrivée $M$, on applique donc un simple [algorithme de parcours de graphe](/algo/structure/graphe/parcours.html).

Le fait d'avoir changé totalement de point de vue nous a fait découvrir une nouvelle façon de représenter le problème, et il est tout à fait possible de faire la même chose pour d'autre algorithme classique (comme la [programmation dynamique](/algo/general/approche/dynamique.html), l'approche du [diviser pour régner](https://en.wikipedia.org/wiki/Divide_and_conquer_algorithms), etc.).

## Pseudo-code

Vous avez enfin trouvé dans votre tête l'algorithme recherché, cependant lorsqu'on cherche à résoudre un problème un minimum conséquent, **on ne code jamais directement** mais on passe par une étape intermédiaire : le pseudo-code. Avant d'expliquer concrètement ce qu'est le pseudo-code, j'aimerais vraiment m'attarder sur l'importance de ce dernier qui est souvent trop négligé (surtout pendant des concours).

Imaginons que vous venez de trouver l'algorithme. Vous avez votre idée en tête et vous décidez tout de suite de passer à l'étape de programmation car vous pensez que la partie pseudo-code est inutile et que vous avez toutes les informations nécessaires pour résoudre correctement le sujet. Comme vous n'avez aucune réelle structure, vous programmez ce qui vous viens en premier en tête quand vous pensez à votre algorithme, cependant au fur et à mesure que vous codez vous vous rendez compte qu'il faudra ajouter/supprimer/changer telle ou telle partie du programme à cause de détails auxquels vous n'avez pas pensé avant. Vous allez donc passer beaucoup de temps à réécrire ou à bidouiller votre programme afin de prendre en compte ces changements, et ceci va résulter en un code souvent sale et mal structuré (voire carrément faux). Or l'étape de débugage est fondamentale et débuguer ce genre de code est un cauchemar qui ne fini en général pas très bien. Après avoir perdu **énormément** de temps à corriger vos erreurs (si vous arrivez au bout de cette étape), vous vous rendez compte en testant votre algorithme qu'il n'est tout simplement pas assez efficace et que sa complexité en temps ne satisfait pas les contraintes de l'énoncé.

Cet exemple peut paraître exagéré mais il est en réalité très fréquent en concours (bien plus qu'on ne le croit). Maintenant, regardons de plus près l'utilité du pseudo-code.

Le pseudo-code est une manière d'établir un algorithme sur le papier, sans se soucier des détails d'implémentation ou du quelconque langage utilisé ensuite. Cette étape est **extrêmement importante** car elle permet de se concentrer uniquement sur l'algorithme et non sur la manière dont vous allez le programmer. De plus, ceci vous permet de structurer correctement votre idée, ce qui ensuite permettra de coder le programme en quelques minutes seulement.

Il n'y a pas de règles de syntaxe pour le pseudo-code, et c'est ce qui le rend très personnel. Chacun a sa manière d'écrire du pseudo-code. Cependant, cette étape qui peut paraître pénible voire inutile, est **essentielle**, et pratiquer l'écriture du pseudo-code est une bonne habitude, surtout lorsqu'on débute. Forcez vous si nécessaire à en écrire au début, même si ça peut paraître trivial sur des problèmes simples, vous verrez qu'ensuite cela sera indispensable. En effet, le pseudo-code permet de décrire un algorithme rapidement, et donc de tester sa validité efficacement.

Au travers de mes articles, j'utiliserai toujours des pseudo-codes avant l'implémentation pour plusieurs raisons :

- Un pseudo-code est écrit en français, et il permet d'appréhender l'algorithme abordé facilement.
- Il ne dépend d'aucun langage de programmation (que ça soit au niveau de la syntaxe, ou encore des détails), donc que vous programmiez en C, en Python, en Ocaml, ou autre, vous pouvez très bien le lire, le comprendre et l'implémenter de votre côté.
- Le pseudo-code apporte une réelle structure ce qui est extrêmement pratique quand on veut implémenter un algorithme.
- S'il y a des améliorations ou des modifications à apporter à l'algorithme, le pseudo-code est très utile car on peut le modifier simplement pour mettre en place ces dernières.

Même si le pseudo-code suit une syntaxe personnelle, il y a quelques règles qui sont intéressantes d'appliquer pour écrire un pseudo-code réellement utile :

- Un pseudo-code se doit d'être concis, il ne s'agit pas ici de réécrire en français tout un programme informatique. On ne mettra que ce qui nous intéresse réellement, et uniquement ce qui concerne l'algorithme en lui même. Vu qu'il y a différentes façons de l'implémenter, on ne se souciera pas de tous ces détails et on laissera cela à réaliser pendant l'étape où l'on code.
- Il est tout à fait inutile de décrire les entrées ou les sorties du programme, par exemple on écrira `Lire graphe` sans détailler plus la manière dont on lit ce dernier. De même, on écrira plutôt `Afficher tableau` au lieu d'écrire une boucle.
- Notre pseudo-code doit faire ressortir les boucles, les fonctions et les éléments principaux de notre algorithme. C'est pourquoi on n'utilisera ces derniers outils uniquement quand ils concernent directement l'algorithme et non pas pour un détail d'implémentation encore une fois.
- Tout comme il est normal d'[indenter](https://en.wikipedia.org/wiki/Indent_style) son code, il est essentiel d'indenter son pseudo-code pour faciliter la lecture. N'hésitez pas à laisser de la place sur votre feuille si vous devez ensuite rajouter des précisions.
- Les variables sont des détails d'implémentation, il est donc inutile de les déclarer, en revanche préciser le type et la valeur d'initialisation peut être intéressant dans certains cas.
- Le pseudo-code ne doit pas contenir de commentaire car ce dernier doit être assez clair et écrit en français.
- Il faut absolument éviter d'oublier des parties de l'algorithme en pensant que ce sont des détails d'implémentation. Si une partie du pseudo-code est floue ou peu détaillée, et qu'elle concerne directement l'algorithme, il faut la travailler davantage avant de coder.

TODO : vérifier étape complète + transition/fin partie + mixer étape "vérifier le pseudo-code" ?

## Vérifier le pseudo-code

Une fois le pseudo-code correctement établit, il faut une dernière étape de vérification (assez rapide) pour s'assurer au maximum d'avoir une solution valide avant de se lancer dans le code :

- **Relire le sujet** afin d'être certain de bien répondre à ce dernier et de ne pas avoir inconsciemment dévié du problème initial lors de la recherche d'une solution.
- **Vérifier avec des exemples** que le pseudo-code retourne bien la sortie attendue (réutilisez ceux de l'énoncé ou vos propres exemples que vous avez générés auparavant).
- **Calculer la complexité en temps et en mémoire** à nouveau pour être convaincu de l'efficacité de l'algorithme.

TODO : autres étapes ?

## Coder l'algorithme

A partir de ce moment, vous devez être sûr de votre algorithme car coder, tester et débuguer un programme est un processus qui peut être très long et c'est pour cela qu'il y a autant d'étapes avant de se mettre à coder. Normalement, vous avez votre algorithme en tête, un pseudo-code clair et précis, ainsi que plusieurs exemples (en plus de ceux du sujet) pour tester le programme. Tout est réuni pour coder efficacement, et si possible avec le moins de bug possible. Il y a tout de même quelques méthodes à respecter pour éviter au mieux les bugs potentiels (ces conseils s'appliquent surtout lors de concours où le temps est limité) :

- Ne cherchez surtout pas à optimiser votre programme lorsque vous êtes en train de l'écrire ! Comme le dit si bien [Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth) : *"We should forget about small efficiencies, say about 97% of the time: premature optimization is the root of all evil."*. Inutile de chercher à optimiser des petites parties de votre code, car l'impact sera sans doute minime et vous risquez d'introduire plus de bugs.
- Ne vous compliquez pas la tâche quand il y a une alternative plus simple. Par exemple, en concours il est rarement utile de faire une allocation dynamique qui prend parfois du temps et risque d'être mal effectuée, en revanche il est commun et bien plus pratique de déclarer les variables majeures du programme en tant que variable globale pour rendre bien plus simple le programme et éviter des bugs inutiles liés à l'allocation et à la libération de la mémoire.
- Utilisez de *bons* noms de variables et de fonctions pour ne pas se retrouver avec des noms de variables à une lettre partout dans votre code au risque de confondre. C'est plus une habitude à prendre, mais nommer correctement une variable peut se révéler plus dure qu'on ne le crois. Un nom correct doit être précis, clair et relativement concis.
- N'hésitez pas à re-déclarer des variables au lieu de réutiliser d'anciennes qui non plus forcément de rapport (notamment dans les boucles, car il serait dommage de réutiliser une variable qui contient des restes indésirables et qui pourrait introduire un bug difficile à détecter).
- TODO : plus de conseils (spécifique concours ?)

## Tester le code

Créer un fichier pour chaque exemple que vous avez, et exécutez votre programme avec ces derniers pour s'assurer de la sortie. Il est souvent indispensable d'avoir un fichier contenant un exemple de cas limite (vous pouvez le générer automatiquement avec un petit programme pour ne pas perdre du temps à le remplir à la main).

Si vous faites une variante d'un ou plusieurs fichiers tests, n'oubliez surtout pas de le conserver dans un différent fichier car cela vous fait un test de plus pour vérifier votre programme.

Enfin, la sortie des exemples est parfois une bonne manière de tester notre code, mais on peut aussi afficher le contenu des variables/structures de données principales pour confirmer que tout fonctionne parfaitement comme prévu.

## Débuguer le programme

Malheureusement, il est rare de coder un code parfait directement, et cette chance diminue d'autant plus que la complexité du problème augmente. Savoir débuguer un programme rapidement et efficacement est donc un atout énorme (surtout dans les concours de programmation).

TODO: dichotomie pour "isoler" le problème + gdb ?

## Conclusion

TODO: liens fiches méthodes france-ioi
