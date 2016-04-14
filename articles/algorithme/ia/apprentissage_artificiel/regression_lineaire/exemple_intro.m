clear;
close all;
clc;

% Exemple de données en entrée
x = [1.73 ; 4.07 ; 5.34 ; 7.14 ; 9.56 ; 12.26];
y = [1.94 ; 2.87 ; 5.01 ; 6.74 ; 7.71 ; 8.6];


figure;
hold on;

% Graphique affichant les données x et y
plot(x, y, '@');
xlabel("Puissance de calcul (en centaine d\'operations par seconde)");
ylabel("Prix (en centaine d\'euros)");

% Ajout d'une ligne représentant une estimation faite à la main
line_x = [0.85 ; 12.8];
line_y = [0.73 ; 9.45];
plot(line_x, line_y, 'r');

hold off;
