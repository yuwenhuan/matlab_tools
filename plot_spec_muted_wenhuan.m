% [snr,sndr]=plot_spec_wenhuan(V,kmin,kmax,ksig,fs,plotopt)
% V: fft results
% kmin: minimum inband bin number (start from 0)
% kmax: maximum inband bin number (start from 0)
% fs: sampling freq
% plotopt: 0-linear freq,1-log freq

function noise=plot_spec_muted_wenhuan(V,kmin,kmax,fs,plotopt)

N = length(V);
noise=calc_muted_noise(V,kmin,kmax);

% figure(1);hold on;
f=[0:N-1]/N*fs;
if plotopt==0
    plot(f,20*log10(abs(V)));
else
    semilogx(f,20*log10(abs(V)));
end
xlabel('Freq (Hz)');
ylabel('Magnitude (dBFS)');
title(sprintf('noise=%5.2f dBFS,fmin=%5.1f MHz,fmax=%5.1f MHz,%d point FFT',noise,kmin*fs/N/1e6,kmax*fs/N/1e6,N));
grid on;