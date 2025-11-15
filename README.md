# Gradient-Based Quadrangle Corner Detection

This project implements a gradient-based method inspired by Canny approach to detect and refine quadrangle corner positions in an image or video.
The technique combines a theoretical gradient computed from a virtual synthetic quadrangle with a practical gradient extracted from the real image.
By comparing these two gradient fields, the method defines a criterion $C$ that is minimized to obtain precise corner localization.

The approach works for static images and can be extended to real-time tracking in video by iterating the optimization on successive frames.

# Method overview
## 1. Theoretical gradient
A virtual image is generated from the current corner positions.
A smoothed gradient is computed using a Gaussian kernel, providing clean theoretical edges aligned with the quadrangle geometry.

## 2. Practical gradient
The real cropped image is processed using the same gradient operator.
Although gradient directions may be opposite, the criterion only measure the alignement, making the method robust.

## 3. $M_{i,j}$ field construction
Along each quandrangle edge, a gris of sampling point is defined using parameters:
- U: points along segment length
- V: points across segment width
- p: proportion of segment considered
- L: spacing between rows

These points allow localized comparison of theoretical and practical gradient.

## 4. Corner optimization
For each iteration:
1. Identify the worst corner (highest $C$ criterion)
2. Generate a neighborhood of corner displacements
3. Recompute virtual image and theoretical gradient associated with the neighbour.
4. Accept the move if it reduces the global $C$ criterion.
5. Repeat until there are no neighbours to worst corner improving the $C$ criterion.

# Implementation
The code is written in **Matlab**. A more detailed report can be found in `Report/report.md`. It uses the following key scripts: 

|||
| :-- | :-- |
| **File**  | **Description**   |
| `compute_C_criterion.m`  | Compares practical and theoretical gradients directions |
| `compute_corners_from_image.m`  | Combines all steps for an image |
| `compute_corners_from_video.m`  | Combines all steps for a video |
| `compute_gradient.m`  | Computes gradient from a Canny-based approach |
| `compute_Mij_positions.m`  | Gives the Mij positions associated with input corner positions |
| `compute_virtual_image.m`  | Creates an image of 1 and 0 based on the input corner positions |
| `manual_corner_selection.m`  | Allows user to manually select the 4 corners from an input image |
| `show_gradient.m`  | Show gradient field at Mij positions on input image |
| `show_Mij.m`  | Show Mij positions on input image |

# Example results
See `Example/example.pdf` or `Example/example.md` for a full report (figures and code) 

<p align="center">
  <img src="Example/example_media/figure_6.png" width="45%">
&nbsp; &nbsp; &nbsp; &nbsp;
  <img src="Example/example_media/figure_7.png" width="45%">
</p>

