function [ q ] = heatSink( w, l )
%finnedPlate Automatically calculates heat transfer through heat sink
%   Caclulates the heat transfered through the heat sink given for the
%   design project. Inputs allow the heat sink to vary with fin width/gap
%   and with fin length.

W = w; S = 0.5; diff = (S - W);

% Get new S based on condition that (S-w)>= 0.25
if (diff < 0.2500)
    S = 0.25 + w;
end

ratio = W/S; % ratio will be used to determine fin area

% Convert dimensions into meters
S = S / 1000.0; W = W / 1000.0;

% Intialize all other values
Wc = 0.016; Tinf = 298; h = 1500; k = 400; Achip = Wc^2;
Lf = (l/1000.0); Lb = 0.003; Rtc = (5 * 10^-6); Tc = 358;

Lc = (W/4) + Lf; % Modified Length

Af = 4 * W * Lc; % Fin Area

% Cacluation of Fins per unit area
N = Wc/S;
% if the remainder of the amount of S per side is greater than the ratio of
% w to S, then there should be another fin on that side
Nflat = floor(N);
if ((N-Nflat) >= ratio)
    Nflat = Nflat + 1;
end
N = (Nflat^2);

Ab = ((Wc^2) - (N * (W^2))); % Area of Base

At = (N*Af) + Ab; % Total Area

m = sqrt(4*h/(k*W));

nf = tanh(m*Lc)/(m*Lc); % Fin Efficiency

no = 1 - (N*Af/At)*(1-nf); % Overall Efficiency

% Calculate heat tranfer (q)
dT = Tc - Tinf;

R1 = Rtc/Achip; R2 = Lb/(k*Achip); R3 = 1/(no*h*At); % Get Resistances

q = dT/(R1 + R2 + R3);

end