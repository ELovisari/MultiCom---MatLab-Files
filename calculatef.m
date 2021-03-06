
iNumberEdges = size(A, 1);
iNumberNodes = size(A, 2);
f = zeros(iNumberEdges*nof,1);

for i = 1:nof:iNumberEdges*nof
   f(i:i+nof-1) = ComputeMu(rho, afThreholdRho, aafFmax(:, t), etaMu, nof);
end
%
% storage allocation
aafRho      = zeros(nof, iNumberEdges, Tmax);                % densities
aafMu       = zeros(nof, iNumberEdges, Tmax);                % allowed flow
aafFlow     = zeros(nof, iNumberEdges, Tmax);                % flows
afLambda    = zeros(nof, iNumberNodes,Tmax);                 % incoming flow in the nodes
aafChange   = zeros(nof, iNumberEdges, Tmax);                % changes
afDischarge = zeros(nof, Tmax,1);                            % total outflow
aaafG = zeros(nof, iNumberEdges, iNumberEdges+1, Tmax); ComputeMu(afOldRho, afThreholdRho, aafFmax(:, t), etaMu, nof);     % routing policy functions
%
% initial condition
aafRho(:, :, 1) = afInitialConditionRho;

    
    if mod(t, 500) == 0, t, end
    afOldRho = aafRho(:, :, t-1);
    %
    % compute G
    %
    % For each origin
    for i = 1:nof
        aiEdgesOutgoingFromOrigin                   = find(aafIncidenceMatrix(:, originNodes(i)) == 1);
        afRhoOfCurrentEdges                         = afOldRho(i, aiEdgesOutgoingFromOrigin);
        afCurrentThreshold                          = afThreholdRho(aiEdgesOutgoingFromOrigin);
        %afCurrentBetaRouting                        = fBetaRouting*ones(size(aiEdgesOutgoingFromOrigin));
  
        afCurrentBetaRouting                        = fBetaRouting(aiEdgesOutgoingFromOrigin, i);
        aaafG(i, aiEdgesOutgoingFromOrigin, end, t)	= ComputeGAtOrigin(afRhoOfCurrentEdges, afCurrentThreshold, afCurrentBetaRouting);
    end
    % Loop through all edges
    for iEdges = 1:iNumberEdges
        %
        iHeadOfEdge                         = find(aafIncidenceMatrix(iEdges, :) == -1);
        aiConsecutiveEdges                  = find(aafIncidenceMatrix(:,iHeadOfEdge) == 1);
        aiCurrentEdges                      = [iEdges; aiConsecutiveEdges];
        %afCurrentBetaRouting                = [1*fBetaRouting;fBetaRouting*ones(size(aiConsecutiveEdges))];
        afCurrentBetaRouting                = [fBetaRouting(iEdges,:); fBetaRouting(aiConsecutiveEdges,:)];
        afCurrentAlphaRouting               = [fAlphaRouting(iEdges,:); fAlphaRouting(aiConsecutiveEdges,:)];
        %
        if numel(aiConsecutiveEdges) > 0
            %end
            afRhoOfCurrentEdges                 = afOldRho(:, aiCurrentEdges);
            afCurrentThreshold                  = afThreholdRho(aiCurrentEdges);
            
            % Should not need a loop here, but I'm a little lazy at the
            % moment
            for i = 1:nof
                % ComputeG(sum(afRhoOfCurrentEdges)', afCurrentThreshold, afCurrentAlphaRouting(:, i), afCurrentBetaRouting(:, i), 0)
                aaafG(i, aiCurrentEdges, iEdges, t)	= ComputeG(sum(afRhoOfCurrentEdges)', afCurrentThreshold, afCurrentAlphaRouting(:, i), afCurrentBetaRouting(:, i), bFlagUseTrafficLights);
                aaafG(i, iEdges, iEdges, t)            = aaafG(i, iEdges, iEdges, t) - 1;
            end
            %
        else%
            %
            aaafG(:, iEdges, iEdges, t)            = -1;
            %end
        end;%
        %
    end;%
    %
    % compute the current allowed flow and actual flow

    aafMu(:,:, t)     = ComputeMu(afOldRho, afThreholdRho, aafFmax(:, t), etaMu, nof);
    %
    % flow = [1 - G_(e->e)(rho)]*mu_e(rho_e)
    % Again we do an ugly for loop
    for i = 1:nof
        aafFlow(i,:, t)   = -diag(squeeze(aaafG(i,:, 1:end-1, t))).*aafMu(i,:, t)';
    end
    %
    % compute the total inflow at each node
    for i = 1:nof
    afLambda(i, originNodes(i), t) = afLambda0(i, t);
    end
    for iNodes = 2:iNumberNodes
        %
        aiEdgesToiNodes = find(aafIncidenceMatrix(:,iNodes) == -1);  
            for i = 1:nof
                afLambda(i, iNodes, t) = sum(aafFlow(i, aiEdgesToiNodes, t));
            end
        %
    end;%
    %
    % compute the current change 
    for i=1:nof
        afVectorOfAllowedFlows      = [aafMu(i, :, t)';afLambda0(i, t)];
        aafChange(i, :, t)             = squeeze(aaafG(i, :, :, t))*afVectorOfAllowedFlows;
        
           % compute now densities
    
        aafRho(i, :, t) = afOldRho(i,:) + T*aafChange(i, :, t);
    end
    %
    % compute now densities
    
    % aafRho(:, t) = afOldRho + T*aafChange(:, t);
    %
    % avoid numerical errors
    % for iEdges = 1:iNumberEdges
    %   if  aafRho(iEdges, t) > afThreholdRho(iEdges)
    %       aafRho(iEdges, t) = afThreholdRho(iEdges);
    %   end
    % end
    % compute total outflow
    % aiEdgesToDestination = find(aafIncidenceMatrix(:, end) == -1);
    % afDischarge(t-1) = sum(aafFlow(aiEdgesToDestination, t)); 
    
    for i = 1:nof
       aiEdgesToDestination                  = find(aafIncidenceMatrix(:, destNodes(i)) == -1);
       afDischarge(i, t-1)                      = sum(aafFlow(i, aiEdgesToDestination,t)); 
    end
    % check
    if isnan(aafRho(:, t))
        temp1 = aafRho;
        temp2 = aaafG;
        temp3 = aafChange;
        temp4 = aafMu;
        error('Something wrong - rho is nan')
        
    end
    %
    %
end;%
%
end%