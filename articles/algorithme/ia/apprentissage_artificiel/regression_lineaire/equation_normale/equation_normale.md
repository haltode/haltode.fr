Equation normale
================
algo/ia/apprentissage_artificiel/regression_lineaire

Publié le : 19/04/2016  
*Modifié le : 19/04/2016*

## Introduction

Contrairement à l'[algorithme du gradient](/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient.html) l'équation normale est une expression mathématique et non pas un algorithme itératif, qui permet de résoudre notre problème de [régression linéaire](/algo/ia/apprentissage_artificiel/regression_lineaire.html) en trouvant les valeurs de $\theta$ pour lesquelles notre fonction $J$ est minimisée.

## Principe

L'équation normale est définie comme ceci :

$\theta = (x^\intercal x)^{-1} x^\intercal y$

On peut grâce à cela calculer directement $\theta$ qui permet d'obtenir notre fonction d'hypothèse tel que $h_{\theta} \simeq y$.

## Démonstration

Reprenons notre fonction d'hypothèse :

$h_{\theta} = x\theta$

Ainsi que notre fonction d'erreur :

$J(\theta) = \frac{1}{2m} \displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})^2$

Vu que $x$ et $\theta$ sont deux matrices, on peut se permettre de réécrire notre fonction $J$ en utilisant des opérations matricielles et en remplaçant la fonction d'hypothèse par son contenu :

$J(\theta) = \frac{1}{2m} (x\theta - y)^\intercal (x\theta - y)$

Or, soit $A$ et $B$ deux matrices on a $(A + B)^\intercal = A^\intercal + B^\intercal$, donc :

$J(\theta) = \frac{1}{2m} ((x\theta)^\intercal - y^\intercal)(x\theta - y)$

Plus loin dans la démonstration on va dériver cette fonction puis la comparer à 0, le facteur $\frac{1}{2m}$ sera donc inutile et il n'y a pas besoin de le garder ici :

$J(\theta) = ((x\theta)^\intercal - y^\intercal)(x\theta - y)$

Développons les deux facteurs :

$J(\theta) = (x\theta)^\intercal x\theta - (x\theta)^\intercal y - y^\intercal (x\theta) + y^\intercal y$

On sait que $y$ est un vecteur et que le résultat de la multiplication matricielle $x\theta$ l'est aussi, l'ordre de multiplication des deux ne change donc rien et on peut simplifier $- (x\theta)^\intercal y - y^\intercal (x\theta)$ en $-2(x\theta)^\intercal y$ :

$J(\theta) = (x\theta)^\intercal x\theta -2(x\theta)^\intercal y + y^\intercal y$

On peut continuer de développer notre expression puisque $(AB)^\intercal = B^\intercal A^\intercal$ :

$J(\theta) = \theta^\intercal x^\intercal x\theta - 2(x\theta)^\intercal y + y^\intercal y$

Pour trouver $\theta$ à partir de cette expression, il faut [dériver](http://eli.thegreenplace.net/2015/the-normal-equation-and-matrix-calculus/) la fonction $J$ et comparer le résultat à 0. On obtient :

$\frac{\partial J}{\partial\theta} = 2x^\intercal x\theta - 2x^\intercal y$

$2x^\intercal x\theta - 2x^\intercal y = 0$

On ajoute $2x^\intercal y$ de chaque côté de l'équation, et on divise par deux l'expression :

$x^\intercal x\theta = x^\intercal y$

Si la matrice résultant du calcul de $x^\intercal x$ est **inversible**, alors on peut multiplier les deux côtés par l'inverse de cette dernière et ainsi affirmer que :

$\theta = (x^\intercal x)^{-1} x^\intercal y$

On retrouve bien notre équation normale.

## Implémentation

Le code en Python permettant de calculer les paramètres $\theta$ avec l'équation normale :

[INSERT]
equation_normale.py

## Conclusion
