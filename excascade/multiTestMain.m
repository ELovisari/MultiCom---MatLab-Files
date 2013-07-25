clc
clear all
close all


% Import the selected topology
topologyPartialSplit
% Number of time steps
Tmax = 12000;

% Length of each timestep
T = 0.01;

pt = Tmax/2;
% Set the capacity on the edges
aafFmax = 1.5*ones(M, Tmax);

aafFmax(1,:)=1.3;
aafFmax(2,:) = 0.4;

afThreholdRho = Inf*rand(M,1);




% Total inflow
afLambda0 =   ones(nof, Tmax); 
afLambda0(1,:) = 0.25;
afLambda0(2,:) = 0.95;


afLambda0(1,pt:end) = 0.15;
afLambda0(2,pt:end) = 1.25;

%afLambda0(2, 15000:end) = 1;



fBetaRouting = 4*[30 4; 1 4];

% Mu (CHANGE)
etaMu                   = ceil(10*rand(M,1)); 

etaMu = [  8
    100];



etaMu = [ 14; 14];

 
afInitialConditionRho =  1 * zeros(nof, M);

% afInitialConditionRho = [
%     0.2691    0.5479    0.4177    0.3015    0.6663    0.6981    0.1781    0.9991  0.0326    0.8819
%     0.4228    0.9427    0.9831    0.7011    0.5391    0.6665    0.1280    0.1711  0.5612    0.6692 ];
   
   
afInitialConditionRho1 = 1*rand(nof, M);
% afInitialConditionRho1 = [


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

        %disp(['Change of aggregate: ' num2str(aafFlow(1, iEdge, Tmax-3)- aafFlow(1, iEdge, pt-3) + aafFlow(2, iEdge, Tmax-3)- aafFlow(2, iEdge, pt-3))]);
end

% t = 1:1:30000;
% t = t';
% smatrix = [t squeeze(aafRho(1,1,:)) squeeze(aafRho(1,2,:)) squeeze(aafRho(2,1,:)) squeeze(aafRho(2,2,:)) ]
% 
% save rho.dat smatrix -ascii 
% 
% 
% smatrix = [t squeeze(aafFlow(1,1,:)) squeeze(aafFlow(1,2,:)) squeeze(aafFlow(2,1,:)) squeeze(aafFlow(2,2,:)) ]
% 
% save flow.dat smatrix -ascii 

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