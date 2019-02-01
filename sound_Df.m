function Df=sound_Df(S1,S2,f,f1,f2,plt)
% sound_Df calculates the spectral dissimilarity between two mean spectra

% Inputs
% S1 = average (or median) spectra of time series 1
% S2 = average (or median) spectra of time series 2
% f = frequency vector
% [f1 f2] = frequency range of interest --> used to trim spectra 

% NOTE: using median spectra for each site - when using mean, trend is
% similar in highband but large variability in lowband inflates SPLs so
% that spectra looks a little different

% Attemped Jan 2018 OC

% trim spectra and calculate pdf (mean spectra normalized by total power)

a=find(f>f1 & f<f2); 

Sf1=S1(a)/sum(S1(a));
Sf2=S2(a)/sum(S2(a));
sum(Sf2)  %should sum to 1
sum(Sf1)

% D calculation
Df=(1/2)*sum(abs(Sf1-Sf2));


% plotting
if plt==1
    figure; subplot(1,2,1); semilogx(f(a),Sf1,'b'); hold on; semilogx(f(a),Sf2,'r'); %plot normalized data
    subplot(1,2,2); semilogx(f(a),S1(a),'b'); hold on; semilogx(f(a),S2(a),'r');  %plot non-normalized data
end
end