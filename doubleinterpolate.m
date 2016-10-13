function [ C ] = doubleinterpolate( a, a1, a2, b, b1, b2, c11, c12, c21, c22 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
C = ( ((b2 - b)/(b2 - b1))*c11 + ((b - b1)/(b2-b1))*c12 )*((a2 - a)/(a2 - a1)) + ( ((b2 - b)/(b2 - b1))*c21 + ((b - b1)/(b2-b1))*c22 )*((a - a1)/(a2 - a1));

end

