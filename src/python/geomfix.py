
import pandas as pd
import numpy as np
from pathlib import Path

import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt

# -- File Setup ----------------------------------------------------------

path_test_data = Path("/project/src/python/example_data/multipolygon.csv")
pdf_multipolygon = pd.read_csv(path_test_data)

# -- Data Setup


# poly selection
pdf_poly = pdf_multipolygon[pdf_multipolygon["polygon"] == 1]

x_values = np.array(pdf_poly["x"])
y_values = np.array(pdf_poly["y"])

points = np.stack((x_values, y_values), axis=1)

# -- Filtering ...--------------------------------------------------------
filterKernel = [1, -2, 1]



# 2nd derivative =
d2_vect = (
  np.roll(points, 1) * filterKernel[0]
  + points * filterKernel[1]
  + np.roll(points, -1) * filterKernel[2]
)


d2_norm = np.linalg.norm(d2_vect, axis=1)

# -- Plotting ------------------------------------------------------------

plt.figure()
plt.plot(d2_norm)
plt.show()


dummy = 1