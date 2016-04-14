Régression linéaire
===================
algo/ia/apprentissage_artificiel

Publié le : 14/04/2016  
*Modifié le : 14/04/2016*

## Introduction

On a vu dans l'[introduction à l'apprentissage artificiel](/algo/ia/apprentissage_artificiel/introduction.html), que récolter des données utiles est une étape importante dans un processus d'apprentissage. Imaginons maintenant qu'on veuille estimer le prix d'un ordinateur en fonction de sa puissance de calcul, et pour ce faire vous avez noté la puissance et le prix de différents ordinateurs dans un tableau :

*Les données sont totalement inventées et ne servent que d'exemple.*

| Puissance (nombre d'opérations/s) | Prix (€) |
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

On a une fonction linéaire basique, qu'on peut ensuite utiliser graphiquement pour trouver à partir de la puissance d'un ordinateur, une bonne estimation de son prix.

Cependant, comment faire comprendre à un ordinateur ce que signifie le terme généraliser ? Qu'est-ce qui fait qu'une fonction (linéaire, polynomiale, etc.) est une bonne généralisation de notre problème ?

Avant de se lancer dans la recherche d'un algorithme d'apprentissage artificiel, il faut définir ses caractéristiques. Dans notre problème, on a un ensemble de données sous la forme d'entrées et de sorties correspondantes, nous sommes donc dans un **apprentissage supervisé**. De plus, la sortie qu'on cherche est une valeur numérique, notre problème appartient alors au domaine de la **régression**. Une fois qu'on connaît ces deux informations essentielles, on peut décider de l'algorithme à utiliser en fonction de nos besoins et de nos ressources. Dans notre situation on souhaiterait faire une généralisation sous la forme d'une fonction linéaire, la méthode à employer est donc : la **régression linéaire**.

## Principe

La régression linéaire est un moyen de généraliser et de créer un modèle linéaire à partir d'exemples. Le modèle est une fonction linéaire, qu'on notera :

$h_{\theta}(x) = \theta_{0} + \theta_{1}x_1 + \theta_{2}x_2 + \ldots + \theta_{n}x_n$ avec $h(x) \simeq y$

$\theta$ correspond aux différents coefficients de notre fonction qui prend $n$ **attributs** (ou *feature* en anglais) qui sont tout simplement les paramètres de notre fonction (soit $x$). $y$ est la sortie qu'on a obtenue lors de la récolte de données, on veut donc une fonction $h_{\theta}$, aussi appelée **fonction d'hypothèse**, qui soit le plus proche possible de nos exemples afin de coller au mieux à la réalité. Le problème que cherche à résoudre la régression linéaire est donc de trouver les paramètres $\theta$ qui rendent notre modèle le plus efficace possible.

Dans notre cas, on a uniquement un attribut (la puissance de l'ordinateur), on cherche donc une fonction d'hypothèse qui retourne une estimation du prix de l'ordinateur de cette forme :

$h_{\theta}(x) = \theta_{0} + \theta_{1}x_1$

Mais pour comprendre comment trouver un bon modèle, il faut tout d'abord comprendre comment décrire l'efficacité d'un modèle quelconque, et surtout qu'est-ce qui rend un modèle meilleur qu'un autre ?

### Fonction d'erreur

Afin de différencier deux modèles en fonction de leurs efficacités, on va utiliser une **fonction d'erreur** qui mesure le taux d'erreur entre notre modèle et les données qu'on a récoltées.

Dans le cas d'une régression linéaire, une fonction d'erreur très commune est celle qui **minimise la somme des carrés des erreurs** :

$J(\theta) = \frac{1}{2m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

Avant d'expliquer ce que fait concrètement cette fonction, il faut détailler la notation. $J$ est notre fonction d'erreur, et elle prend $\theta$ comme paramètres. La fonction $h_{\theta}$ est notre modèle qui utilise donc les paramètres $\theta$ de la fonction d'erreur. La variable $m$ correspond au nombre d'exemples dans l'entrée, et $x_{i}$ ainsi que $y_{i}$ désignent le $i$ème exemple sous la forme d'un couple (entrée, sortie).

Décomposons maintenant cette fonction afin de comprendre ce qu'elle cherche à faire :

$(h_{\theta}(x_{i}) - y_{i})^2$

Ici on réalise la différence sur un exemple $i$ donné, entre le résultat de l'estimation de notre fonction d'hypothèse et le résultat de notre entrée sur ce même exemple. On cherche à voir si notre fonction est loin ou proche des données qu'on a récoltées (et donc de la réalité). Cette différence est montée au carré afin d'avoir un résultat positif dans un premier temps, mais aussi car la puissance permet d'amplifier le résultat (s'il y a une grosse différence, le carré produira un résultat très élevé et inversement), alors qu'avec une autre fonction comme la [valeur absolue](https://en.wikipedia.org/wiki/Absolute_value) on n'aurait pas cette deuxième propriété qui permet de mieux distinguer l'efficacité entre deux modèles.

Si on reprend notre estimation possible faite à la main, la différence que l'on calcule dans notre expression correspond aux parties vertes sur ce schéma :

![Exemple de calcul de différence entre estimation et réalité](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/exemple_calcul_erreur.png)

Notre fonction d'erreur va alors calculer la moyenne des différences sur nos $m$ exemples :

$\frac{1}{m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

Enfin, on divise le résultat par 2 à titre de conventions car cela simplifiera nos futurs calculs :

$\frac{1}{2m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

Cette fonction nous permet alors de comparer deux modèles en fonction des paramètres $\theta$ qu'ils utilisent.

Grâce à cela, on peut enfin définir concrètement ce que signifie "trouver le meilleur modèle". Cela revient à trouver des paramètres $\theta$ qui **minimisent** la fonction d'erreur utilisée.

Si l'on affiche graphiquement la fonction d'erreur pour notre problème, on obtient ceci :

![Exemple de représentation graphique de la fonction d'erreur](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/exemple_fonction_erreur.png)

Sur ce graphique représentant $J$ en fonction de $\theta_{0}$ et $\theta_{1}$, on remarque clairement les valeurs de $\theta$ pour lesquelles la fonction d'erreur est minimisée. Cependant, il va falloir trouver un algorithme qui calcule ces valeurs automatiquement, car on ne pourra pas toujours faire de représentation graphique (lorsqu'on a beaucoup d'attributs en entrée par exemple).

## Algorithmes

On a réussi à définir mathématiquement l'objectif de la régression linéaire, grâce à notre fonction d'erreur. Désormais il faut donc minimiser cette fonction avec les paramètres $\theta$.

Deux méthodes répandues s'offrent à nous :

- [**L'algorithme du gradient**](/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient.html) (*gradient descent* en anglais) : un algorithme itératif (pouvant cependant être amélioré avec l'utilisation de [matrices](https://en.wikipedia.org/wiki/Matrix_%28mathematics%29)) utile quand $n$ est très large, et personnalisable grâce à un coefficient d'apprentissage (ce dernier peut aussi être un désavantage car dans certains cas il est difficile de le choisir efficacement).
- [**L'équation normale**](/algo/ia/apprentissage_artificiel/regression_lineaire/equation_normale.html) : une équation donnant le résultat directement sans itérations, cependant cette dernière est très lourde en opérations et a une complexité en temps de $O(n^3)$ à cause du [produit matriciel](https://en.wikipedia.org/wiki/Matrix_multiplication). On l'utilisera plutôt quand $n$ est suffisamment petit (au-dessus de 10000 environ on évite d'utiliser cette méthode).

## Problèmes

- overfitting
- underfitting

## Conclusion

- évoquer la régression polynomiale
