sum = zeros(Tmax,1 );
for iEdge = 1:10
   % max( (squeeze(aafRho(1, iEdge, :)) - squeeze(aafRho1(1, iEdge, :))).*(squeeze(aafChange(1, iEdge, :)) - squeeze(aafChange1(1, iEdge, :))))
    sum = sum + sign((squeeze(aafRho(1, iEdge, :)) - squeeze(aafRho1(1, iEdge, :)))).*(squeeze(aafChange(1, iEdge, :)) - squeeze(aafChange1(1, iEdge, :)));
    sum = sum + sign((squeeze(aafRho(2, iEdge, :)) - squeeze(aafRho1(2, iEdge, :)))).*(squeeze(aafChange(2, iEdge, :)) - squeeze(aafChange1(2, iEdge, :)));
end

l1 = max(sum(2:end));

lett = zeros(1,Tmax);
for i=1:Tmax
    
   lett(i) =  norm([aafRho(1, :, i) aafRho(2,:, i)] - [aafRho1(1, :, i) aafRho1(2,:, i)], 1);
end
figure
plot(lett);