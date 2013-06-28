clc
clear all
close all


% Import the selected topology
topologyPartialSplit
% Number of time steps
Tmax = 1000;

% Length of each timestep
T = 0.01;

% Set the capacity on the edges
aafFmax = 2*ones(M, Tmax);

%aafFmax(2, :) = 2;
%aafFmax(3,1:1499) = 1.1;
%aafFmax(3,1500:end) = 1;
% aafFmax(3,1500:end) = 1;



% aafFmax(4,:) = 3;
% aafFmax(3,:) = 3;
% aafFmax(6,:) = 10;
% aafFmax(7,:) = 10;
% aafFmax(8,:) = 10;
% Allow higher capacity on the draining links
%aafFmax(2, :) = 1*ones(1, Tmax);
%aafFmax(8, :) = 1*ones(1, Tmax);




% Total inflow
afLambda0 =   1*ones(nof, Tmax); 
afLambda0(1,:) = 1;
afLambda0(2,:) = 2;


%afLambda0(:, 1500:end) = 1.01;


%fLambda0(1,:) = 5;
% afLambda0(2,:) = 1.8;
%afLambda0(1,1001:end) =0;
% Stop one flow after some time
% afLambda0(1, 1000:2000) = 0;

% No thresholds
afThreholdRho = Inf*rand(M,1);

% Routing policy 
 fBetaRouting = [
      3    7
      8    2];
etaMu = [2;5];
 
 
afInitialConditionRho =  1 * zeros(nof, M);

% afInitialConditionRho = [
%     0.2691    0.5479    0.4177    0.3015    0.6663    0.6981    0.1781    0.9991  0.0326    0.8819
%     0.4228    0.9427    0.9831    0.7011    0.5391    0.6665    0.1280    0.1711  0.5612    0.6692 ];
   
   
afInitialConditionRho1 = 1*rand(nof, M);
% (flow edge)
afInitialConditionRho1(1,1) = 1.5;
afInitialConditionRho1(2,1) = 0.5;

afInitialConditionRho1(1,2) = 0.5;
afInitialConditionRho1(2,2) = 1;

% afInitialConditionRho1 = [
%         0.1904    0.4607    0.1564    0.6448    0.1909    0.4820    0.5895    0.3846    0.2518    0.6171
%     0.3689    0.9816    0.8555    0.3763    0.4283    0.1206    0.2262    0.5830    0.2904    0.2653];
% 
% 
% afInitialConditionRho1 = [
%     0.2691    0.5479    0.4177    0.3015    0.6663    0.6981    0.1781    0.9991  0.0326    0.8819
%     0.4228    0.9427    0.9831    0.7011    0.5391    0.6665    0.1280    0.1711  0.5612    0.6692 ];
% afInitialConditionRho1 =[
%     0.5822    0.8699    0.3181    0.9398    0.4795    0.5447    0.5439    0.5225    0.2187    0.1097
%     0.5407    0.2648    0.1192    0.6456    0.6393    0.6473    0.7210    0.9937    0.1058    0.0636]


% ComputeMu(afInitialConditionRho1, afThreholdRho, aafFmax(:, 1), etaMu, nof)
% afInitialConditionRho1(1,7) = 0;
% afInitialConditionRho1(2,4) = 0;
% afInitialConditionRho1(1,2) = 0;
% afInitialConditionRho1(2,8) = 0;
% afInitialConditionRho1(1,6) = 0;
% afInitialConditionRho1(1,5) = 0;
% afInitialConditionRho1(1,7) = 0;

% Don't use any traffic lights
bFlagUseTrafficLights   = 0; 

%
[aafRho, aafFlow, aaafG, aafChange, afDischarge]         = SimulateMulticommodityNetwork(                   ...
                                                            A, aafFmax, afLambda0, afThreholdRho, T, Tmax,         ...
                                                            afInitialConditionRho, fAlphaRouting,                 ...
                                                            fBetaRouting, etaMu, nof, originNodes, destNodes, bFlagUseTrafficLights);
% aafRho1 = aafRho; aafFlow1 = aafFlow; aaafG1 = aaafG; aafChange1 = aafChange; afDischarge1 = afDischarge;
% 
 [aafRho1, aafFlow1, aaafG1, aafChange1, afDischarge1]         = SimulateMulticommodityNetwork(                   ...
                                                             A, aafFmax, afLambda0, afThreholdRho, T, Tmax,         ...
                                                             afInitialConditionRho1, fAlphaRouting,                 ...
                                                             fBetaRouting, etaMu, nof, originNodes, destNodes, bFlagUseTrafficLights);
%%
close all
figure
for iEdge = 1:M
    subplot(floor(M/2)+1, 2, iEdge)
    hold on
  plot(squeeze(aafRho(1, iEdge, :)),'b')
    plot(squeeze(aafRho(2, iEdge, :)),'r')
      plot(squeeze(aafRho1(1, iEdge, :)),':b')
     plot(squeeze(aafRho1(2, iEdge, :)),':r')
    title(['Rho ', num2str(iEdge)])
%  
  
end
figure
for iEdge = 1:M
    subplot(floor(M/2)+1, 2, iEdge)
    hold on
    plot(squeeze(aafFlow(1, iEdge, :)),'b')

    plot(squeeze(aafFlow(2, iEdge, :)),'r')
    plot(squeeze(aafFlow1(1, iEdge, :)),':b')
  plot(squeeze(aafFlow1(2, iEdge, :)),':r')
   
end
%%
% Save the matrix
t = 1:1:1000;
t = t';

smatrix = [t squeeze(aafRho(1,1,:)) squeeze(aafRho(1,2,:)) squeeze(aafRho(2,1,:)) squeeze(aafRho(2,2,:)) squeeze(aafRho1(1,1,:)) squeeze(aafRho1(1,2,:)) squeeze(aafRho1(2,1,:)) squeeze(aafRho1(2,2,:))]

save rho.dat smatrix -ascii 


smatrix = [t squeeze(aafFlow(1,1,:)) squeeze(aafFlow(1,2,:)) squeeze(aafFlow(2,1,:)) squeeze(aafFlow(2,2,:)) squeeze(aafFlow1(1,1,:)) squeeze(aafFlow1(1,2,:)) squeeze(aafFlow1(2,1,:)) squeeze(aafFlow1(2,2,:))]

save flow.dat smatrix -ascii 
