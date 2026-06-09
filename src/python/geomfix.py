
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
pdf_poly = pdf_multipolygon[pdf_multipolygon["polygon"] == 1]

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

  d2_norm_scaled = d2_norm / local_line_length**3

  return d2_vect, d2_norm_scaled

d2_vect, d2_norm_scaled = curvature_filter(points)

# -- Plotting ------------------------------------------------------------

quiver_scaling = 5

# Plot Polygon
fig = plt.figure()
ax = fig.add_subplot(111)
p = plt.plot(x_values, y_values, 'o-', markersize=2)
q = plt.quiver(
  x_values, y_values,
  d2_vect[:,0], d2_vect[:,1],
  angles='xy',
  scale_units='xy',
  scale=quiver_scaling
)

for i, (x, y) in enumerate(points):
  ax.annotate(
    "idx: " + str(i) + " " + str(np.round(local_line_length[i],2)), 
    (x, y),
    xytext=(3,3),
    textcoords="offset points",
    fontsize=8
  )


# curvature magnitude scaled down by local line lengths plot
plt.figure()
plt.plot(d2_norm_scaled)
plt.show()


dummy = 1