%% Steady State Conduction Computer Assignment 2

%{
    Consider a rectangular plate 20 cm x 30 cm. 
    Three of the sides (left, bottom, and right side) are maintained are at
    a constant temperature of 25 C whereas the top side is maintained at 75 C. 
    Write a general computer program to solve for the steady state 
    temperature solution of the plate for any grid arbitrary grid mesh n x m. 
    Obtain a temperature solution using a grid mesh of 10x10, 20x20, and 30x30. 
    Compare in terms of percent error the three numerical solutions to the 
    closed form solution at the following five points (W and H represent the 
    width and height of the plate).

    (a)	W/4, H/4
    (b)	3W/4, H/4
    (c)	W/2, H/2
    (d)	W/4, 3H/4
    (e)	3W/4, 3H/4

    Answer the following questions:
    1)	Explain why the number of iterations required for convergence increases as the grid mesh size decreases. 
    2)	Discuss the solution accuracy relative to the closed form solution and how the solution accuracy varies as the grid mesh size decreases.

%}

clc
clear all

% Initial Conditions of Plate
W = 20.0; H = 30.0; T1 = 25; T2 = 75; i = 1;

% Points to monitor
Points = [W/4, H/4; 3*W/4, H/4; W/2, H/2; W/4, 3*H/4; 3*W/4, 3*H/4];
PointTemp = [0, 0, 0, 0, 0];

% Create Heated Plate
Plate = HeatedPlate(W, H, T1, T2, Points);

while i <= length(Points(:,1))
    PointTemp(i) = heatSeperationVariables(Plate, i);
    i = i + 1;
end

PointTemp

% Run GaussSeidel
grid10 = heatGaussSeidel(Plate, 75, 25, 25, 25, 10, 10);
grid20 = heatGaussSeidel(Plate, 75, 25, 25, 25, 20, 20);
grid30 = heatGaussSeidel(Plate, 75, 25, 25, 25, 30, 30);


error10 = zeros(1,5);
error20 = zeros(1,5);
error30 = zeros(1,5);

%checkError for grid 10
interp = doubleinterpolate(7.5, 9, 6, 5, 4, 6, grid10(8,3), grid10(8,4), grid10(9,3), grid10(9,4));
error10(1) = errorcheck(PointTemp(1), interp);
interp = doubleinterpolate(7.5, 9, 6, 15, 14, 16, grid10(8,8), grid10(8,9), grid10(9,8), grid10(9,9));
error10(2) = errorcheck(PointTemp(2), interp);
error10(3) = errorcheck(PointTemp(3), grid10(6,6));
interp = doubleinterpolate(22.5, 24, 21, 5, 4, 6, grid10(3,3), grid10(3,4), grid10(4,3), grid10(4,4));
error10(4) = errorcheck(PointTemp(4), interp);
interp = doubleinterpolate(22.5, 24, 21, 15, 14, 16, grid10(3,8), grid10(3,9), grid10(4,8), grid10(4,9));
error10(5) = errorcheck(PointTemp(5), interp);

error10

%checkError for grid 20 
error20(1) = errorcheck(PointTemp(1), grid20(16,6));
error20(2) = errorcheck(PointTemp(2), grid20(16,16));
error20(3) = errorcheck(PointTemp(3), grid20(11,11));
error20(4) = errorcheck(PointTemp(4), grid20(6,6));
error20(5) = errorcheck(PointTemp(5), grid20(6,16));

error20

%checkError for grid 30
interp = doubleinterpolate(7.5, 8, 7, 5, 4.666, 5.333, grid30(23,8), grid30(23,9), grid30(24,8), grid30(24,9));
error30(1) = errorcheck(PointTemp(1), interp);
interp = doubleinterpolate(7.5, 8, 7, 15, 14.666, 15.333, grid30(23,23), grid30(23,24), grid30(24,23), grid30(24,24));
error30(2) = errorcheck(PointTemp(2), interp);
error30(3) = errorcheck(PointTemp(3), grid30(16,16));
interp = doubleinterpolate(22.5, 23, 22, 5, 4.666, 5.333, grid30(8,8), grid30(8,9), grid30(9,8), grid30(9,9));
error30(4) = errorcheck(PointTemp(4), interp);
interp = doubleinterpolate(22.5, 23, 22, 15, 14.666, 15.333, grid30(8,23), grid30(8,24), grid30(9,23), grid30(9,24));
error30(5) = errorcheck(PointTemp(5), interp);

error30