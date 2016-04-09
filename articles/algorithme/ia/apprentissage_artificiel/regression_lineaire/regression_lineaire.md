Régression linéaire
===================
algo/ia/apprentissage_artificiel

Publié le : 09/04/2016  
*Modifié le : 09/04/2016*

## Introduction

On a vu dans l'[introduction à l'apprentissage artificiel](/algo/ia/apprentissage_artificiel/introduction.html), que récolter des données utiles est une étape importante dans un processus d'apprentissage. Imaginons maintenant qu'on veuille estimer le prix d'un ordinateur en fonction de sa puissance de calcul, et pour ce faire vous avez noté la puissance et le prix de différents ordinateurs dans un tableau :

*Les données sont totalement inventées et ne servent que d'exemple.*

| Puissance (nombre d'opération/s) | Prix (€) |
| :------------------------------: | :------: |
| 173                              | 194      |
| 407                              | 287      |
| 534                              | 501      |
| 714                              | 674      |
| 956                              | 771      |
| 1226                             | 860      |

On peut représenter ce tableau grâce à un graphique en deux dimensions très simple :

![Exemple de données récoltées](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/exemple_donnees.png)

Ce qu'on cherche à faire dans notre problème c'est de **généraliser** grâce aux données obtenues. En tant qu'humain, on pourrait facilement faire une bonne généralisation comme ceci :

![Exemple de généralisation](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/exemple_generalisation.png)

On a une fonction linéaire, qu'on peut ensuite utiliser graphiquement pour trouver à partir de la puissance d'un ordinateur, une bonne estimation de son prix.

Cependant, comment faire comprendre à un ordinateur ce que signifie le terme généraliser ? Qu'est-ce qui fait qu'une fonction (linéaire, polynomiale, etc.) est une bonne généralisation de notre problème ?

## Principe

La **régression linéaire** est un moyen de généraliser et de créer un modèle linéaire (dans notre cas une fonction) à partir d'exemples. Ce type d'apprentissage s'inscrit dans le cadre d'une méthode d'**apprentissage supervisé** puisqu'on doit fournir à l'algorithme des exemples d'entrées composés de réponses. Aussi, c'est un problème de **régression** car cherche à obtenir des valeurs numériques grâce à notre fonction de généralisation.

Un modèle va donc être une fonction linéaire ($y = ax + b$) qu'on notera :

$h_{\theta}(x) = \theta_{0} + \theta_{1}x$

\theta correspond aux paramètres de notre fonction, avec $\theta_{0} = b$, et $\theta_{1} = a$. Cette fonction est aussi appelée **fonction d'hypothèse**, car on veut trouver une fonction $h$ qui se rapproche le plus possible de nos exemples afin de coller au mieux à la réalité et à une possible généralisation. Le problème que cherche à résoudre la régression linéaire est donc de trouver les paramètres \theta qui rendent notre modèle le plus efficace possible.

Pour comprendre comment trouver un bon modèle, il faut tout d'abord comprendre comment décrire l'efficacité d'un modèle quelconque, et surtout qu'est-ce qui rend un modèle meilleur qu'un autre ?

### Fonction d'erreur

Afin de différencier deux modèles en fonction de leurs efficacités, on va utiliser une **fonction d'erreur** qui mesure le taux d'erreur entre notre modèle et les données qu'on a récoltées.

Dans le cas d'une régression linéaire, une fonction d'erreur très commune est celle qui **minimise la somme des carrés des erreurs** :

$J(\theta) = \frac{1}{2m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

Avant d'expliquer ce que fait concrètement cette fonction, il faut détailler la notation. $J$ est notre fonction d'erreur, et elle prend $\theta$ comme paramètres. La fonction $h$ est notre modèle qui utilise donc les paramètres \theta de la fonction d'erreur. La variable $m$ correspond au nombre d'exemples dans l'entrée, et $x_{i}$ ainsi que $y_{i}$ désignent respectivement les éléments $i$ de l'axe x et de l'axe y.

Décomposons maintenant cette fonction afin de comprendre ce qu'elle cherche à faire :

$(h_{\theta}(x_{i}) - y_{i})^2$

Ici on réalise la différence sur un exemple $i$ donné, entre le résultat de l'estimation de notre fonction d'hypothèse et du résultat de notre entrée sur ce même exemple. On cherche à voir si notre fonction est loin ou proche des données qu'on a récoltées (et donc de la réalité). Cette différence est montée à la puissance 2 afin d'avoir un résultat positif dans un premier temps, mais aussi car la puissance permet d'amplifier le résultat (s'il y a une grosse différence, le carré produira un résultat très élevé et inversement), alors qu'avec une autre fonction comme la [valeur absolue](https://en.wikipedia.org/wiki/Absolute_value) on n'aurait pas cette deuxième propriété qui permet de mieux distinguer l'efficacité entre deux modèles.

Si on reprend notre estimation faite à la main du début, la différence que l'on calcule dans notre expression correspond aux parties vertes sur ce schéma :

![Exemple de calcul de différence entre estimation et réalité](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/exemple_calcul_erreur.png)

Notre fonction d'erreur fait ensuite la moyenne de ces différences, en calculant ces dernières sur tous nos $m$ exemples en entrée :

$\frac{1}{m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

Enfin, on divise les résultats par 2 afin de simplifier la sortie obtenue :

$\frac{1}{2m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$  
$J(\theta) = \frac{1}{2m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

Cette fonction nous permet alors de comparer deux modèles en fonction des paramètres \theta qu'ils utilisent. Le but de la régression linéaire est donc de **minimiser** la fonction d'erreur utilisée en fonction des paramètres \theta, afin d'avoir le meilleur modèle possible.

TODO : autre fonction d'erreur intéressante ?
TODO : graphique de la fonction d'erreur

## Algorithmes

### Algorithme du gradient

- vectorization
- feature scaling
- mean normalization

### Normal equation

## Implémentation

## Régression polynomiale

## Conclusion
