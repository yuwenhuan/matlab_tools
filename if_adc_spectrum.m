clear all;
addpath('\\silabs.com\design\home\weyu\script\matlab\txt2mat');

t2mOpts = {'NumHeaderLines', 1, ...
           'NumColumns', 3, ...
           'ReplaceChar', {'ns ','ps '}, ...
           'ConvString', '%d %f %d' , ...
           };
%adcout_tmp = txt2mat('adcout.txt',t2mOpts{:});
adcout_tmp = txt2mat('adcout_rohde_6p8mhz_1p25vdd_200mVinput_vcm7_ib3.txt',t2mOpts{:});

%start_ptr = 6888;  % starting index for fft
start_ptr = 1880;  % starting index for fft
%num_period = 197; % number of period
num_period = 157; % number of period
% find the ending index for num_period
ii = start_ptr + 1;
crossing_count = 0;
crossing_pos = start_ptr;
delta = 0;
while ii <= length(adcout_tmp(:,3)) && crossing_count < num_period * 2
    delta_old = delta;
    delta = adcout_tmp(ii,3) - adcout_tmp(start_ptr,3);
    if delta*delta_old <= 0 && ii - crossing_pos > 3
        crossing_count = crossing_count + 1;
        crossing_pos = ii;
    end
    ii = ii + 1;
end
end_ptr = ii - 2;
% clip the adcout
adcout = adcout_tmp(start_ptr:end_ptr,3);
adcout = adcout - mean(adcout);
adcout = adcout/(2^10);

alpha_list = 0;
alpha_list = 0.045;
%alpha_list = [0.035:0.0005:0.055];
hd3_list = zeros(1,length(alpha_list));
for ii = 1:length(alpha_list)
    alpha = alpha_list(ii);
    adcout_third = alpha*(adcout.^3);
    adcout_corr = adcout + adcout_third;

    fft_length = length(adcout_corr);
    figure(111);stairs(adcout_corr);

    % fft
    V = fft_wenhuan(adcout_corr');
    fs = 200e6;
    fmin = 0e6;
    fmax = 8e6;
    kmin = round(fmin/(fs/fft_length));
    kmax = round(fmax/(fs/fft_length));
    plotopt = 1;
    figure(333);
    [snr,sndr,hd2,hd3]=plot_spec_wenhuan(V,kmin,kmax,num_period,fs,plotopt)
    xlim([100e3,200e6]);
    hd3_list(ii)=hd3;
end
% figure(322);
% hd3_list
% plot(alpha_list,hd3_list);
% xlabel('alpha');
% ylabel('HD3(dB)');