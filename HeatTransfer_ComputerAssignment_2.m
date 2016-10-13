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

% Create Heated Plate
Plate = HeatedPlate(W, H, T1, T2, Points);

while i <= length(Points(:,1))
    heatSeperationVariables(Plate, i);
    i = i + 1;
end

% Run GaussSeidel
heatGaussSeidel(Plate, 75, 25, 25, 25, 10, 10);
heatGaussSeidel(Plate, 75, 25, 25, 25, 20, 20);
heatGaussSeidel(Plate, 75, 25, 25, 25, 30, 30);


