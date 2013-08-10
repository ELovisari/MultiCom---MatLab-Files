clc
clear all
close all


% Import the selected topology
topologyPartialSplit
% Number of time steps
Tmax = 8000;

% Length of each timestep
T = 0.01;

pt = Tmax/2;
% Set the capacity on the edges
aafFmax = 1.5*ones(M, Tmax);

%aafFmax(2, :) = 2;
%aafFmax(3,1:1499) = 1.1;
aafFmax(2,pt:end) = 1.3;

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
afLambda0 =   1.35*ones(nof, Tmax); 
%afLambda0(2, 15000:end) = 1;


%fLambda0(1,:) = 5;
% afLambda0(2,:) = 1.8;
%afLambda0(1,1001:end) =0;
% Stop one flow after some time
% afLambda0(1, 1000:2000) = 0;

% No thresholds
afThreholdRho = Inf*rand(M,1);

% Routing policy 
fBetaRouting            = ceil(100*rand(M,nof)); 


fBetaRouting = [
    81    43
    15    92 ];

%This thing make strange things occur
fBetaRouting = [
    80    92
    0.1    100 ];

fBetaRouting = [
    23    70
    1    15 ];

fBetaRouting = [
    23    75
    1    15 ];


fBetaRouting = [
    15    4
    1    4 ];

% 
% fBetaRouting = [
%     50    100
%     1    5 ];


%
% Edge 1
% Change of flow 1: -0.00016625
% Change of flow 2: 0.011597
% Edge 2
% Change of flow 1: 0.00016625
% Change of flow 2: -0.011597


% fBetaRouting = [
%     100    1
%     1    100 ];



% fBetaRouting =[    77     9
%     64    78
%      9    91];
% Makes eq 32 fail
%fBetaRouting = [
%      1    10
%      7     1
%      4     5 ];


% fBetaRouting = [
%      5     1
%      1     4
%      6     6
%      5     7
%      7     5
%      7     9
%      7     8
%      1    10];

% 
% fBetaRouting = [     1     2
%      9     7% fBetaRouti% fBetaRouting = [
%      5     6
%     10     9untitled.png
%      1     9
%      4     8
%      6     4
%      1     5
%      8     8
%      6     2];

% fBetaRouting(5,1) = 1;
% % % squeeze(aafRho(1, iEdge, :))untitled.png
% fBetaRouting(2,2) = 2;
% fBetaRouting(5,2) = 9;

%     10     5
%      8     8
%      1     832
%      3 fBeta32Routing            = ones(M,nof);     
%   10
%      4     9
%      7     4
%      2     7]
     %8     2]
% fBetaRouting = [ fBetaRouting(2,1) = 10;
% fBetaRouting(5,1) = 1;

%      7     9
%      7     8
%      4     6
%      2     2
%      1    10
%      5     3squeeze(aafRho(1, iEdge, :))
%      2    10
%      8     3
%      4     4];
% 
% fBetaRouting =[
%      3     7
%      8     7
%      2     7
%      3    10
%      1     3
%      6     8
%      7     3
%      6     2
%      5     7
%      7     5];
%  

 
 
 % fBetaRouting(2,1) = 9;
% fBetaRouting(5,1) = 1;% fBetaRouting(2,1) = 90;
% fBetaRouting(5,1) = 1;
% % % squeeze(aafRho(1, iEdge, :))
% fBetaRouting(2,2) = 20;
% fBetaRouting(5,2) = 9;

% % % squeeze(aafRho(1, iEdge, :))
% fBetaRouting(2,2) = 2;
% fBetaRouting(5,2) = 9;


% Flow 1
% fBetaRouting(2,1) = 9;
% fBetaRouting(5,1) = 1;
% % % squeeze(aafRho(1, iEdge, :))
% fBetaRouting(2,2) = 2;
% fBetaRouting(5,2) = 9;
% fBetaRouting            = ones(M,nof);     
% 
% fBetaRouting = [
%      5     6
%     10     9
%      1     9
%      4     8
%      6     4
%      1     5
%      8     8
% %      6     2];
% 
% fBetaRouting = [ 9     1afInitialConditionRho1 =
%      5     4
%      5     6
%      9     5
%      1     7
%      2     7
%      2     3
%      4     5
%      9     1
%      9    10];

% Mu (CHANGE)
etaMu                   = ceil(10*rand(M,1)); 

etaMu = [  8
    100];



etaMu = [  6
    Inf];




