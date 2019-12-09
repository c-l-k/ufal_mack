'''
======================
3D surface (color map)
======================

Demonstrates plotting a 3D surface colored with the coolwarm color map.
The surface is made opaque by using antialiased=False.

Also demonstrates using the LinearLocator and custom formatting for the
z axis tick labels.
'''

from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import numpy as np
import math
import os
plt.rc('text', usetex=True)

fig = plt.figure()
ax = fig.gca(projection='3d')
# Make a read
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Code")
os.chdir("/home/aborba/ufal_mack")
os.chdir("/home/aborba/ufal_mack/Data/")
f = open("real_flevoland_1.txt","r" )
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Data")
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Code/")
os.chdir("/home/aborba/ufal_mack/Code/Code_python")
# Make manipulation of the files
mat = np.loadtxt(f)
dim = mat.shape[0]
sig = np.zeros(dim)
for i in range(dim):
        sig[i] = mat[50][i]
# Make data.
x = np.arange(1, 10, 0.01)
y = np.arange(0.01, 1 , 0.01)
x1, y1 = np.meshgrid(y, x)
dimx = x.shape
dimy = y.shape
n = dimx[0]
m = dimy[0]
l = 10
sigma = sig[l]
gamma = np.zeros(n)
for i in range(n):
    gamma[i] = math.gamma(x[i])
s = (n, m)
z = np.zeros(s)
for i in range(n):
    for j in range(m):
        aux1 = x[i] * np.log(x[i]) 
        aux2 = (x[i] - 1) * np.log(sigma)
        aux3 = x[i] * np.log(y[j])
        aux4 = (x[i] / y[j]) * sigma
        z[i][j] = aux1 + aux2 - aux3 - aux4
surf = ax.plot_surface(x1, y1, z, cmap=cm.coolwarm,
#surf = ax.plot_surface(x1, y1, z, cmap=cm.Spectral,
                       linewidth=0, antialiased=False)

plt.xlabel(r'$\sigma$')
plt.ylabel(r'$L$')
plt.title(r'Função de máxima verossimilhança $\ell(L,\sigma)$')
# Customize the z axis.
#ax.set_zlim(-1.01, 1.01)
#ax.zaxis.set_major_locator(LinearLocator(10))
#ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

# Add a color bar which maps values to colors.
fig.colorbar(surf, shrink=0.5, aspect=5)

plt.show()
