% [snr,sndr,hd2,hd3]=calc_sndr_wenhuan(V,kmin,kmax,ksig)
% V: fft results
% kmin: minimum inband bin number (start from 0)
% kmax: maximum inband bin number (start from 0)
% ksig: signal bin number (start from 0)

function [snr,sndr,hd2,hd3]=calc_sndr_wenhuan(V,kmin,kmax,ksig)
sig_side_bins = 9;
signal_bins = ksig + [-sig_side_bins:sig_side_bins];
inband_bins = [kmin:kmax];
dist_bins = [];
for ii=2:floor(kmax/ksig);
    dist_bins = [dist_bins,ii*ksig + [-sig_side_bins:sig_side_bins]];
end
hd2_bins = 2*ksig + [-sig_side_bins:sig_side_bins];
hd3_bins = 3*ksig + [-sig_side_bins:sig_side_bins];
noise_bins = setdiff(inband_bins,[signal_bins,dist_bins]);
snr = 10*log10(sum(abs(V(signal_bins+1)).^2)/sum(abs(V(noise_bins+1)).^2));
sndr = 10*log10(sum(abs(V(signal_bins+1)).^2)/(sum(abs(V(noise_bins+1)).^2)+sum(abs(V(dist_bins+1)).^2)));
hd2 = 10*log10(sum(abs(V(signal_bins+1)).^2)/sum(abs(V(hd2_bins+1)).^2));
hd3 = 10*log10(sum(abs(V(signal_bins+1)).^2)/sum(abs(V(hd3_bins+1)).^2));
