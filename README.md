# optimal-dart-throwing
A MATLAB program that recommends a personalized aiming spot for maximum expected number of points achieved (in Czech)

Based on the user-provided training set of dart throw locations, the program builds a Gaussian model of the player and through a convolution with the discretized target, it finds and recommends an aiming spot with maximum possible point value.

The four available datasets are either artifically generated or they were created during the highschool project (SOČ) of Pavlína Jelínková in 2025.

The main file to run is main.m.
