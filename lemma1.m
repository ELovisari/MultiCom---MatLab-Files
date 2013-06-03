



for i=1:1000
rhoa = 1*rand(1,5);
rhob = 1*rand(1,5);


fBetaRouting  = ceil(10*rand(5,2));     
afThreholdRho = Inf*rand(5,1);

fAlphaRouting = ones(5,1);

ga1 = ComputeGAtOrigin(rhoa,afThreholdRho, fBetaRouting(:,1), fAlphaRouting, 1);
%ga2 = ComputeGAtOrigin(rhoa,afThreholdRho, fBetaRouting(:,2), fAlphaRouting, 1);


gb1 = ComputeGAtOrigin(rhob,afThreholdRho, fBetaRouting(:,1), fAlphaRouting, 1);
%gb2 = ComputeGAtOrigin(rhob,afThreholdRho, fBetaRouting(:,2), fAlphaRouting, 1);

index1 = find(rhoa(1,:) > rhob(1,:));
%index2 = find(rhoa(2,:) > rhob(2,:));


s = sum(ga1(index1) - gb1(index1)); %+ sum(ga2(index2) - gb2(index2))
if(s > 0)
    disp('Opps');
    s
end

end