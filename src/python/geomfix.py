
import pandas as pd
import numpy as np
from pathlib import Path

import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt

# -- File Setup ----------------------------------------------------------

path_test_data = Path("/project/src/python/example_data/multipolygon.csv")
pdf_multipolygon = pd.read_csv(path_test_data)

# -- Data Setup ----------------------------------------------------------

# poly selection
pdf_poly = pdf_multipolygon[pdf_multipolygon["polygon"] == 3]

x_values = np.array(pdf_poly["x"])#[:-1]
y_values = np.array(pdf_poly["y"])#[:-1]

points = np.stack((x_values, y_values), axis=1)


# -- Filtering -----------------------------------------------------------
def curvature_filter(points: np.ndarray):
  # computing discrete 2nd order derivative 
  filterKernel = [1, -2, 1]

  points_lead = np.roll(points, -1, axis=0)
  points_lag  = np.roll(points, 1, axis=0)

  d2_vect = (
      filterKernel[0] * points_lead
    + filterKernel[1] * points
    + filterKernel[2] * points_lag
  )

  d2_norm = np.linalg.norm(d2_vect, axis=1)

  poly_lines = points_lead - points
  poly_lines_norm = np.linalg.norm(poly_lines, axis=1)
  local_line_length = poly_lines_norm + np.roll(poly_lines_norm, 1)

  local_line_length += 1

  d2_norm_scaled = d2_norm / local_line_length**3

  return d2_vect, d2_norm_scaled
d2_vect, d2_norm_scaled = curvature_filter(points)

def dot_product_filter(points: np.ndarray):
  """ Returns the dot product between normalized """
  points_lead = np.roll(points, -1, axis=0)

  poly_vects = points_lead - points
  poly_vects_lengths = np.linalg.norm(poly_vects, axis=1)
  poly_vects_normalized = poly_vects / poly_vects_lengths[:, np.newaxis]

  # dot product vectorized
  vects_lag = np.roll(poly_vects_normalized, 1, axis=0)
  dot_product = (
    (vects_lag * poly_vects_normalized).sum(axis=1)
  )
  return dot_product
dot_product = dot_product_filter(points)


# -- Identify Verteces to Remove -----------------------------------------
dot_product_threshold = -0.995

problem_indexes, = np.where(dot_product <= dot_product_threshold) 



# -- Plotting ------------------------------------------------------------

quiver_scaling = 5


# Set up figure and axes
fig = plt.figure()
ax = fig.add_subplot(111)

# Plot Polygon and curvature
p = ax.plot(
  x_values, y_values, 
  'o-',
  markersize=4,
  zorder=0
)
q = ax.quiver(
  x_values, y_values,
  d2_vect[:,0], d2_vect[:,1],
  angles='xy',
  scale_units='xy',
  scale=quiver_scaling,
  zorder=1
)
s = ax.scatter(
  x_values[problem_indexes], y_values[problem_indexes],
  c='red',
  s=6,
  zorder=2
)

for i, (x, y) in enumerate(points):
  ax.annotate(
    str(i),
    (x, y),
    xytext=(3,3),
    textcoords="offset points",
    fontsize=8
  )


# plot measure
fig2 = plt.figure()
ax2 = fig2.add_subplot(111)
p2 = ax2.plot(dot_product)
h2 = ax2.hlines(
  y=dot_product_threshold,
  xmin=0,
  xmax=len(dot_product),
  colors='black',
  linestyles='dashed'
)


plt.show()
