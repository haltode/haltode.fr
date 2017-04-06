import numpy as np


# x = exemple d'entrée
# y = exemple de sortie
# m = nombre d'exemples
# n = nombre d'attributs
# theta = coefficients de notre fonction d'hypothese

class regression_lineaire:

    def __init__(self, entree):
        with open(entree) as f:
            self.m, self.n = map(int, f.readline().split())

        self.x = np.matrix(np.loadtxt(entree, skiprows=1,
                            usecols=(list(range(self.n))), ndmin=2))
        self.y = np.matrix(np.loadtxt(entree, skiprows=1,
                            usecols=([self.n]), ndmin=2))

        # Ajoute une colonne de 1 au début de notre matrice x
        col = np.ones((self.m, 1))
        self.x = np.matrix(np.hstack((col, self.x)))
        self.n = self.n + 1

    def equation_normale(self):
        x_t = np.transpose(self.x)
        self.theta = (x_t * self.x).I * x_t * self.y


ia = regression_lineaire("test01.in")
ia.equation_normale()

print("Coefficients de la fonction d'hypothese :\n")
for j in range(ia.n):
    print("theta ", j, " : ", float(ia.theta[j]))
