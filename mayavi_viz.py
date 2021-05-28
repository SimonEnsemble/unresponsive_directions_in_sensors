from mayavi import mlab
import numpy as np
import sys

mof = sys.argv[1]
contaminants = ['N2', 'CO2', 'C2H6']
labels = {'N2': 'nitrogen', 'CO2': 'carbon dioxide', 'C2H6': 'ethane'}
cool_colors = {'green': (0.0, 0.716, 0.554), 'red': (1.0, 0.403, 0.397), 'blue': (0.0, 0.747, 1.0), "yellow": (0.830929, 0.793470, 0.225663), "purple": (0.745987, 0.663119, 1.000000)}

# load data from .ipynb
data = np.load("{}_{}_{}_{}.npz".format(mof, contaminants[0], contaminants[1], contaminants[2]))
X1   = data['X1']
X2   = data['X2']
X3   = data['X3']
M    = data['M']
v1   = -data['v1'] / 2
v2   = -data['v2'] / 2
v3   = -data['v3'] / 2
x_op = data['x_op']

if mof == "HKUST-1":
    v1 = -v1
if mof == "Co-MOF-74":
    v2 = -v2
    v3 = -v3

mlab.figure(bgcolor=(1.0, 1.0, 1.0), fgcolor=(0.0, 0.0, 0.0))
mlab.points3d([x_op[0]], [x_op[1]], [x_op[2]], [0.1], color=(0.0, 0.0, 0.0), scale_factor=0.2)
mlab.quiver3d(x_op[0], x_op[1], x_op[2], 
              v1[0], v1[1], v1[2], color=cool_colors["green"], 
              line_width=4, mode="arrow", scale_factor=0.15)
mlab.quiver3d(x_op[0], x_op[1], x_op[2], 
              v2[0], v2[1], v2[2], color=cool_colors["red"], 
              line_width=4, mode="arrow", scale_factor=0.15)
mlab.quiver3d(x_op[0], x_op[1], x_op[2], 
              v3[0], v3[1], v3[2], color=cool_colors["red"], 
              line_width=4, mode="arrow", scale_factor=0.15)
#mlab.text(1.2, 1.2, "v_1", z=1.2)
c = mlab.contour3d(X1, X2, X3, M, colormap="viridis", opacity=0.25, contours=8, vmin=0.0)
mlab.colorbar(c, title="m [g/g]", orientation="vertical")
mlab.outline(c)
mlab.axes(xlabel=labels[contaminants[0]], ylabel=labels[contaminants[1]], zlabel=labels[contaminants[2]])
mlab.view(0.0, 0.0)
#mlab.pitch(float(sys.argv[2]))
#mlab.roll(float(sys.argv[3]))
#mlab.yaw(float(sys.argv[4]))
# own axes
x = np.linspace(0.0, np.max(X1))
x_z = np.zeros_like(x)
mlab.plot3d(x, x_z, x_z, line_width=0.01,tube_radius=0.001)
mlab.plot3d(x_z, x, x_z, line_width=0.01,tube_radius=0.001)
mlab.plot3d(x_z, x_z, x, line_width=0.01,tube_radius=0.001)
mlab.text3d(np.max(X1) * 1.05, 0.0, 0.0, contaminants[0], color=(0, 0, 0), scale=0.025)
mlab.text3d(0.0, np.max(X1) * 1.05, 0.0, contaminants[1], color=(0, 0, 0), scale=0.025)
mlab.text3d(0.0, 0.0, np.max(X1) * 1.05, contaminants[2], color=(0, 0, 0), scale=0.025)
mlab.show()
