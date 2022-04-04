# DETECTING SPOTS AND SEGMENTING CELLS
The scripts present in this folder can be used to detect individual spots in the images generated and assign them to cells based on DAPI segmentation.
Please take as a reference the script *FindingSpots_50plexPanel_MAY.mlx*, used to segment spots and assign reads to cells. Variations of those scripts can be found under the name *FindingSpots_*

# COMPLEMENTARY FUNCTIONS
This repository incldues complementary functions that will be used by the main scripts these are:
  - FindSpots: based on an image and a threshold, identifies the spots and their position.
  - FindSignals: based on an image and a threshold, identifies areas above the threshold associated with the presence of signals (used in 10x only)
