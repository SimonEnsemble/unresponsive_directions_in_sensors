from mayavi import mlab
import numpy as np

mof = "Co-MOF-74"
contaminants = ['N2', 'CO2', 'C2H6']
labels = {'N2': 'nitrogen', 'CO2': 'carbon dioxide', 'C2H6': 'ethane'}

# load data from .ipynb
data = np.load("{}_{}_{}_{}.npz".format(mof, contaminants[0], contaminants[1], contaminants[2]))
X1   = data['X1']
X2   = data['X2']
X3   = data['X3']
M    = data['M']
v1   = data['v1']
v2   = data['v2']
v3   = data['v3']
x_op = data['x_op']

mlab.figure(bgcolor=(1.0, 1.0, 1.0), fgcolor=(0.0, 0.0, 0.0))
for v in [v1]:
    mlab.quiver3d(x_op[0], x_op[1], x_op[2], v[0], v[1], v[2], color=(0.0, 0.0, 0.0), line_width=4, mode="arrow", scale_factor=0.15)
for v in [v2, v3]:
    mlab.quiver3d(x_op[0], x_op[1], x_op[2], v[0], v[1], v[2], color=(1.0, 0.0, 0.0), line_width=4, mode="arrow", scale_factor=0.15)
mlab.text(1.2, 1.2, "$v_1$", z=1.2)
mlab.contour3d(X1, X2, X3, M, colormap="viridis", opacity=0.5, contours=8, vmin=0.0)
mlab.axes(xlabel=labels[contaminants[0]], ylabel=labels[contaminants[1]], zlabel=labels[contaminants[2]])
mlab.colorbar(title="m [g/g]", orientation="vertical")
mlab.show()
