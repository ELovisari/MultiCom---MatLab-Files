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
aafFmax = 2*ones(M, Tmax);



% Total inflow
afLambda0 =   1*ones(nof, Tmax); 

% No thresholds
afThreholdRho = Inf*rand(M,1);

% Routing policy 
fBetaRouting            = ceil(100*rand(M,nof)); 

%  fBetaRouting = [
%       5     1
%       1     4
%       6     6
%       5     7
%       7     5
%       7     9
%       7     8
%       1    10];



etaMu                   = ceil(10*rand(M,1)); 
% etaMu = 1*ones(M, 1);


%      7];
 
 
afInitialConditionRho =  1 * zeros(nof, M);

% afInitialConditionRho = [
%     0.2691    0.5479    0.4177    0.3015    0.6663    0.6981    0.1781    0.9991  0.0326    0.8819
%     0.4228    0.9427    0.9831    0.7011    0.5391    0.6665    0.1280    0.1711  0.5612    0.6692 ];
   
   
afInitialConditionRho1 = 1*rand(nof, M);


%afInitialConditionRho1 = [1 0 1 1 1 1 0 1
%                          1.5 1.5 1.5 0 1.5 1.5 1 0 ];

%afInitialConditionRho= afInitialConditionRho1;
% Don't use any traffic lights
bFlagUseTrafficLights   = 0; 

%
[aafRho, aafFlow, aaafG, aafChange, afDischarge]         = SimulateMulticommodityNetwork(                   ...
                                                            A, aafFmax, afLambda0, afThreholdRho, T, Tmax,         ...
                                                            afInitialConditionRho, fAlphaRouting,                 ...
                                                            fBetaRouting, etaMu, nof, originNodes, destNodes, bFlagUseTrafficLights);
aafRho1 = aafRho; aafFlow1 = aafFlow; aaafG1 = aaafG; aafChange1 = aafChange; afDischarge1 = afDischarge;

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
        plot(squeeze(aafRho(1, iEdge, :)) + squeeze(aafRho(2, iEdge, :)),'r')

     % plot(squeeze(aafRho1(1, iEdge, :)),':b')
     %plot(squeeze(aafRho1(2, iEdge, :)),':g')
    title(['Rho ', num2str(iEdge)])
%  
  
end
figure
for iEdge = 1:M
    subplot(floor(M/2)+1, 2, iEdge)
    hold on
    plot(squeeze(aafFlow(1, iEdge, :)),'b')

    plot(squeeze(aafFlow(2, iEdge, :)),'g')
    plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'r')
%    plot(squeeze(aafFlow1(1, iEdge, :)) + squeeze(aafFlow1(2, iEdge, :)),'r')
    plot(squeeze(aafFlow1(1, iEdge, :)),':b')
  plot(squeeze(aafFlow1(2, iEdge, :)),':g')
    title(['Flow ', num2str(iEdge)])

end

calcJacobi


% %%
% t = 1:1:1500;
% t = t';
% smatrix = [t]
% for iEdge = 1:M
%     smatrix = [smatrix squeeze(aafRho(1,iEdge,:)) squeeze(aafRho(2,iEdge,:))]
% end
% 
% save rho.dat smatrix -ascii 


