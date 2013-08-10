% Calculate the jacobian for a given topology and densities

%topologyMultiTest6


ti = Tmax-1;
for j = 1:numel(ti)

rho = aafRho(:,:, ti(j));
% Out velocity function
%vel = @(x)  (1-exp(-x))/(x);
%veldiff = @(x) (exp(-x)*x-(1-exp(-x)))/(x^2);



nos = M*nof;  % Number of states


% for i = 1:nof:iNumberEdges*nof
%     
%    f(i:i+nof-1) = ComputeMu(rho, afThreholdRho, aafFmax(:, end), etaMu, nof);
% end
% 
% % Loop through the
% for i = 1:M
%     % The routing policy, needs to be calculated specific for every link
%     % We need to modify this
%     G = @(x) 1;
%     Gdiff = @(x) 0;
%     
%     n = find(A(i,:) == 1);
%     incomingEdges = find(A(:,n) == -1)
%     % Calculate the diagonal elements (outflow)
%     % Fix: There should be some diagonal elements from the inflow
%     for j = 1:nof
%         for k = 1:nof
%             if rho(j,i) > 0
%                 if k == j
%                     jacobian(nof*(i-1)+j, nof*(i-1)+k) = -vel(sum(rho(:, i))) - rho(j, i)*veldiff(sum(rho(:,i)));
%                 else 
%                     jacobian(nof*(i-1)+j, nof*(i-1)+k) =  -rho(j, i)*veldiff(sum(rho(:,i)));
%                 end
%             end
%         end
%     end
%     
%     
%     if (~isempty(incomingEdges))reshape(mu1, nos, 1)
%     for in = incomingEdgesfBetaRouting(2,1) = 10;
%fBetaRouting(5,1) = 1;

%         for j = 1:nof
%             foaafFlowr k = 1:nof
%                 if rho(j,i) > 0
%                     jacobian(nof*(i-1)+j, nof*(in-1)+k) = G(1);
%                 end
%             end
%         end
%     end
%     end
% endtopologyMultiTest



iNumberEdges = size(A, 1);
iNumberNodes = size(A, 2);
f = zeros(iNumberEdges*nof,iNumberEdges*nof);

h = 0.0000001;

% The outflows

for i = 1:nos
    if mod(i, nof) == 0
        flow = nof;
    else
        flow = mod(i,nof);
    end
    edge = ceil(i/nof);
    %if(rho(flow,edge) > 0)
    rhop = rho;
    rhom = rho;
    rhop(flow, edge) = rho(flow,edge) + h;
    rhom(flow, edge) = rho(flow,edge) - h;
    
    [~, aafFlow, ~, aafChange, ~]         = SimulateMulticommodityNetwork(                   ...
                                                            A, aafFmax, afLambda0, afThreholdRho, T, 2,         ...
                                                            rhop, fAlphaRouting,                 ...
                                                            fBetaRouting, etaMu, nof, originNodes, destNodes, bFlagUseTrafficLights);
    flowp = reshape(aafChange(:,:,2), nos, 1);
    
    [~, aafFlow, ~, aafChange, ~]         = SimulateMulticommodityNetwork(                   ...
                                                            A, aafFmax, afLambda0, afThreholdRho, T, 2,         ...
                                                            rhom, fAlphaRouting,                 ...
                                                            fBetaRouting, etaMu, nof, originNodes, destNodes, bFlagUseTrafficLights);
    flowm =  reshape(aafChange(:,:,2), nos, 1);
 
    f(:, i) = (flowp - flowm)./2./h;
    %end
end
eig(f);
f 
di = diag(f);
% Check greshgorgin circles

%f = f'
disp('Greshgorgin 1')
for k = 1:length(f)
   disp(sum(abs(f(k, 1:end))) - abs(di(k)) + di(k))
end


disp('Greshgorgin 2')
f = f';
for k = 1:length(f)
   disp(sum(abs(f(k, 1:end))) - abs(di(k)) + di(k))
end



end


    % Calculate the inflow
    
    
    


