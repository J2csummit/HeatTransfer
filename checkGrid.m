function [ dTmax ] = checkGrid( prevGrid, nextGrid, N, M )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    dTmax = 0;
    for i = 2:(N+1)
        for j = 2:(M+1)
            dTinstant = abs(prevGrid(i, j) - nextGrid(i, j));
            if dTinstant > dTmax
                dTmax = dTinstant;
            end
        end
    end

end