etaMu = [14 ; 14];
% etaMu = [  20
%     20];
% etaMu = [6
%      2
%      9];
% etaMu = [
%      6
%      4
%      2
%      7
%      8
%      5
%      1
%      3];
%etaMu(6) = 1;
% etaMu = [    2
%      2
%      4
%      2
%      5
%      4
%     10
%     10
%      1
%      8];
% Initial condition, just set all to zero and to generic
% 
%  etaMu = [     5
%      7
%      8
%      4
%      7
%      5
%      9
%      9
%      3
%      7];
 
 
afInitialConditionRho =  1 * zeros(nof, M);

% afInitialConditionRho = [
%     0.2691    0.5479    0.4177    0.3015    0.6663    0.6981    0.1781    0.9991  0.0326    0.8819
%     0.4228    0.9427    0.9831    0.7011    0.5391    0.6665    0.1280    0.1711  0.5612    0.6692 ];
   
   
afInitialConditionRho1 = 1*rand(nof, M);
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
%       plot(squeeze(aafRho1(1, iEdge, :)),':b')
%      plot(squeeze(aafRho1(2, iEdge, :)),':g')
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
%     plot(squeeze(aafFlow1(1, iEdge, :)),':b')
%   plot(squeeze(aafFlow1(2, iEdge, :)),':g')
    title(['Flow ', num2str(iEdge)])
        disp(['Edge '  num2str(iEdge)]);
        %pt = 1500;
        disp(['Change of flow 1: ' num2str(aafFlow(1, iEdge, Tmax-3)- aafFlow(1, iEdge, pt-3))]);
        disp(['Change of flow 2: ' num2str(aafFlow(2, iEdge, Tmax-3)- aafFlow(2, iEdge, pt-3))]);
%         disp(['Change of flow 3: ' num2str(aafFlow(3, iEdge, Tmax-3)- aafFlow(3, iEdge, pt-3))]);
%         disp(['Change of flow 4: ' num2str(aafFlow(4, iEdge, Tmax-3)- aafFlow(4, iEdge, pt-3))]);
%         disp(['Change of flow 5: ' num2str(aafFlow(5, iEdge, Tmax-3)- aafFlow(5, iEdge, pt-3))]);

        disp(['Change of aggregate: ' num2str(aafFlow(1, iEdge, Tmax-3)- aafFlow(1, iEdge, pt-3) + aafFlow(2, iEdge, Tmax-3)- aafFlow(2, iEdge, pt-3))]);
end
%%
t = 1:1:Tmax;
t = t';
fil = 1:10:Tmax;
% smatrix = [t squeeze(aafRho(1,1,:)) squeeze(aafRho(2,1,:)) squeeze(aafRho(2,1,:)) squeeze(aafRho(2,2,:)) ]
% 
% save rho.dat smatrix -ascii 


smatrix = [t(fil) squeeze(aafFlow(1,1,fil)) squeeze(aafFlow(2,1,fil)) squeeze(aafFlow(1,2,fil)) squeeze(aafFlow(2,2,fil)) ]

save flow.dat smatrix -ascii 

% ComputeMu(afInitialConditionRho1, afThreholdRho, aafFmax, etaMu, nof)
%max(max(aafFlow(1, 8, :)) + squeeze(aafFlow(2, 8, :)))
% %%
% figure
% for iEdge = 1:M
%     subplot(floor(M/2)+1, 2, iEdge)
%     hold on
%     plot((squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)))./(squeeze(aafRho(1, iEdge, :)) + squeeze(aafRho(2, iEdge, :))),'b')
%      % plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'y')
%  %   plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'r')
% %     plot(squeeze(aafFlow1(1, iEdge, :)),':b')
% %     plot(squeeze(aafFlow1(2, iEdge, :)),':g')
%     title(['Vel ', num2str(iEdge)])
% end
% %%
% % figure
% % hold on
% % title('G 4->2 4->5(.)')
% figure
% hold on
% 
%  plot(diff(squeeze(aafRho(1, 2, :)) + squeeze(aafFlow(2, 2, :))),'b')
%  plot(diff(squeeze(aafFlow(1, 6 , :))),'r')
% % plot(squeeze(aaafG(2, 2, 4, :)),'g')    
% % 
% % plot(squeeze(aaafG(1, 5, 4, :)),':b')
% % plot(squeeze(aaafG(2, 5, 4, :)),':g')    
% %%
% 
% 
% 
% figure
% iEdge = 5;
% 
%     plot(squeeze(aafRho(1, iEdge, :)) + squeeze(aafRho(2, iEdge, :)),'r')
%   title(['Flow ' num2str(iEdge)])
%   
% calcJacobi
% 
% A = [fBetaRouting(2,1) fBetaRouting(5,1); fBetaRouting(2,2) fBetaRouting(5,2)]