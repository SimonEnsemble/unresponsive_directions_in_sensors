from mayavi import mlab
import numpy as np

def V(x, y, z):
    """ A 3D sinusoidal lattice with a parabolic confinement. """
    return 2*(x**2 + y**2 + z**2)


X, Y, Z = np.mgrid[-2:2:100j, -2:2:100j, -2:2:100j]
mlab.figure(bgcolor=(1.0, 1.0, 1.0), fgcolor=(0.0, 0.0, 0.0))
mlab.quiver3d(0, 0, 0, 1, 1, 1, color=(0.0, 0.0, 0.0), line_width=10, mode="arrow")
mlab.text(1.2, 1.2, "$v_1$", z=1.2)
mlab.contour3d(X, Y, Z, V, colormap="viridis", opacity=0.3, contours=8, vmin=0.0)
mlab.axes(xlabel="x", ylabel="y", zlabel="z")
mlab.colorbar(title="m [g/g]", orientation="vertical")
mlab.show()
