clc
clear all
close all


% Import the selected topology
topologyFail
% Number of time steps
Tmax = 30000;

% Length of each timestep
T = 0.01;

% Set the capacity on the edges
aafFmax = 3*ones(M, Tmax);

aafFmax(2,:) = 0.1;
aafFmax(3,:) = 0.1;


%aafFmax(4,:) = 1;


% Total inflow
afLambda0 =   ones(nof, Tmax); 




% No thresholds
afThreholdRho = Inf*rand(M,1);

% Routing policy 
fBetaRouting            = ceil(50*rand(M,nof));     

%      
% fBetaRouting =[
%      4     1
%      7     8
%      8     3
%      6     5
%      4     7
%      2     4
%      6     8
%      3     4];
% Mu (CHANGE)
% 
%  fBetaRouting =[
%       4     5
%       1     2      
%       2     1
%       2     1];

etaMu                   = ceil(50*rand(M,1)); 

% 
% etaMu =4*[1;1;1;1];
%      1
%      4
%      5
%      3
%      2];


 
 
afInitialConditionRho =  1 * zeros(nof, M);


   
afInitialConditionRho1 = 1*rand(nof, M);


% Don't use any traffic lights
bFlagUseTrafficLights  = 1; 

%
[aafRho, aafFlow, aaafG, aafChange, afDischarge]         = SimulateMulticommodityNetwork(                   ...
                                                            A, aafFmax, afLambda0, afThreholdRho, T, Tmax,         ...
                                                            afInitialConditionRho, fAlphaRouting,                 ...
                                                            fBetaRouting, etaMu, nof, originNodes, destNodes, bFlagUseTrafficLights);
aafRho1 = aafRho; aafFlow1 = aafFlow; aaafG1 = aaafG; aafChange1 = aafChange; afDischarge1 = afDischarge;

[aafRho1, aafFlow1, aaafG1, aafChange1, afDischarge1]         = SimulateMulticommodityNetwork(                   ...
                                                            A, aafFmax, afLambda0, afThreholdRho, T, Tmax,         ...
                                                            afInitialConditionRho1, fAlphaRouting,                 ...
                                                            fBetaRouting, etaMu, nof, originNodes, destNodes, bFlagUseTrafficLights);
                                                        
                                                        
                                                        
differ = squeeze(aafRho(:,:,end-1)) - squeeze(aafRho1(:,:,end-1));
sum(sum(abs(differ))')
%%
close all
figure
for iEdge = 1:M
    subplot(floor(M/2)+1, 2, iEdge)
    hold on
    temp = squeeze(aafRho(1, iEdge, :));
    plot(squeeze(aafRho(1, iEdge, :)),'b')
    plot(squeeze(aafRho(2, iEdge, :)),'g')
       plot(squeeze(aafRho1(1, iEdge, :)),':b')
     plot(squeeze(aafRho1(2, iEdge, :)),':g')
    title(['Rho ', num2str(iEdge)])

%     filename = ['Rho1Edge' num2str(iEdge) '.dat'];
%     t = 1:1:1500;
%     temp =  [t' temp];
%     save(filename, 'temp', '-ascii');
%     set(gca, 'XTick', [])
%  
  
end
% figure
% for iEdge = 1:M
%     subplot(floor(M/2)+1, 2, iEdge)
%     hold on
%     plot(squeeze(aafFlow(1, iEdge, :)),'b')
% 
%     plot(squeeze(aafFlow(2, iEdge, :)),'g')
%     %plot(squeeze(aafFlow(1, iEdge, :)) + squeeze(aafFlow(2, iEdge, :)),'r')
%     
%    title(['Flow ', num2str(iEdge)])
%         set(gca, 'XTick', [])
% 
% %    plot(squeeze(aafFlow1(1, iEdge, :)) + squeeze(aafFlow1(2, iEdge, :)),'r')
%     plot(squeeze(aafFlow1(1, iEdge, :)),':b')
%   plot(squeeze(aafFlow1(2, iEdge, :)),':g')
% %     title(['Flow ', num2str(iEdge)])
% %         disp(['Edge '  num2str(iEdge)]);
% %         disp(['Change of flow 1: ' num2str(aafFlow(1, iEdge, Tmax-3)- aafFlow(1, iEdge, floor(Tmax/2)-3))]);
% %         disp(['Change of flow 2: ' num2str(aafFlow(2, iEdge, Tmax-3)- aafFlow(2, iEdge, floor(Tmax/2)-3))]);
% %         disp(['Change of aggregate: ' num2str(aafFlow(1, iEdge, Tmax-3)- aafFlow(1, iEdge, floor(Tmax/2)-3) + aafFlow(2, iEdge, Tmax-3)- aafFlow(2, iEdge, floor(Tmax/2)-3))]);
% end

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



% 
% t = 1:1:Tmax;
% t = t';
% 
% filter =1:5:Tmax;
% %%
% smatrix = [t(filter) squeeze(aafRho(1,1,filter)) squeeze(aafRho(2,1,filter)) squeeze(aafRho(1,2,filter)) squeeze(aafRho(2,2,filter)) squeeze(aafRho(1,3,filter)) squeeze(aafRho(2,3,filter)) squeeze(aafRho(1,4,filter)) squeeze(aafRho(2,4,filter)) ]
% save rho.dat smatrix -ascii 
% 
% 
% smatrix = [t(filter) squeeze(aafFlow(1,1,filter)) squeeze(aafFlow(2,1,filter)) squeeze(aafFlow(1,2,filter)) squeeze(aafFlow(2,2,filter)) squeeze(aafFlow(1,3,filter)) squeeze(aafFlow(2,3,filter)) squeeze(aafFlow(1,4,filter)) squeeze(aafFlow(2,4,filter)) ]
% 
% save flow.dat smatrix -ascii 