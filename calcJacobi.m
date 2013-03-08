% Calculate the jacobian for a given topology and densities

topologyMultiTest


rho = aafRho(:,:, end);
% Out velocity function
vel = @(x) (1-exp(-x))/(x); 
veldiff = @(x) (exp(-x)*x-(1-exp(-x)))/(x^2);



nos = M*nof;  % Number of states

jacobian = zeros(nos, nos);


% Loop through the 
for i = 1:M
    % The routing policy, needs to be calculated specific for every link
    % We need to modify this
    G = @(x) 1;
    Gdiff = @(x) 0;
    
    