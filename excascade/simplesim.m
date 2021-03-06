

Tmax = 8000;
h = 0.01;

flows = zeros(2,4,Tmax);    % Commodity, Link, Time
changes = zeros(2,4,Tmax);  % Commodity, Link, Time
rho  = zeros(2,4,Tmax);     % Commodity, Link, Time

fMax = [1 1 1 1];

fBetaRouting = [ 4 15
                   4 1
                   15 4
                   1 4];
    
oldLambdaA = 1.35;
oldLambdaB = 1.35;
lambdaA = [1.35 0.4];
lambdaB = [1.35 1.1];

for t = 2:Tmax
    % Edge 1
    fl = ComputeMu(rho(:,1,t-1), 1.5);
    flows(1,1,t-1) = fl(1);
    flows(2,1,t-1) = fl(2);
    
    changes(1,1,t) = exp(-fBetaRouting(1,1)*sum(rho(:,1,t-1)))/(exp(-fBetaRouting(1,1)*sum(rho(:,1,t-1))) + exp(-fBetaRouting(2,1)*sum(rho(:,2,t-1))))*lambdaA(1) - flows(1,1,t-1);
    changes(2,1,t) = exp(-fBetaRouting(1,2)*sum(rho(:,1,t-1)))/(exp(-fBetaRouting(1,2)*sum(rho(:,1,t-1))) + exp(-fBetaRouting(2,2)*sum(rho(:,2,t-1))))*lambdaB(1) - flows(2,1,t-1);
    
    
      if (t < Tmax/2)
        c = 1.5;
      else
        c = 1.3;
      end
    
  
    fl = ComputeMu(rho(:,2,t-1), c);
    flows(1,2,t-1) = fl(1);
    flows(2,2,t-1) = fl(2);
    
    changes(1,2,t) = exp(-fBetaRouting(2,1)*sum(rho(:,2,t-1)))/(exp(-fBetaRouting(1,1)*sum(rho(:,1,t-1))) + exp(-fBetaRouting(2,1)*sum(rho(:,2,t-1))))*lambdaA(1) - flows(1,2,t-1);
    changes(2,2,t) = exp(-fBetaRouting(2,2)*sum(rho(:,2,t-1)))/(exp(-fBetaRouting(1,2)*sum(rho(:,1,t-1))) + exp(-fBetaRouting(2,2)*sum(rho(:,2,t-1))))*lambdaB(1) - flows(2,2,t-1);
    
    
    % Edge 3
    fl = ComputeMu(rho(:,3,t-1), 1.5);
    flows(1,3,t-1) = fl(1);
    flows(2,3,t-1) = fl(2);

    
    changes(1,3,t) = exp(-fBetaRouting(3,1)*sum(rho(:,3,t-1)))/(exp(-fBetaRouting(3,1)*sum(rho(:,3,t-1))) + exp(-fBetaRouting(4,1)*sum(rho(:,4,t-1))))*(lambdaA(2) + flows(1,1,t-1)) - flows(1,3,t-1);
    changes(2,3,t) = exp(-fBetaRouting(3,2)*sum(rho(:,3,t-1)))/(exp(-fBetaRouting(3,2)*sum(rho(:,3,t-1))) + exp(-fBetaRouting(4,2)*sum(rho(:,4,t-1))))*(lambdaB(2) + flows(2,1,t-1)) - flows(2,3,t-1);
    
    
    % Edge 4
    
    fl = ComputeMu(rho(:,4,t-1), 1.5);
    flows(1,4,t-1) = fl(1);
    flows(2,4,t-1) = fl(2);
    
    changes(1,4,t) = exp(-fBetaRouting(4,1)*sum(rho(:,4,t-1)))/(exp(-fBetaRouting(3,1)*sum(rho(:,3,t-1))) + exp(-fBetaRouting(4,1)*sum(rho(:,4,t-1))))*(lambdaA(2) + flows(1,1,t-1)) - flows(1,4,t-1);
    changes(2,4,t) = exp(-fBetaRouting(4,2)*sum(rho(:,4,t-1)))/(exp(-fBetaRouting(3,2)*sum(rho(:,3,t-1))) + exp(-fBetaRouting(4,2)*sum(rho(:,4,t-1))))*(lambdaB(2) + flows(2,1,t-1)) - flows(2,4,t-1);
    
    
    
    rho(1,1,t) = rho(1,1,t-1) + h*changes(1,1,t);
    rho(2,1,t) = rho(2,1,t-1) + h*changes(2,1,t);
    
    rho(1,2,t) = rho(1,2,t-1) + h*changes(1,2,t);
    rho(2,2,t) = rho(2,2,t-1) + h*changes(2,2,t);   
    
    rho(1,3,t) = rho(1,3,t-1) + h*changes(1,3,t);
    rho(2,3,t) = rho(2,3,t-1) + h*changes(2,3,t);
    
    
    rho(1,4,t) = rho(1,4,t-1) + h*changes(1,4,t);
    rho(2,4,t) = rho(2,4,t-1) + h*changes(2,4,t);
    
end


for edge = 1:4
       subplot(floor(4/2)+1, 2, edge)
    hold on
  plot(squeeze(flows(1, edge, :)),'b')
    plot(squeeze(flows(2, edge, :)),'g') 
end

pt = floor(Tmax/2);
%%
for i = 1:4

    disp(['\textbf{Edge $e_' num2str(i) '$} & \multicolumn{3}{c|}{}   \\ \hline ']);
    disp(['Commodity $A$ & ' num2str(flows(1,i,pt-3)) ' & ' num2str(flows(1,i,end-3) ) ' &  ' num2str(flows(1,i,end-3) - flows(1,i,pt-3)) ' \\ \hline ']);
    disp(['Commodity $B$ & ' num2str(flows(2,i,pt-3)) ' & ' num2str(flows(2,i,end-3) ) ' &  ' num2str(flows(2,i,end-3) - flows(2,i,pt-3)) ' \\ \hline ']);
    disp(['Aggregate $A+B$ & ' num2str(flows(1,i,pt-3) + flows(2,i,pt-3) ) ' & ' num2str(flows(1,i,end-3) + flows(2,i,end-3)) ' &  ' num2str(flows(1,i,end-3)+flows(2,i,end-3)  - flows(1,i,pt-3) -flows(2,i,pt-3)) ' \\ \hline ']);

end


t = 1:1:Tmax;
 t = t';
fil = 1:10:Tmax;
 % smatrix = [t squeeze(aafRho(1,1,:)) squeeze(aafRho(1,2,:)) squeeze(aafRho(2,1,:)) squeeze(aafRho(2,2,:)) ]
% 
% save rho.dat smatrix -ascii 
% 
% 
smatrix = [t(fil) squeeze(flows(1,1,fil)) squeeze(flows(2,1,fil)) squeeze(flows(1,2,fil)) squeeze(flows(2,2,fil)) squeeze(flows(1,3,fil)) squeeze(flows(2,3,fil)) squeeze(flows(1,4,fil)) squeeze(flows(2,4,fil))]
 
save flow.dat smatrix -ascii 
