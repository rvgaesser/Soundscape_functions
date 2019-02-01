function [s,fsnew]=dsmp_bandpass(y,lo,hi,fs,n,viewresp)
%
% The function dsmp_bandpass will downsample/decimate a timeseries before 
% applying a nth order butterworth bandpass filter.  This is necessary in 
% cases where the sample rate is large (e.g.,96 or 128 kHz) and the desired 
% low frequency cutoff is small.  In such situations the filter design is 
% subject to numerical problems. Maximum amount of downsampling is
% constrained to 10 times.  
% 
%% USE: 
% [s,fsnew]=dsmp_bandpass(y,lo,hi,fs,n,viewresp)
% [s,fsnew]=dsmp_bandpass(dataset,150,15000,96000,5,1)
% 
%% INPUT 
% y = original time series 
% lo = low frequency cut off Hz 
% hi = high frequency cut off Hz 
% fs = sample rate Hz 
% n = filter order (e.g., 5) 
% viewresp = 1 if you want to see the filter response; 
%  
% 
%% OUTPUT 
% s = filter signal 
% fsnew =  sample rate of the returned signal 
%
%% NOTES
% 1. If you are not dealing with very high sample rates, then simply use 
% bandpass.m. 
% 2. Output time series will be at a low sample rate, fsnew
% 3. Function usus MATLAB's filtfilt for a zero phase filter 
% 
%% Del Bohnenstiehl - NCSU 
% Last modified 15 June 2016  
% drbohnen@ncsu.edu 
% part of NCSU's soundscape tools package for MATLAB 

 if isempty(n) 
     n=5; 
 end
 
nyq=fs/2; % define nyquist frequency 
dec=floor(nyq/(hi*1.075)); % determines how much to downsample based on hi frequency cut off. 
dec=min([dec,10]); % don't downsample more than 10 times  
disp(['applying decimation of : ' num2str(dec) ])  % warn if no downsampling can be done 
if dec == 1; 
    disp('Warning: high freq cutoff too large, no decimation used') 
end
s = decimate(y-mean(y),dec);  % note decimate lowpasses the data before resampling 
fsnew=fs/dec;  % determine the new sample rate
nyqnew=fsnew/2; % define the new nyquist 
[b,a]=butter(n,[lo,hi]./nyqnew);  % calulate filter coefficients using new sample rate 
s=filtfilt(b,a,s); s=s-mean(s);  % apply filter to decimated time series 

if viewresp == 1  % if viewresp is set to one, plot the downsample and original response. 
    [H,F]=freqz(b,a,2001,fsnew); 
    figure; plot(F,abs(H),'LineWidth',3); hold on; 
    disp('if you are running viewresponse == 1, you may ignore warnings immeditely'); 
    disp('after this message; They are referring to results if data are not downsampled') 
    [b,a]=butter(n,[lo,hi]./nyq); 
    [H,F]=freqz(b,a,2001,fs);  plot(F,abs(H),'--r','LineWidth',3)
    xlim([0,hi*2]); legend('down sampled version', 'original filter'); 
end



