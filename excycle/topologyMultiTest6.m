% Simple example in which the interaction is "strong" - class 2 fills an
% edge, which "disappears" from network of class 1
nof = 2; % The number of flows
originNodes = zeros(nof, 1);
destNodes = zeros(nof, 1);

% Flow 1 starts at node 1 and ends at node 3
originNodes(1) = 1;
destNodes(1) = 6;

% Flow 2 starts at node 2 and ends at node 6
originNodes(2) = 4;
destNodes(2) = 3;

M = 8; N = 6;
A = zeros(M,N);
A(1,1)      = 1;    A(1,2)      = -1;
A(2,2)      = 1;    A(2,3)      = -1;
A(3,1)      = 1;    A(3,5)      = -1;
A(4,2)      = 1;    A(4,5)      = -1;
A(5,4)      = 1;    A(5,1)      = -1;
A(6,4)      = 1;    A(6,2)      = -1;
A(7,5)      = 1;    A(7,4)      = -1;
A(8,5)      = 1;    A(8,6)      = -1;

% Maybe we look at this plot later
% gplot(A,[0 2; 0 0; 1 1; 2 1; 3 2; 3 0])

% fAlphaRouting, just to ban some routes
fAlphaRouting = ones(M, nof);
fAlphaRouting(4,2) = 0;
fAlphaRouting(7,1) = 0;
fAlphaRouting(2,1) = 0;
fAlphaRouting(8,2) = 0;
% fAlphaRouting(5,1) = 0;