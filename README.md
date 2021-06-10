# unresponsive directions in gas sensor arrays

data and Python code to reproduce all plots in:

> N. Gantzler, A. Henle, P. Thallapally, X. Fern, C. Simon. "identifying gas composition changes to which non-injective gas sensor arrays are unresponsive"

* `data`: contains experimentally measured gas adsorption isotherms in Co-MOF-74 and HKUST-1 as well as bulk gas density to convert from excess to absolute adsorption. sources of the data in header of file as a comment.
* `IAST.jl`: main Jupyter Notebook to reproduce plots in the article.
* `mayavi_viz.py`: run this to generate 3D plots after `IAST.jl` runs. it reads in data saved to file from `IAST.jl`. run as `python mayavi_viz.py HKUST-1`.
