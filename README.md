# An ellipsometry spectropy data analysis project for isotropic materials
This is a multi-parameter fitting program to convert the ellipsometry raw data, ψ and Δ, to the optical function n and k, as well as film thickness. The fitting procedure is based on the built-in simulated annealing function in MATLAB.
## Environment Requirements
+ Matlab 2019
## A brief introduction to the source codes
+ The fresnel equations are divided into four files, including 's_reflection.m', 's_refraction.m', etc..
+ Based on fresnel equations, transfer matrix of the material can be setup by 'transfer matrix.m' and 'fresnel.m'.
+ 'error_func.m' is based on the description in ref.1, giving the loss function for fitting procedure.
+ 'parameters.m' gives the main parameters need to be set before fitting.
+ 'drude.m', 'sellmeier.m' is the code to describe two widely used model for isotropic material, see ref.2.
+ 'main.m' is the file needs to be executed based on all the files mentioned above.
