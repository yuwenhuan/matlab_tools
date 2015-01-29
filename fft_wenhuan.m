% fft V = fft_wenhuan(v)

function V = fft_wenhuan(v)
N = length(v);
w = .5*(1 - cos(2*pi*(0:N-1)/N) ); % "ds_hann" window from DS toolbox
nb = 3;
w1 = norm(w,1);
w2 = norm(w,2);
NBW = (w2/w1)^2;
V = fft(w.*v)/(w1/2);

