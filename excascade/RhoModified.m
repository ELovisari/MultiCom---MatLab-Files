function fRhoModified = RhoModified(fRho, fThreshold)
%
fRhoModified = fRho/(1 - fRho/fThreshold);
%
if fRho >= fThreshold
    % this may happen due to the nonideal numerical procedure
    fRhoModified = Inf;
end
%
end