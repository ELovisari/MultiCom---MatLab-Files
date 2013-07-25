% compute the maxium admissible flow mu(rho) - uses parameters threshold
% and parameter eta

function fFlow = ComputeMu(afRho,fMax)
%

%
for iEdge = 1:length(afRho)
    %
%     fRhoModified = RhoModified(afRho(iEdge), afThreholdRho(iEdge));
%     fFlow(iEdge) = afFmax(iEdge)*(1 - exp(-etaMu(iEdge)*fRhoModified));
%     if afRho(iEdge) >= afThreholdRho(iEdge)
%         fFlow(iEdge) = 0;
%     end
    %
   
    totalRho = sum(afRho(:));
    if totalRho == 0
       vel = fMax;
    else
        vel = fMax*(1-exp(-14*totalRho))/totalRho;
    end
    
    fFlow = afRho*vel;
    
end

