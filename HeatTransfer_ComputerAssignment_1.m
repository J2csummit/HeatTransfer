%% Steady State Conduction - Closed Form Solution

%{
    Consider a rectangular plate 20 cm x 30 cm. 
    Three of the sides (left, bottom, and right side) are maintained are at a constant temperature of 25 ?C whereas the top side is maintained at 75 ?C. 
    Write a simple computer program to calculate the closed form solution at the following five points: 
    (a)	W/4, H/4
    (b)	3W/4, H/4
    (c)	W/2, H/2
    (d)	W/4, 3H/4
    (e)	3W/4, 3H/4
    Answer the following questions:
    1)	How many terms were required in the infinite series solution in order to achieve an accuracy of 10-3 ?C.
    2)	Plot Temperature vs Number of terms in infinite series solution considered.
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