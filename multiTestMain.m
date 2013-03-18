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
%afLambda0(1,1001:end) =0;
% Stop one flow after some time
% afLambda0(1, 1000:2000) = 0;

% No thresholds
afThreholdRho = Inf*rand(M,1); 

% Routing policy (Should really block somComputeMu(afOldRho, afThreholdRho, aafFmax(:, t), etaMu, nof);e...)
fBetaRouting            = ceil(10*rand(M,nof));     
% 
% fBetaRouting = [     1     2
%      9     7
%     10     5
%      8     8
%      1     8
%      3    10
%      4     9
%      7     4
%      2     7]
     %8     2]
% fBetaRouting = [ fBetaRouting(2,1) = 10;
fBetaRouting(5,1) = 1;

%      7     9
%      7     8
%      4     6
%      2     2
%      1    10
%      5     3squeeze(aafRho(1, iEdge, :))
%      2    10
%      8     3
%      4     4];
 

% Flow 1
fBetaRouting(2,1) = 1;
fBetaRouting(5,1) = 10;
% squeeze(aafRho(1, iEdge, :))
fBetaRouting(2,2) = 10;
fBetaRouting(5,2) = 1;

 %fBetaRouting            = ones(M,nof);     


% Mu (CHANGE)
etaMu                   = 10*ones(M,1);
%etaMu(6) = 1;

% Initial condition, just set all to zero and to generic
afInitialConditionRho = zeros(nof, M);
afInitialConditionRho1 = 2*rand(nof, M);
afInitialConditionRho1(2,10) = 0;
afInitialConditionRho1(2,7) = 0;
afInitialConditionRho1(1,3) = 0;
afInitialConditionRho1(1,9) = 0;

% Don't use any traffic lights
bFlagUseTrafficLights   = 0;  

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
close all
figure
for iEdge = 1:M
    subplot(floor(M/2)+1, 2, iEdge)
    hold on
    plot(squeeze(aafRho(1, iEdge, :)),'b')
    plot(squeeze(aafRho(2, iEdge, :)),'g')
%     plot(squeeze(aafRho1(1, iEdge, :)),':b')
%     plot(squeeze(aafRho1(2, iEdge, :)),':g')
    title(['Rho ', num2str(iEdge)])
end
figure
for iEdge = 1:M
    subplot(floor(M/2)+1, 2, iEdge)
    hold on
    plot(squeeze(aafFlow(1, iEdge, :)),'b')
    plot(squeeze(aafFlow(2, iEdge, :)),'g')
    % plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'y')
 %   plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'r')
%     plot(squeeze(aafFlow1(1, iEdge, :)),':b')
%     plot(squeeze(aafFlow1(2, iEdge, :)),':g')
    title(['Flow ', num2str(iEdge)])
end
%%
figure
for iEdge = 1:M
    subplot(floor(M/2)+1, 2, iEdge)
    hold on
    plot((squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)))./(squeeze(aafRho(1, iEdge, :)) + squeeze(aafRho(2, iEdge, :))),'b')
     % plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'y')
 %   plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'r')
%     plot(squeeze(aafFlow1(1, iEdge, :)),':b')
%     plot(squeeze(aafFlow1(2, iEdge, :)),':g')
    title(['Vel ', num2str(iEdge)])
end
%%
% figure
% hold on
% title('G 4->2 4->5(.)')
figure
hold on

 plot(diff(squeeze(aafRho(1, 2, :)) + squeeze(aafFlow(2, 2, :))),'b')
 plot(diff(squeeze(aafFlow(1, 6 , :))),'r')
% plot(squeeze(aaafG(2, 2, 4, :)),'g')    
% 
% plot(squeeze(aaafG(1, 5, 4, :)),':b')
% plot(squeeze(aaafG(2, 5, 4, :)),':g')    
%%



figure
iEdge = 5;

    plot(squeeze(aafRho(1, iEdge, :)) + squeeze(aafRho(2, iEdge, :)),'r')
  title(['Flow ' num2str(iEdge)])