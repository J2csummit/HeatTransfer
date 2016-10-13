function [ error ] = errorcheck( e1, et )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    error = (abs(e1 - et) / e1) * 100;

end

