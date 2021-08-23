# unresponsive directions in gas sensor arrays

data and Python code to reproduce all plots in:

> N. Gantzler, A. Henle, P. Thallapally, X. Fern, C. Simon. "Non-injective gas sensor arrays: identifying undetectable composition changes." Journal of Condensed Matter: Physics. (2021). [link](https://iopscience.iop.org/article/10.1088/1361-648X/ac1e49). [preprint](https://chemrxiv.org/engage/chemrxiv/article-details/6116b1054cb479355b2e6f34).

* `data`: contains experimentally measured gas adsorption isotherms in Co-MOF-74 and HKUST-1 as well as bulk gas density to convert from excess to absolute adsorption. sources of the data in header of file as a comment.
* `IAST.jl`: main Jupyter Notebook to reproduce plots in the article.
* `mayavi_viz.py`: run this to generate 3D plots after `IAST.jl` runs. it reads in data saved to file from `IAST.jl`. run as `python mayavi_viz.py HKUST-1`.
