% Computes the splitting functions G at the origin - uses local rho, possibly thresholds,
% the parameter beta 

function G = ComputeGAtOrigin(afRho, afThreholdRho, fBetaRouting)
%
iNumberOfEdges = size(afRho,2);
%afRhoModified = zeros(iNumberOfEdges,1);
%
G = zeros(iNumberOfEdges,1);
Z = 0;
%
for iEdge = 1:iNumberOfEdges
    %
    afRhoModified(iEdge) = RhoModified(afRho(iEdge), afThreholdRho(iEdge));
   
   afRhoModified(iEdge) = afRho(iEdge);
    G(iEdge) = exp(-fBetaRouting(iEdge)*afRhoModified(iEdge));
    %
end;%
G = G/sum(G);
if any(isnan(G))
	% if there are NaN, this means that all the elements of G are zero
    % 
    disp('ooops');
    aiStillNotAtCapacity = find(afRho < afThreholdRho);
    if ~isempty(aiStillNotAtCapacity)
    	% in this case the rho's are simply all very large (and possibly one
        % of them is at capacity)
        % we just find the maximum among those which are not at capacity and
        % give it all the weigth - so it will reach capacity now
        %
        [fMaximumValue, iMaximum] = max(afRhoModified(aiStillNotAtCapacity));
        iMaximum = iMaximum(1); % tie-break
        iEdgeMostCongested = aiStillNotAtCapacity(iMaximum);
        G = zeros(size(G));
        G(iEdgeMostCongested) = 1;
    else%
        % => isempty(aiStillNotAtCapacity)
        % in this case all the edges around the node are at capacity and we
        % just do nothing
        G = zeros(size(G));
    end;%
end;%
%
end%

