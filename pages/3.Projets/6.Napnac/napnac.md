Napnac.ga
=========
projets/

Publié le :  
*Modifié le : 11/11/2015*

## Introduction

Avant ce site, mes articles étaient postés sur [Wordpress](https://en.wikipedia.org/wiki/WordPress) et j'en étais très content jusqu'à ce que j'apprenne à utiliser de plus en plus le [Markdown](https://en.wikipedia.org/wiki/Markdown) pour écrire mes articles. Finalement, je trouvais le site et sa gestion trop lourde pour son contenu, et je voulais quelque chose de plus simple, plus léger et surtout de plus adapté à mes besoins. Ne souhaitant pas payer pour un service où je ne serais pas satisfait à 100%, j'ai décidé de créer mon propre site web spécifique à mes envies.

## La création du site

### Les pages

La particularité de ce site est que toutes les pages que vous voyez sont en réalité rédigées en Markdown et non en [HTML](https://en.wikipedia.org/wiki/HTML) (le langage de base pour la création de site web). La raison est que je n'apprécie pas du tout le HTML, et que je me suis fixé comme objectif d'en écrire le moins possible, afin de pouvoir modifier n'importe quelle page facilement car le Markdown est tout de même bien plus agréable à lire et à écrire que le HTML.

Les deux seules choses nécessaires qui sont écrites en HTML sont le *header* et le *footer* de la page. Le *header* est simplement le logo et le menu principal du site, et le *footer* est le bas de la page composé d'une image. Le reste de la page est écrite en Markdown et suit ce format :

```markdown
Titre de la page
================
categorie/sous-categorie/

Publié le :  
Modifié le :

## Je suis un titre

Je suis un paragraphe

Blablabla
```

Chaque page est ensuite convertie via un script que j'ai écrit en [Bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) qui permet alors de créer une page HTML correspondante. Cette page HTML contient finalement le header, l'article converti (Markdown -> HTML), le footer, et sera déplacée à la fin du script dans sa catégorie correspondante.

Le lien vers le script (contenant des informations plus détaillées à ce propos) : <https://github.com/iTech-/NapNac/blob/master/conversion.sh>

Toutes les pages sont stockées dans le dossier `pages` et converties en HTML dans le dossier `src`.

### Le nom de domaine

Un simple nom de domaine gratuit me suffit pour le moment, mais j'envisage de m'en acheter un plus tard. Pour trouver le nom de domaine, j'ai utilisé [Freenom](http://www.freenom.com/fr/index.html) et j'ai choisi de prendre `napnac.ga`.

### L'hébergeur

Pour héberger mon site, encore une fois je n'ai pas envie de payer pour un hébergeur, j'ai donc voulu créer mon propre serveur grâce à ma [Raspberry Pi](https://www.raspberrypi.org/) (version 1, modèle B). 

J'ai installé [Raspbian](https://www.raspberrypi.org/downloads/) (l'OS officiel de la Raspberry Pi), et après avoir configuré un accès [SSH](https://en.wikipedia.org/wiki/Secure_Shell) pour accéder à mon serveur depuis mon pc principal, j'ai commencé la configuration dudit serveur. Il y a de nombreux tutoriels sur comment transformer sa Raspberry Pi en serveur, je passerai donc les détails. Le serveur que j'ai choisi d'installer est [nginx](http://nginx.org/), son installation et sa configuration sont très simples et je n'ai quasiment rien eu à faire.

Pour rendre mon site accessible depuis l'extérieur, il me faut configurer plusieurs choses. Tout d'abord des ports spécifiques de ma livebox doivent être redirigés vers ma Raspberry Pi afin de répondre aux requêtes du client en lui renvoyant les pages HTML stockées sur mon serveur. De même, plusieurs tutoriels existent déjà à ce sujet, mais voici à quoi ressemble les modifications faites à ma livebox :

![Configuration des ports de la livebox](/static/img/projets/napnac.ga/config_livebox_rpi.png)

Enfin, ma livebox possède une adresse IP dynamique, j'ai donc choisi d'utiliser [CloudFlare](https://www.cloudflare.com/) afin de gérer le [DNS](https://en.wikipedia.org/wiki/Domain_Name_System). De plus, j'ai trouvé un petit [script](https://techjourney.net/update-cloudflare-as-dynamic-dns-ddns/) permettant d'utiliser l'API de CloudFlare pour avoir un DNS dynamique et faire les modifications nécessaires lors d'un changement d'IP de ma livebox. Ce script est exécuté toutes les 5 minutes sur mon serveur.

## Conclusion

Le site est désormais comme je le souhaite, et j'ai la possibilité de le changer à n'importe quel moment vu que je contrôle la plupart de son fonctionnement (hébergement, création de pages, etc.). A travers ce projet j'ai appris beaucoup sur le fonctionnement de réseaux (comment configurer un serveur, le rendre accessible depuis l'extérieur, y accéder en SSH, gérer le DNS, etc.) et j'ai enfin un endroit que j'apprécie à 100% et où je peux poster mes articles.

Tous les codes sources, les articles, les images, etc. sont disponibles sur la page Github du projet : <https://github.com/iTech-/NapNac>
