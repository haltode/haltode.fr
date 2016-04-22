Régression linéaire/polynomiale
===============================
algo/ia/apprentissage_artificiel

Publié le : 22/04/2016  
*Modifié le : 22/04/2016*

## Introduction

Vous souhaitez utiliser un algorithme d'apprentissage artificiel afin d'estimer le prix d'un ordinateur en fonction de sa puissance de calcul. Dans l'[introduction à la matière](/algo/ia/apprentissage_artificiel/introduction.html), on a vu que récolter des données utiles est une étape importante dans un processus d'apprentissage, et vous avez alors noté la puissance et le prix de différents ordinateurs dans un tableau :

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

![Exemple de données récoltées](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lin_poly/exemple_donnees.png)

Ce qu'on cherche à faire dans notre problème c'est de **généraliser** grâce aux données obtenues. En tant qu'humain, on pourrait facilement faire une bonne généralisation comme ceci :

![Exemple de généralisation](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lin_poly/exemple_generalisation.png)

On a une fonction linéaire basique, qu'on peut ensuite utiliser graphiquement pour trouver à partir de la puissance d'un ordinateur, une bonne estimation de son prix.

Cependant, du point de vue d'une personne, il est facile de trouver un lien entre les données dans le but de généraliser, mais comment un algorithme peut-il reproduire ce comportement ? Qu'est-ce qui fait qu'une fonction (linéaire, polynomiale, etc.) est une bonne généralisation de notre problème ?

Avant de se lancer dans la recherche d'un algorithme d'apprentissage artificiel, il faut définir ses caractéristiques. Dans notre problème, on a un ensemble de données sous la forme d'entrées et de sorties correspondantes, nous sommes donc dans un **apprentissage supervisé**. De plus, la sortie qu'on cherche est une valeur numérique, notre problème appartient alors au domaine de la **régression**. Une fois qu'on connaît ces deux informations essentielles, on peut décider de l'algorithme à utiliser en fonction de nos besoins et de nos ressources. Dans notre situation on souhaiterait faire une généralisation sous la forme d'une fonction linéaire, la méthode à employer est donc : la **régression linéaire**.

*La régression linéaire n'est qu'un cas particulier de la régression polynomiale, mais il est plus simple de commencer à une simple fonction linéaire pour ensuite aborder des fonctions plus complexes (même si le principe reste exactement le même).*

## Principe

