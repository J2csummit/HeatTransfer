classdef HeatedPlate
    %HeatedPlate Creates a heated plate with dimensions, temperatures, and
    %points
    %   Object is a heated plate that has width and height dimensions,
    %   high and low temperatures for a temperature distribution, and
    %   points on the plate at which temperatures can be determined.
    %   Points inserted into object must be in the form of...
    %       [x1, y1; x2, y2;...xn, yn]
    
    properties
        Points
        Width
        Height
        T1
        T2
    end
    
    methods
        
        function obj = HeatedPlate(width, height, t1, t2, pointArray)
            check = obj.checkPointArray(pointArray);
            if check > 0.0
                obj.Points = pointArray;
            else
                obj.Points = [0,0; width/2, height/2; width, height];
            end
            obj.Width = width; obj.Height = height; obj.T1 = t1; obj.T2 = t2;
        end
        
        function properArray = checkPointArray(obj, points)
        %checkPointArray
        %   Function that checks if the array that designates points on the
        %   heated plate is in the proper format
            sz = size(points);
            if length(sz) == 2 && sz(end) == 2;
                properArray = 1.0;
            else
                properArray = 0.0;
                disp('Inserted array of points is not in proper format')
            end
        end
        
        function addPoints(obj, pointArray)
        %addPoints
        %   Function that adds new points on plate at which to obtain the
        %   exact temperature
            if obj.checkPointArray(pointArray) > 0.0
                obj.Points = cat(2, obj.Points, pointArray);
            end
        end
        
        function newPoints(obj, pointArray)
        %newPoints
        %   Function that sets new points on plate at which to obtain the
        %   exact temperature
            if obj.checkPointArray(pointArray) > 0.0
                obj.Points = pointArray;
            end
        end
        
        function newDimensions(obj, width, height)
        %newDimensions
        %   Function that sets new dimensions of plate
            obj.Width = width; obj.Height = height;
        end
        
        function newTemperatures(obj, t1, t2)
        %newTemperatures 
        %   Function that sets new high and low temperatures
        %   of plate, hence creating a new temperature gradient
            obj.T1 = t1; obj.T2 = t2;
        end
        
        function [ T, tVn, termCount, terms  ] = heatSeperationVariables( obj, pointNumber )
        %heatSeperationVariables
        %   Function takes in a point and calculates the temperature at that
        %   specific point on a heated plate via an infinite series equation. This
        %   equation has a limited amount of applicable terms until the equation no
        %   longer needs more terms
        
            % Get all plate properties initialized for calculative purposes
            x = obj.Points(pointNumber, 1); y = obj.Points(pointNumber, 2);
            t1 = obj.T1; t2 = obj.T2;
            
            % In the book L is positive x-coordinate
            W = obj.Height; L = obj.Width;
            
            % Initialize condiditions for ending infinite series and
            % create array to store all terms of said series and
            % temperature values as a function of n iterations
            resolution = 0.001; dT = t2 - t1; terms = zeros(0); tVn = zeros(0); n = 1;
            
            % Obtain all terms of infinite series. End the series when
            % resolution condition is met. Only need odd terms because even
            % terms turn out to be 0.
            while dT >= resolution
                terms(end+1) = ((((-1)^(n+1))+1)/n)*sin((n*pi*x)/L)*((sinh((n*pi*y)/L))/(sinh((n*pi*W)/L)));
                tVn(end+1) = ((2/pi)*sum(terms))*(t2-t1)+t1;
                if n > 1
                    dT = abs(tVn(end) - tVn(end-1));
                end
                n = n + 2;
            end
            
            % Get the final temperature and number of non-zero terms
            T = ((2/pi)*sum(terms))*(t2-t1)+t1;
            termCount = length(terms);
            
            sprintf('The temperature (Celsius) at the point %f, %f on the plate is:', x, y)
            disp(T)
            disp('The number of non-zero terms required to achieve an accuracy of 10^-3 with the solution is:')
            disp(termCount)
            disp('The values of the terms are:')
            disp(terms)
            figure
            %%plot(tVn)
        end
        
        function [ T, tVn, termCount, terms  ] = heatGaussSeidel( obj, Ttop, Tleft, Tbottom, Tright, n, m )
        %headGaussSeidel
        %   Function takes in initial temperature condidtions for the sides
        %   of the plate and iterates through every point in the plate
        %   (treats plates as a grid with individual coordinates) to
        %   caluclate temperature at all those points     
            
            N = n - 2; M = m - 2;
            
            % Initialize Boundary Conditions
            tTop = ones(1,N) * Ttop; %tTop = horzcat(zeros(1,1), tTop); tTop(end+1) = 0;
            tLeft = ones(M,1) * Tleft; tLeft = vertcat(zeros(1,1), tLeft); %tLeft(end+1) = 0;
            tRight = ones(M,1) * Tright; tRight = vertcat(zeros(1,1), tRight); %tRight(end+1) = 0;
            tBottom = ones(1,N) * Tbottom; tBottom = horzcat(zeros(1,1), tBottom); tBottom(end+1) = 0;
            
            % Make grid of zeros
            grid = zeros(N,M);
            grid = vertcat(tTop, grid);
            grid = horzcat(tLeft, grid);
            grid = horzcat(grid, tRight);
            grid = vertcat(grid, tBottom);
            
            %GaussSeidel
            resolution = 0.01; dT = 1; iteration = 1;
            while dT >= resolution
                iteration;
                prevGrid = grid;
                nextGrid = grid;
                for i = 2:(N+1)
                    for j = 2:(M+1)
                        grid(i,j) = GaussSeidel(grid, i, j);
                    end
                end
                dT = checkGrid(prevGrid, grid, N, M);
                %grid = nextGrid;
                iteration = iteration + 1;
            end
            grid
            iteration
            contour(grid)
        end
        
    end
    
end

