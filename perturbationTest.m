clc
clear all
close all


% Import the selected topology
topologyMultiTest6

% Number of time steps
Tmax = 2000;

% Length of each timestep
T = 0.01;

% Set the capacity on the edges
aafFmax = 5*ones(M, Tmax);
%aafFmax(4, :) = ones(1, Tmax);

% Total inflow
afLambda0 =   1*ones(nof, Tmax); 
afLambda0(1,1:Tmax) = 0.1;
% Stop one flow after some time
% afLambda0(1, 1000:2000) = 0;

% No thresholds
afThreholdRho = Inf*rand(M,1); 

% Routing policy (Should really block some...)
fBetaRouting            = ceil(10*rand(M,nof));     

% fBetaRouting = [     1     2
%      9     7
%     10     5
%      8     8
%      1     8
%      3    10
%      4     9
%      7     4
%      2     7
%      8     2]


% Mu (CHANGE)
etaMu                   = 2*ones(M,1);

% Initial condition, just set all to zero and to generic
afInitialConditionRho = zeros(nof, M);
afInitialConditionRho1 = 2*rand(nof, M);
afInitialConditionRho1(2,10) = 0;
afInitialConditionRho1(2,7) = 0;
afInitialConditionRho1(1,3) = 0;
afInitialConditionRho1(1,9) = 0;

% Don't use any traffic lights
bFlagUseTrafficLights   = 0;  


for i=0:0.1:1
afLambda0(1,1:Tmax) = i;
%
[aafRho, aafFlow, aaafG, aafChange, afDischarge]         = SimulateMulticommodityNetwork(                   ...
                                                            A, aafFmax, afLambda0, afThreholdRho, T, Tmax,         ...
                                                            afInitialConditionRho, fAlphaRouting,                 ...
                                                            fBetaRouting, etaMu, nof, originNodes, destNodes, bFlagUseTrafficLights);
% aafRho1 = aafRho; aafFlow1 = aafFlow; aaafG1 = aaafG; aafChange1 = aafChange; afDischarge1 = afDischarge;
% 
% [aafRho1, aafFlow1, aaafG1, aafChange1, afDischarge1]         = SimulateMulticommodityNetwork(                   ...
%                                                             A, aafFmax, afLambda0, afThreholdRho, T, Tmax,         ...
%                                                             afInitialConditionRho1, fAlphaRouting,                 ...
%                                                             fBetaRouting, etaMu, nof, originNodes, destNodes, bFlagUseTrafficLights);
%%
% close all
% figure
% for iEdge = 1:M
%     subplot(floor(M/2)+1, 2, iEdge)
%     hold on
%     plot(squeeze(aafRho(1, iEdge, :)),'b')
%     plot(squeeze(aafRho(2, iEdge, :)),'g')
% %     plot(squeeze(aafRho1(1, iEdge, :)),':b')
% %     plot(squeeze(aafRho1(2, iEdge, :)),':g')
%     title(['Rho ', num2str(iEdge)])
% end
% figure
% for iEdge = 1:M
%     subplot(floor(M/2)+1, 2, iEdge)
%     hold on
%     plot(squeeze(aafFlow(1, iEdge, :)),'b')
%     plot(squeeze(aafFlow(2, iEdge, :)),'g')
%     % plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'y')
%     plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'r')
% %     plot(squeeze(aafFlow1(1, iEdge, :)),':b')
% %     plot(squeeze(aafFlow1(2, iEdge, :)),':g')
%     title(['Flow ', num2str(iEdge)])
% end

hold on
iEdge = 9;

    plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'r')
  title(['Flow ' num2str(iEdge)])
end