La régression linéaire est un moyen de généraliser et de créer un modèle linéaire à partir d'exemples. Lesdits exemples sont représentés à l'aide de [matrices](https://en.wikipedia.org/wiki/Matrix_%28mathematics%29) où $x$ est l'entrée, et $y$ est la sortie correspondante. Prenons le cas où on essaie de généraliser le prix d'un appartement en fonction de sa taille et de son nombre de pièces (encore une fois les données sont fictives):

| Taille (m²) | Nombre de pièces | Prix (millier €) |
| :---------: | :--------------: | :--------------: |
| 112         | 4                | 253              |
| 203         | 6                | 760              |
| 158         | 5                | 558              |
| 98          | 3                | 243              |
| 143         | 4                | 302              |

Nos matrices ressembleront à ceci :

$x = \begin{bmatrix} 112 & 4 \\ 203 & 6 \\ 158 & 5 \\ 98 & 3 \\ 143 & 4 \end{bmatrix}$ $y = \begin{bmatrix} 253 \\ 760 \\ 558 \\ 243 \\ 302 \end{bmatrix}$

Le **modèle** qu'on cherche à construire est une fonction linéaire, qu'on notera :

$h_{\theta}(x) = \theta_{0} + \theta_{1}x_1 + \theta_{2}x_2 + \ldots + \theta_{n}x_n$

$\theta$ correspond aux coefficients de notre fonction qui prend $n$ **attributs** (ou *feature* en anglais). Les attributs sont les différentes colonnes de $x$ (la puissance d'un ordinateur, la taille d'un appartement, le nombre de pièces, etc.) et c'est sur quoi se base l'algorithme pour généraliser le problème qu'on lui donne. Il est très important de bien choisir les attributs, et de renseigner uniquement ceux qui ont une réelle influence sur le résultat, mais sans pour autant en donner trop peu à l'algorithme.

On souhaite donc trouver une fonction $h_{\theta}$, aussi appelée **fonction d'hypothèse**, tel que $h(x) \simeq y$. Le problème que cherche à résoudre la régression linéaire est de trouver les paramètres $\theta$ qui rendent notre modèle proche de la réalité (représentée par $y$) afin qu'il soit efficace.

Si l'on reprend notre énoncé de départ sur le prix d'un ordinateur, on a uniquement un attribut (sa puissance), et on cherche une estimation du prix à l'aide d'une fonction d'hypothèse de la forme :

$h_{\theta}(x) = \theta_{0} + \theta_{1}x_1$

Mais pour comprendre comment trouver un bon modèle, il faut tout d'abord comprendre comment décrire l'efficacité d'un modèle quelconque, et surtout qu'est-ce qui rend un modèle meilleur qu'un autre ?

## Fonction d'erreur

Afin de différencier deux modèles en fonction de leurs efficacités, on va utiliser une **fonction d'erreur** qui mesure le taux d'erreur entre notre modèle et la réalité.

Dans le cas de la régression linéaire, une fonction d'erreur très commune est celle-ci :

$J(\theta) = \frac{1}{2m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

$J$ est notre fonction d'erreur, et elle prend $\theta$ comme paramètres. La variable $m$ correspond au nombre d'exemples dans l'entrée, et $x_{i}$ ainsi que $y_{i}$ désignent le $i$ème exemple sous la forme d'un couple (entrée, sortie).

Décomposons maintenant cette fonction afin de comprendre ce qu'elle cherche à faire :

$(h_{\theta}(x_{i}) - y_{i})^2$

Ici on réalise la différence sur un exemple $i$ donné, entre l'estimation de notre fonction d'hypothèse et la sortie fournie en entrée. On cherche à voir si notre fonction est loin ou proche des données qu'on a récoltées (et donc de la réalité). Cette différence est montée au carré afin d'avoir un résultat positif dans un premier temps, mais aussi car la puissance permet d'amplifier le résultat (s'il y a un gros écart, le carré produira un résultat très élevé et inversement), alors qu'avec une autre fonction comme la [valeur absolue](https://en.wikipedia.org/wiki/Absolute_value) on n'aurait pas cette deuxième propriété qui permet de mieux distinguer l'efficacité entre deux modèles.

Si on reprend la généralisation qu'on a faite à la main, la différence que l'on calcule dans notre expression correspond aux parties vertes sur ce schéma :

![Exemple de calcul de différence entre estimation et réalité](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lin_poly/exemple_calcul_erreur.png)

Notre fonction d'erreur va alors calculer la moyenne des différences sur nos $m$ exemples :

$\frac{1}{m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

Enfin, on divise le résultat par 2 à titre de convention car cela simplifiera nos futurs calculs :

$\frac{1}{2m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

Cette fonction nous permet alors de comparer deux modèles en fonction des paramètres $\theta$ qu'ils utilisent.

Grâce à cela, on peut enfin définir concrètement ce que signifie "trouver le meilleur modèle". Cela revient à trouver des paramètres $\theta$ qui **minimisent** la fonction d'erreur utilisée.

Si l'on affiche graphiquement la fonction d'erreur pour notre problème, on obtient ceci :

![Exemple de représentation graphique de la fonction d'erreur](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lin_poly/exemple_fonction_erreur.png)

Sur ce graphique représentant $J$ en fonction de $\theta_{0}$ et $\theta_{1}$, on remarque clairement les valeurs de $\theta$ pour lesquelles la fonction d'erreur est minimisée. Cependant, il va falloir trouver un algorithme qui calcule ces valeurs automatiquement, car on ne pourra pas toujours faire de représentation graphique (lorsqu'on a beaucoup d'attributs en entrée par exemple).

## Algorithmes

On a réussi à définir mathématiquement l'objectif de la régression linéaire grâce à notre fonction d'erreur. Désormais il faut donc minimiser cette fonction avec les paramètres $\theta$.

Deux méthodes répandues s'offrent à nous :

- [**L'algorithme du gradient**](/algo/ia/apprentissage_artificiel/regression_lin_poly/algo_gradient.html) (*gradient descent* en anglais) : un algorithme itératif utile quand $n$ est très large, et personnalisable grâce à un coefficient d'apprentissage (ce dernier peut aussi être un désavantage car dans certains cas il est difficile de le choisir efficacement).
- [**L'équation normale**](/algo/ia/apprentissage_artificiel/regression_lin_poly/equation_normale.html) : une équation donnant le résultat directement sans itérations, cependant cette dernière est très lourde en opérations à cause du [produit matriciel](https://en.wikipedia.org/wiki/Matrix_multiplication) qui a une complexité en temps de $O(n^3)$. On l'utilisera plutôt quand $n$ est suffisamment petit (en général en dessous de 10000).

## Régression polynomiale

Maintenant qu'on a vu comment fonctionne la régression linéaire, il est temps d'utiliser des fonctions polynomiales plus complexes afin de généraliser sur des données non linéaires. En réalité, l'unique changement à réaliser est sur notre fonction d'hypothèse puisque la fonction d'erreur et les deux algorithmes restent exactement les mêmes. Il suffit donc d'employer une **fonction d'hypothèse polynomiale** :

$h_{\theta}(x) = \theta_{0} + \theta_{1}x_1 + \theta_{2}x_2^2 + \ldots + \theta_{n}x_n^d$

Dans cette expression, $d$ correspond au degré maximum de notre fonction.

Dans le cas où on a peu d'attributs, et qu'on veut une fonction très complexe, il est tout à fait possible d'utiliser plusieurs fois les mêmes attributs mais avec différents degrés, par exemple :

$h_{\theta}(x) = \theta_{0} + \theta_{1}x_1 + \theta_{2}x_1^2 + \theta_{3}x_1^3$

Il est aussi courant d'ajouter d'autres termes que de simples puissances, comme des exponentiations, des logarithmes, des racines carrées, des fonctions trigonométriques, etc. dans le but de modéliser des fonctions avec un aspect particulier pour bien coller à nos données.

Si possible, afficher les données sur un graphique est la meilleure chose à faire afin de pouvoir visualiser quels types d'attributs il nous faut pour notre fonction d'hypothèse. Sinon, il est toujours envisageable de tester plusieurs combinaisons et de voir laquelle est la meilleure en fonction du résultat de la fonction d'erreur.

![Exemple de régression polynomiale sur des données non-linéaires](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lin_poly/exemple_regression_polynomiale.png)

## Problèmes

Dans le domaine de l'apprentissage artificiel, il y a un problème commun à de très nombreux algorithmes : le **surapprentissage**.

Dans un apprentissage supervisé, le but est de fournir à notre algorithme des exemples à partir desquels il peut généraliser le problème à résoudre. Cependant, il arrive que ce dernier ne généralise pas assez, et en vient à réciter par cœur les données fournies. Le problème est que notre programme va alors trouver la bonne réponse sur quasiment tous nos exemples, mais dès qu'il verra une nouvelle entrée il répondra totalement à côté. Il n'a pas réussi à généraliser, et il est tombé dans le cas par cas. Cette notion de surapprentissage (ou *overfitting* en anglais) est essentielle à comprendre car c'est un problème extrêmement récurrent dans le domaine de l'apprentissage artificiel, et spécialement dans le cadre d'un apprentissage supervisé.

Par exemple, prenons des données imaginaires :

![Exemple de données](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lin_poly/exemple_donnees_vide.png)

On pourrait tenter d'utiliser une régression linéaire avec une fonction d'hypothèse de la forme $h_{\theta}(x) = \theta_0 + \theta_1x_1$ :

![Tentative de régression linéaire](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lin_poly/exemple_sousapprentissage.png)

On voit bien qu'on arrive à une très mauvaise généralisation car il nous manque des attributs. Dans ce cas, on parle de **sous-apprentissage** (ou *underfitting* en anglais), c'est une situation plus rare que le surapprentissage, et il suffit de rajouter des attributs pour contrer le problème. Essayons, avec une simple fonction polynomiale comme $h_{\theta}(x) = \theta_0 + \theta_1x_1 + \theta_2x_1^2$ :

![Une simple fonction polynomiale](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lin_poly/exemple_regression_polynomiale.png)

Notre modèle polynomial correspond bien à nos données et semble assez bien généraliser le problème. Cependant, que se passe-t-il si on avait rajouté plus d'attributs ? Essayons avec une fonction polynomiale plus complexe comme $h_{\theta}(x) = \theta_0 + \theta_1x_1 + \theta_2x1^2 + \theta_3x1^3 + \theta_4x1^4 \ldots$ :

![Fonction polynomiale très complexe](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lin_poly/exemple_surapprentissage.png)

Le modèle essaie de coller au mieux à nos données au point de ne plus du tout généraliser le problème, on est tombé dans le surapprentissage. Notre programme s'est trop bien adapté à nos données, et il n'arrivera pas à prédire correctement la sortie de nouveaux exemples.

L'apprentissage supervisé est donc un domaine difficile car il faut arriver à trouver les attributs vraiment nécessaires à notre algorithme pour être le plus efficace possible, sans pour autant tomber dans le surapprentissage. Mais il existe des méthodes afin d'éviter au plus ce problème si contraignant, comme la **régularisation**.

### Régularisation

#### Algorithme du gradient

#### Equation normale

#### Validation croisée

## Conclusion
