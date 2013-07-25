% Computes the splitting functions G - uses local rho, possibly thresholds,
% the parameter beta 
% also does not use traffic light if bFlagUseTrafficLights = 0

function G = ComputeG(afRho, afThreholdRho, fAlphaRouting, fBetaRouting, bFlagUseTrafficLights)
%
iNumberOfEdges = size(afRho,1);
afRhoModified = zeros(iNumberOfEdges,1);
%
G = zeros(iNumberOfEdges,1);
%
for iEdge = 2:iNumberOfEdges
    %
    afRhoModified(iEdge) = RhoModified(afRho(iEdge), afThreholdRho(iEdge));
    %afRhoModified(iEdge) = afRho(iEdge);

    G(iEdge) = fAlphaRouting(iEdge)*exp(-fBetaRouting(iEdge)*afRhoModified(iEdge));
    %
end;%

%if bFlagUseTrafficLights == 0
    % in case traffic light is not used, the fraction of flow which is
    % retained is always zero (except - see next case)
    G(1) = 0; 
%else
 %       afRhoModified(1) = RhoModified(afRho(1), afThreholdRho(1));
  % G(1) = fAlphaRouting(1)*exp(-1*afRhoModified(1));
%end
G = G/sum(G);
if any(isnan(G))
	% if there are NaN, this means that all the elements of G are zero
    % 
    aiStillNotAtCapacity = find(afRho < afThreholdRho);
    if ~isempty(aiStillNotAtCapacity)
    	% in this case the rho's are simply all very large (and possibly one
        % of them is at capacity)
        % we just find the maximum among those which are not at capacity and
        % give it all the weigth - so it will reach capacity now
        %
        if isempty(aiStillNotAtCapacity == 1)
            % in this case the incoming edge is congested but some outgoing
            % do not
            % this case should never happen, so we invoke an error
            error('Incoming edges congested!')
        else%
            %
            if aiStillNotAtCapacity == 1
                % in this case all the outgoing edges are congested,
                % except the incoming one. Even if we do not use the
                % traffic lights, we give all the weight to the incoming
                % edge
                % if we are using trafficlights, this is consistent with
                % the scenario
                % if we are NOT using trafficlights, this is consistent
                % with the notion of edge collapsing
                G = zeros(size(G));
                G(1) = 1;
                %
            else%
                %
                % in this last case, some of the outgoing edges are not
                % congested - we give all the weight to the most congested
                % among the outgoing, just to let it reach capacity
                aiOutgoingNotAtCapacity = aiStillNotAtCapacity(2:end);
                [fMaximumValue, iMaximum] = max(afRhoModified(aiOutgoingNotAtCapacity));
                iMaximum = iMaximum(1); % tie-break
                iEdgeMostCongested = aiOutgoingNotAtCapacity(iMaximum);
                G = zeros(size(G));
                G(iEdgeMostCongested) = 1;
                %
            end;%
            %
        end;%
    else%
        % => isempty(aiStillNotAtCapacity)
        % in this case all the edges around the node are at capacity and we
        % just do nothing
        G = zeros(size(G));
    end;%
end