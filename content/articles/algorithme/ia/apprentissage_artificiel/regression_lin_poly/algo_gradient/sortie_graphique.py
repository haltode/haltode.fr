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
