% A very simple example on multicommodity
% Not sure if we are going to use all the settings below
nof = 2; % The number of flows
originNodes = zeros(nof, 1);
destNodes = zeros(nof, 1);

% Flow 1 starts at node 1 and ends at node 6
originNodes(1) = 1;
destNodes(1) = 8;

% Flow 2 starts at node 2 and ends at node 5
originNodes(2) = 2;
destNodes(2) = 6;

M = 12; N = 8;
A = zeros(M,N);
A(1,1)      = 1;    A(1,3)      = -1;
A(2,1)      = 1;    A(2,4)      = -1;
A(3,2)      = 1;    A(3,4)      = -1;
A(4,2)      = 1;    A(4,5)      = -1;
A(5,5)      = 1;    A(5,4)      = -1;
A(6,3)      = 1;    A(6,6)      = -1;
A(7,3)      = 1;    A(7,7)      = -1;
A(8,4)      = 1;    A(8,7)      = -1;
A(9,5)      = 1;    A(9,7)      = -1;
A(10,5)      = 1;    A(10,8)      = -1;
A(11,7)      = 1;    A(11,6)      = -1;
A(12,7)      = 1;    A(12,8)      = -1;

% Maybe we look at this plot later
% gplot(A,[0 2; 0 0; 1 1; 2 1; 3 2; 3 0])

% fAlphaRouting, just to ban some routes
fAlphaRouting = ones(M, nof);
fAlphaRouting(6, 1) = 0;
fAlphaRouting(11, 1) = 0;

fAlphaRouting(10, 2) = 0;
fAlphaRouting(12, 2) = 0;
