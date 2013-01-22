% compute the maxium admissible flow mu(rho) - uses parameters threshold
% and parameter eta

function fFlow = ComputeMu(afRho, afThreholdRho, afFmax, etaMu, nof)
%
fFlow = zeros(nof, size(afRho,1));

%
for iEdge = 1:length(afRho)
    %
%     fRhoModified = RhoModified(afRho(iEdge), afThreholdRho(iEdge));
%     fFlow(iEdge) = afFmax(iEdge)*(1 - exp(-etaMu(iEdge)*fRhoModified));
%     if afRho(iEdge) >= afThreholdRho(iEdge)
%         fFlow(iEdge) = 0;
%     end
    %
    totalRho = sum(afRho(:, iEdge));
    if totalRho == 0
       vel = afFmax(iEdge);
    else
        vel = afFmax(iEdge)*(1-exp(-etaMu(iEdge)*totalRho))/totalRho;
    end
    
    fFlow(:, iEdge) = afRho(: ,iEdge)*vel;
    
end;%
%
end

