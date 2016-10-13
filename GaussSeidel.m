function [ T ] = GaussSeidel( grid, i, j )

T = ( 4*grid(i+1,j) + 4*grid(i-1,j) + 9*grid(i,j+1) + 9*grid(i,j-1) ) / 26;
%T = ( grid(i+1,j) + grid(i-1,j) + grid(i,j+1) + grid(i,j-1) ) / 4;

end

