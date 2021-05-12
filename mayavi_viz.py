from mayavi import mlab
import numpy as np

mof = "Co-MOF-74"
contaminants = ['N2', 'CO2', 'C2H6']

reloaded = np.load("{}_{}_{}_{}.npz".format(mof, contaminants[0], contaminants[1], contaminants[2]))
X1 = reloaded['X1']
X2 = reloaded['X2']
X3 = reloaded['X3']
M = reloaded['M']
v1 = reloaded['v1']
v2 = reloaded['v2']
v3 = reloaded['v3']
x_op = reloaded['x_op']

mlab.figure(bgcolor=(1.0, 1.0, 1.0), fgcolor=(0.0, 0.0, 0.0))
mlab.quiver3d(x_op[0], x_op[1], x_op[2], v1[0], v1[1], v1[2], color=(0.0, 0.0, 0.0), line_width=10, mode="arrow", scale_factor=0.2)
mlab.quiver3d(x_op[0], x_op[1], x_op[2], v2[0], v2[1], v2[2], color=(0.0, 0.0, 0.0), line_width=10, mode="arrow", scale_factor=0.2)
mlab.quiver3d(x_op[0], x_op[1], x_op[2], v3[0], v3[1], v3[2], color=(0.0, 0.0, 0.0), line_width=10, mode="arrow", scale_factor=0.2)
mlab.text(1.2, 1.2, "$v_1$", z=1.2)
mlab.contour3d(X1, X2, X3, M, colormap="viridis", opacity=0.3, contours=8, vmin=0.0)
mlab.axes(xlabel=contaminants[0], ylabel=contaminants[1], zlabel=contaminants[2])
mlab.colorbar(title="m [g/g]", orientation="vertical")
mlab.show()
