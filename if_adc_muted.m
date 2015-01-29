addpath('\\silabs.com\design\home\weyu\script\matlab\txt2mat');

t2mOpts = {'NumHeaderLines', 1, ...
           'NumColumns', 3, ...
           'ReplaceChar', {'ns ','ps '}, ...
           'ConvString', '%d %f %d' , ...
           };
%adcout_tmp = txt2mat('adcout.txt',t2mOpts{:});
adcout_tmp = txt2mat('adcout_muted_rohde_4p7mhz_1p25vdd_200mVinput_vcm12_ib3_ss_agilent.txt',t2mOpts{:});

start_ptr = 100;
end_ptr = length(adcout_tmp(:,3))-100;
% clip the adcout
adcout = adcout_tmp(start_ptr:end_ptr,3);
adcout = adcout - mean(adcout);
adcout = adcout/(2^10);

fft_length = length(adcout);
figure(111);stairs(adcout);

% fft
V = fft_wenhuan(adcout');
fs = 200e6;
fmin = 0e6;
fmax = 100e6;
kmin = round(fmin/(fs/fft_length));
kmax = round(fmax/(fs/fft_length));
plotopt = 1;
figure(333);
noise=plot_spec_muted_wenhuan(V,kmin,kmax,fs,plotopt)
xlim([100e3,200e6]);

