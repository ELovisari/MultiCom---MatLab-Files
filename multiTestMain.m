clc
clear all
close all


% Import the selected topology
topologyMultiTest4

% Number of time steps
Tmax = 4000;

% Length of each timestep
T = 0.01;

% Set the capacity on the edges
aafFmax = 3*ones(M, Tmax);
aafFmax(4, :) = ones(1, Tmax);

% Total inflow
afLambda0 =   1*ones(nof, Tmax);  
% Stop one flow after some time
% afLambda0(1, 1000:2000) = 0;

% No thresholds
afThreholdRho = Inf*rand(M,1); 

% Routing policy (Should really block some...)
fBetaRouting            = ceil(10*rand(M,nof));              

% Mu (CHANGE)
etaMu                   = 2*ones(M,1);

% Initial condition, just set all to zero and to generic
afInitialConditionRho = zeros(nof, M);
afInitialConditionRho1 = 2*rand(nof, M);

% Don't use any traffic lights
bFlagUseTrafficLights   = 1;  

%
[aafRho, aafFlow, aaafG, aafChange, afDischarge]         = SimulateMulticommodityNetwork(                   ...
                                                            A, aafFmax, afLambda0, afThreholdRho, T, Tmax,         ...
                                                            afInitialConditionRho, fAlphaRouting,                 ...
                                                            fBetaRouting, etaMu, nof, originNodes, destNodes);
aafRho1 = aafRho; aafFlow1 = aafFlow; aaafG1 = aaafG; aafChange1 = aafChange; afDischarge1 = afDischarge;
%
% [aafRho1, aafFlow1, aaafG1, aafChange1, afDischarge1]         = SimulateMulticommodityNetwork(                   ...
%                                                             A, aafFmax, afLambda0, afThreholdRho, T, Tmax,         ...
%                                                             afInitialConditionRho1, fAlphaRouting,                 ...
%                                                             fBetaRouting, etaMu, nof, originNodes, destNodes);
%%
close all
figure
for iEdge = 1:M
    subplot(floor(M/2)+1, 2, iEdge)
    hold on
    plot(squeeze(aafRho(1, iEdge, :)),'b')
    plot(squeeze(aafRho(2, iEdge, :)),'g')
    plot(squeeze(aafRho1(1, iEdge, :)),':b')
    plot(squeeze(aafRho1(2, iEdge, :)),':g')
    title(['Rho ', num2str(iEdge)])
end
figure
for iEdge = 1:M
    subplot(floor(M/2)+1, 2, iEdge)
    hold on
    plot(squeeze(aafFlow(1, iEdge, :)),'b')
    plot(squeeze(aafFlow(2, iEdge, :)),'g')
    plot(squeeze(aafFlow1(1, iEdge, :)),':b')
    plot(squeeze(aafFlow1(2, iEdge, :)),':g')
    title(['Flow ', num2str(iEdge)])
end