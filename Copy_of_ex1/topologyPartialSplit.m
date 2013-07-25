% Simple example in which the interaction is "strong" - class 2 fills an
% edge, which "disappears" from network of class 1
nof = 1; % The number of flows
originNodes = zeros(nof, 1);
destNodes = zeros(nof, 1);

% Flow 1 starts at node 1 and ends at node 3
originNodes(1) = 1;
destNodes(1) = 2;

M = 1; N = 2;
%A = zeros(M,N);
A(1,1)      = 1;    A(1,2)      = -1;
%A(2,1)      = 1;    A(2,3)      = -1;


% Maybe we look at this plot later
% gplot(A,[0 2; 0 0; 1 1; 2 1; 3 2; 3 0])

% fAlphaRouting, just to ban some routes
fAlphaRouting = ones(M, nof);
%fAlphaRouting(1,2) = 0;
%fAlphaRouting(3,1) = 0;
% fAlphaRouting(5,1) = 0;