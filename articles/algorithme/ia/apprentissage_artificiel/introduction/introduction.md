Introduction à l'apprentissage artificiel
=========================================
algo/ia/apprentissage_artificiel

Publié le : 04/04/2016  
*Modifié le : 04/04/2016*

## Introduction

Si vous suivez régulièrement les nouvelles dans le domaine de l'informatique, vous êtes sans doute déjà tombé sur un article parlant d'un programmant utilisant le principe d'apprentissage artificiel (ou *machine learning* en anglais) afin de résoudre efficacement une tâche qui parait compliquée voire impossible pour un ordinateur. Si ce n'est pas le cas, il suffit de taper "machine learning" dans un moteur de recherche et regarder les résultats dans la section "news" pour apercevoir un nombre impressionnant d'articles récents à ce propos et sur des thèmes très variés. Mais qu'est-ce que l'apprentissage artificiel ? Dans quel domaine peut-on l'appliquer ? Et surtout quels sont concrètement les algorithmes mis en place par ce type d'apprentissage ?

## Principe

En général, lorsqu'on cherche à résoudre un problème avec un ordinateur, on lui demande de réaliser une suite d'opérations bien précises pour avoir une sortie voulue. Cependant, dans certains cas il est très compliqué de définir cette suite d'opérations, et pourtant en tant qu'humain nous sommes capable de le faire sans difficulté. Par exemple, essayez de décrire à votre machine comment reconnaître un visage sur une photo, pour l'ordinateur l'image n'est qu'un amas de pixels, et la notion de visage ne lui évoque rien du tout, cependant vous êtes capable instantanément de le faire et cela depuis tout petit. Le but de l'apprentissage artificiel n'est pas de décrire directement des opérations afin de résoudre le problème, mais plutôt de donner la capacité à l'ordinateur d'apprendre à résoudre le problème par lui même. Pour apprendre, il fait comme vous et moi lorsqu'on essaie de s'améliorer dans une discipline, c'est-à-dire en essayant, en échouant, et en adaptant sa stratégie dans le but d'être meilleur la prochaine fois.

L'apprentissage artificiel (ou parfois appelé *apprentissage automatique*) désigne un domaine de l'intelligence artificiel visant à **reproduire un comportement spécifique** à partir de **données**. Ce comportement est en général créé à partir de rien, et sera ensuite amélioré automatiquement par l'algorithme d'apprentissage.

On peut alors comprendre à quel point ce domaine peut être intéressant vu la complexité de certaines automatisations de tâches aujourd'hui. D'autant plus qu'on a accès rapidement à énormément de données grâce à Internet, rendant l'apprentissage toujours plus efficace.

## Type d'apprentissage

Il existe de nombreuses manières de faire apprendre quelque chose à votre ordinateur, et il faut choisir la plus adaptées en fonction du but de votre intelligence artificielle :

- **Apprentissage supervisé** : on fournit à l'ordinateur un exemple d'entrées pour le problème qu'on cherche à résoudre, ainsi que les sorties correspondantes et on souhaite que notre algorithme généralise du mieux possible afin de pouvoir trouver la sortie (ou une approximation) par lui même à partir d'une nouvelle entrée qu'il n'a jamais vu auparavant. Par exemple, si on reprend l'idée de détecter un visage dans une photo, on pourrait donner à l'ordinateur des milliers de photos différentes et lui indiquer pour chacune où se trouve les visages afin qu'il puisse essayer de comprendre ce qu'est un visage pour finalement savoir en détecter un sur de nouvelles photos.
- **Apprentissage non supervisé** : on donne cette fois ci à l'ordinateur uniquement les entrées, et on aimerait qu'il regroupe les entrées en différentes classes qu'il génère et qu'il attribue alors automatiquement aux entrées. Par exemple, vous avez une liste d'articles de journaux que vous aimeriez trier en fonction du sujet abordé dedans, l'idée serait que votre algorithme regroupe les articles discutant d'un sujet commun ensemble. L'entrée serait alors les articles, tandis que les sorties seraient les catégories auxquelles appartiennent les différentes articles.
- **Apprentissage semi supervisé** : 
- **Apprentissage par renforcement** : 

Il faut aussi faire attention à la sortie voulue, et il existe alors différents types de problème :

- **Classification** : on cherche à catégoriser les entrées grâce à différentes **classes** (dans un apprentissage non supervisé donc), ces classes peuvent être par exemple dans le cadre d'une description d'une image : "animal", "paysage", "montagne", "forêt", etc.
- **Régression** : les valeurs obtenues dans un problème de régression sont des **valeurs numériques**, par exemple l'estimation du prix d'un appartement en fonction de différents critères comme sa taille, son emplacement géographique, le nombre de pièce, son ancienneté, etc.

## Domaine d'application

L'apprentissage artificiel est présent partout :

- **Médecine** : afin de faire des diagnostiques, un ordinateur peut être un atout majeur car il a accès à des milliers d'exemples de patients et peut ainsi effectuer un diagnostique automatiquement et relativement précis sur le type de maladie, son avancement, etc. (ex : [Watson](https://en.wikipedia.org/wiki/Watson_%28computer%29) une intelligence artificielle développée par IBM qui a des utilisations multiples, et notamment dans la médecine).
- **Moteur de recherche** : la plupart des moteurs de recherches modernes utilisent des algorithmes de machine learning autant pour comprendre la requête de l'utilisateur, que pour la chercher ou encore trier les résultats.
- **Communication** : la reconnaissance vocale, ou la compréhension d'un message écrit sont des problèmes extrêmement complexes à résoudre, et pourtant grâce à l'apprentissage artificiel, on arrive parfois à des résultats assez impressionnant de précision hors normes. [Hound](http://www.soundhound.com/hound) avait fait beaucoup de bruit en 2015 grâce à une [vidéo](https://www.youtube.com/watch?v=M1ONXea0mXg) qui démontrait une efficacité incroyable comparé à ses autres concurrents (Siri, Google Now, Cortana, etc.).
- **Traitement d'images** : que ce soit pour reconnaître un visage, ou décrire une image, l'apprentissage artificiel est souvent indispensable vu la complexité de la tâche. Facebook a par exemple un algorithme terriblement efficace de reconnaissance de visage, grâce au nombre colossal de photos envoyées sur la plateforme en ligne (servant alors d'exemple et d'entraînement à l'algorithme). Ce dernier est tellement puissant qu'il est même capable de vous reconnaître de dos ou si votre visage est partiellement couvert, voire que vous ne regardez pas la caméras depuis quelques années maintenant (todo : lien). Google a aussi développé un programme capable de faire une description très précise d'une image (todo : lien)
- TODO : continuer les exemples

Mais on retrouve aussi cette forme d'intelligence artificielle dans des applications moins pratiques dans la vie de tous les jours, mais tout de même intéressantes voire surprenantes :

- Art (peinture, musique, etc.)
- Jeu (échec, go, etc.)

TODO : image ?

## Conclusion
