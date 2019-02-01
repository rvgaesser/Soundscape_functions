 function [d]=bandpass_del(c,flp,fhi,Fs,n) 
 % %
 % Function bandpass applies nth order butterworth filter 
 % [d]=bandpass(c,flp,fhi,Fs,n) 
 % 
 % INPUT 
 % c = input time series 
 % flp = lowpass corner frequency of filter 
 % fhi = hipass corner frequency 
 % Fs = sample rate 
 % n = filter order
 % 
 % OUTPUT 
 % d is the bandpassed waveform. 
 % 
 % 
 % ALso see: 
 % function dsmp_bandpass (for high sample rate datasets) 
 % 
 % Del Bohnenstiehl - NCSU 
 % drbohnen@ncsu.edu 
 % part of NCSU's soundscape tools package for MATLAB 
 
 if isempty(n) 
     n=5; 
 end
 
 fnq=0.5*Fs;  % Nyquist frequency 
 Wn=[flp/fnq fhi/fnq];    % butterworth bandpass non-dimensional frequency 
 [b,a]=butter(n,Wn); % construct the filter 
 d=filtfilt(b,a,c); % zero phase filter the data 
 return;
