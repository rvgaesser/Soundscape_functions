% Df trials 

clear

load('/Volumes/SuccessionA/Soundscape_Analysis/mspec_all.mat')
c = 1;
f1 = 100;
f2 = 1500;
for i = 1:18
    S1 = mspec_all(:,i);
    for j = i+1:18
        S2 = poavg(:,j);
        Df(c) = sound_Df(S1,S2,f,f1,f2,0); 
    c=c+1;
    end
end

Df_square = squareform(Df); 
figure; imagesc(Df_square);
% NMDS
[Y,stress] = mdscale(Df_square,2);
figure;plot(Df_square,distances);

% PCoA
[Y,eigvals] = cmdscale(Df_square);
dim_eval = [eigvals eigvals/max(abs(eigvals))];
maxrelerr = max(abs(Df - pdist(Y(:,1:2)))) / max(Df);


