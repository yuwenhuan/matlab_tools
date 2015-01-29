% noise=calc_muted_noise(V,kmin,kmax)
% V: fft results
% kmin: minimum inband bin number (start from 0)
% kmax: maximum inband bin number (start from 0)

function noise=calc_muted_noise(V,kmin,kmax)
noise_bins = [kmin:kmax];
noise = 10*log10(sum(abs(V(noise_bins+1)).^2));
