clear;
close all;
clc;

% Récupère les données x, y
data = load('data_intro.txt');
data_size = size(data, 2);
x = data(:, 1:data_size - 1);
y = data(:, data_size);


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
