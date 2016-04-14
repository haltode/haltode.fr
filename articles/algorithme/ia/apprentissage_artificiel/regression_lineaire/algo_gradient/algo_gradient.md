Algorithme du gradient
======================
algo/ia/apprentissage_artificiel/regression_lineaire

Publié le : 14/04/2016  
*Modifié le : 14/04/2016*

## Principe

L'idée de l'algorithme est de commencer avec des paramètres initiaux $\theta$ (en général on utilise 0), puis d'adapter ces derniers avec le résultat obtenu par notre fonction d'erreur, afin de minimiser $J$ pour arriver on l'espère à un minimum global.

Il est plus difficile de visualiser l'idée de l'algorithme sur notre précédent graphique en 3D, alors on va utiliser un graphique 2D spécial qui trace les contours (on appelle cela un [*contour plot*](http://www.itl.nist.gov/div898/handbook/eda/section3/contour.htm) en anglais) :

![Contour plot de notre graphique](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient/contour_plot.png)

Les contours représentent $J$ en fonction de nos deux coefficients $\theta_{0}$ et $\theta_{1}$. La croix rouge correspond au minimum de la fonction d'erreur, et c'est le point qu'on cherche à atteindre.

L'algorithme du gradient va procéder ainsi :

![Exemple du fonctionnement de l'algorithme du gradient](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient/exemple_algo_gradient.png)

On part d'un point initial sur le graphique, et on fait des pas de plus en plus petits afin de se rapprocher du minimum de la fonction. Cependant, comment l'algorithme réalise-t-il ces pas ? Comment est-ce qu'il décide de l'amplitude, ou encore de la direction à emprunter ?

Pour comprendre l'algorithme, on peut imaginer que ce dernier utilise la "pente" de la représentation de la fonction pour décider du prochain point à explorer. Mathématiquement parlant, cette décision se fera grâce à la [**dérivée partielle**](https://en.wikipedia.org/wiki/Partial_derivative) de la fonction $J$ au point actuel de notre algorithme.

Simplifions notre problème avec un exemple de fonction $J$ prenant uniquement un paramètre $\theta_{0}$ :

![Exemple simplifié de l'algorithme du gradient](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient/exemple_simplifie_algo_gradient.png)

On initialise l'algorithme avec un point tel que $\theta_{0} = 0$, et on calcule la dérivée partielle de la fonction $J$ en ce point :

![Initialisation](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient/exemple_simplifie_algo_gradient_init.png)

La dérivée partielle est la droite en bleue, et on remarque que son coefficient directeur est négatif et important, notre algorithme va donc augmenter $\theta_{0}$ de manière importante.

On peut continuer ainsi jusqu'à tomber sur le minimum de notre fonction :

![Reste de l'algorithme](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient/exemple_simplifie_algo_gradient_reste.png)

## Pseudo-code

Maintenant qu'on a vu le principe, il faut le décrire de manière concrète et mathématique.

Tant que l'algorithme ne converge pas, on met à jour tous nos coefficients $\theta$ pour $j$ allant de 0 à $n$ :

$\theta_{j} = \theta_{j} - \alpha\frac{\partial}{\partial\theta_{j}}J(\theta)$

$\alpha$ est notre **vitesse d'apprentissage**, qui sert à réguler la rapidité de la convergence et la dérivée partielle de $J$ est représentée par $\frac{\partial}{\partial\theta_{j}}J(\theta)$. Lorsqu'on [calcule cette dérivée partielle](https://math.stackexchange.com/questions/70728/partial-derivative-in-gradient-descent-for-two-variables/189792#189792) on obtient :

$\frac{\partial}{\partial\theta_{j}}J(\theta) = \frac{1}{m}\displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})x_{ij}$

Notre formule finale est donc :

$\theta_{j} = \theta_{j} - \alpha\frac{1}{m}\displaystyle\sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})x_{ij}$

Il est primordial de bien choisir le coefficient d'apprentissage, car si $\alpha$ est trop élevé notre algorithme va chercher à faire de très grands pas afin de converger rapidement, ce qui peut l'amener à faire de mauvais choix comme par exemple :

![Exemple de conséquence d'un coefficient d'apprentissage élevé](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient/exemple_coeff_apprentissage_eleve.png)

De même, une vitesse d'apprentissage trop faible rendra notre algorithme terriblement lent :

![Exemple de conséquence d'un coefficient d'apprentissage faible](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient/exemple_coeff_apprentissage_faible.png)

Pour choisir une valeur adaptée à notre problème, il faut en essayer différentes (0.001, 0.01, 0.1, 1, 10, etc.) tout en créant un graphique représentant l'évolution de notre minimisation de $J$ en fonction du nombre d'itérations de l'algorithme. Si vous avez bien choisi le coefficient, vous devriez voir un graphique semblable à ceci :

![Exemple de coefficient adapté](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient/exemple_coeff_apprentissage_bon.png)

Dans notre détail de l'algorithme du gradient, il y a un point très important à ne pas négliger : la mise à jour de manière **instantanée**. Vu que notre expression dépend elle-même de $\theta$, on ne peut pas se permettre de modifier certaines valeurs lorsqu'on met à jour nos coefficients, il faut donc procéder en deux étapes bien distinctes :

- Mettre à jour nos valeurs en utilisant des variables temporaires.
- Copier le contenu de ces variables temporaires dans nos coefficients.

Si l'on garde notre exemple avec deux attributs, on aurait ces opérations à effectuer :

$temp0 = \theta_{0} - \alpha\frac{\partial}{\partial\theta_{0}}J(\theta_{0}, \theta_{1})$

$temp1 = \theta_{1} - \alpha\frac{\partial}{\partial\theta_{1}}J(\theta_{0}, \theta_{1})$

$\theta_{0} = temp0$

$\theta_{1} = temp1$

Le pseudo-code définitif ressemble donc à ceci :

```nohighlight
Tant que l'algorithme ne converge pas ET qu'on n'a pas dépassé la limite de tours
   Pour chaque coefficient
      Calculer temp[j]
   Pour chaque coefficient
      theta[j] = temp[j]
```

En général, on se contente de garder la deuxième condition dans notre boucle principale afin de pouvoir fixer un nombre de tours maximum ou minimum à notre algorithme (si ce dernier prend du temps par exemple, ou si on souhaite étudier sa progression).

## Implémentation

Par convention et pour simplifier le code, il n'est pas rare de rajouter un attribut $x_0 = 1$, afin de remplacer notre fonction d'hypothèse $h_{\theta}(x) = \theta_{0} + \theta_{1}x_1 + \theta_{2}x_2 + \ldots + \theta_{n}x_n$, en :

$h_{\theta}(x) = \displaystyle\sum_{i=0}^{n} \theta_{i}x_{i}$

Cette opération est ensuite réalisée très simplement dans notre code, car $\theta$ est une matrice contenant une seule colonne, ce qui signifie que pour calculer le résultat de notre fonction d'hypothèse, il suffit de faire un produit matriciel.

Voici donc le code en Python pour l'algorithme du gradient :

*J'utilise Python afin d'avoir accès à des librairies scientifiques comme [numpy](http://www.numpy.org/) pour les matrices et [matplotlib](http://matplotlib.org/) pour les sorties graphiques*

[INSERT]
regression_lineaire.py

Notre fichier d'entrée contient sur la première ligne le nombre $m$ d'exemples, puis le nombre $n$ d'attributs et sur les $m$ prochaines lignes une liste de nombre dont la dernière colonne correspond à $y$ et les autres à $x$. J'ai repris notre exemple de l'introduction pour construire le fichier d'entrée (les unités sont toujours en centaine d'opérations et en centaine d'euros) :

[INSERT]
test01.in

En sortie on obtient les coefficients $\theta$ de notre fonction d'hypothèse :

[INSERT]
test01.out

Vu qu'on a uniquement un attribut, on peut représenter notre fonction d'hypothèse et nos données en entrée sur un graphique 2D :

![Sortie graphique du programme](//static.napnac.ga/img/algo/ia/apprentissage_artificiel/regression_lineaire/algo_gradient/sortie_prog_algo_gradient.png)

On obtient bien une généralisation efficace sous forme de fonction linéaire qui ressemble fortement à celle qu'un humain peut faire à la main (même si celle que l'ordinateur a calculé est plus précise que celle faite à la main).

Le code utilisé pour réaliser cette sortie :

```python
import matplotlib.pyplot as plt

# Récupère dans des listes les valeurs de x, y, et de notre approximation de y
x = np.array(ia.x[:,1]).tolist()
x = [float(i[0]) for i in x]

y = np.array(ia.y).tolist()
y = [float(i[0]) for i in y]

y_approx = np.array(ia.x * ia.theta).tolist()
y_approx = [float(i[0]) for i in y_approx]

# Affiche les points donnés en entrée, ainsi que notre modèle linéaire
plt.plot(x, y, '+')
plt.plot(x, y_approx, 'r-')
plt.show()
```

### Améliorations

Une des premières améliorations qu'on peut apporter à notre code est celle qu'on a apporté à notre fonction d'hypothèse : l'utilisation des opérations des matrices. Au lieu d'appliquer des opérations sur les éléments d'une matrice un par un, on peut utiliser des opérations plus générales sur notre matrice entière. Cela permet de supprimer la plupart des boucles, mais aussi à l'avantage de réaliser une mise à jour instantanée des coefficients automatiquement, sans même avoir besoin de stocker nos résultats dans des variables temporaires. On peut donc transformer notre algorithme du gradient en ceci :

$\theta = \theta - \alpha\frac{1}{m}x^\intercal(h_{\theta}(x) - y)$

Si on développe notre fonction d'hypothèse on arrive à cette expression :

$\theta = \theta - \alpha\frac{1}{m}x^\intercal(x\theta - y)$

Il n'y a plus aucunes boucles, et uniquement des opérations matricielles. Notre fonction pour l'algorithme du gradient devient donc dans notre code :

```python
def algo_gradient(self, alpha, nb_tour_max):
   for _ in range(nb_tour_max):
      derivee = np.transpose(self.x) * (self.x * self.theta - self.y)
      self.theta = self.theta - alpha * (1 / self.m) * derivee
```

Une deuxième amélioration concernant cette fois-ci l'algorithme en lui même plutôt que le code.

- feature scaling
- mean normalization
