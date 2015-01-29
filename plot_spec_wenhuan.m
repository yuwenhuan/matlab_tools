% [snr,sndr]=plot_spec_wenhuan(V,kmin,kmax,ksig,fs,plotopt)
% V: fft results
% kmin: minimum inband bin number (start from 0)
% kmax: maximum inband bin number (start from 0)
% ksig: signal bin number (start from 0)
% fs: sampling freq
% plotopt: 0-linear freq,1-log freq

function [snr,sndr,hd2,hd3]=plot_spec_wenhuan(V,kmin,kmax,ksig,fs,plotopt)

N = length(V);
[snr,sndr,hd2,hd3]=calc_sndr_wenhuan(V,kmin,kmax,ksig);
fin = ksig*fs/N;

% figure(1);hold on;
f=[0:N-1]/N*fs;
if plotopt==0
    plot(f,20*log10(abs(V)));
else
    semilogx(f,20*log10(abs(V)));
end
xlabel('Freq (Hz)');
ylabel('Magnitude (dBFS)');
title(sprintf('fin=%.2f MHz,SNR=%5.2f dB,SNDR=%5.2f dB,HD2=%5.2f dB,HD3=%5.2f dB,%d point FFT',fin/1e6,snr,sndr,hd2,hd3,N));
grid on;