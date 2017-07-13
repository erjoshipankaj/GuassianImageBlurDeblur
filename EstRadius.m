function r = EstRadius(I_blur)
%find raduis of filter by which filter respose is created 
% This function will estimate raduis and from blur image it will
% estimate according common charatertics of filter, estimation is according
% to tansition band chartertics of blur image.
%%define require Parameters
sizeI = size(I_blur);
I_blur_dft = fft2(I_blur);
I_blur_dft = fftshift(I_blur_dft);
I_blur_dft = abs(I_blur_dft);
I_blur_dft = im2uint8(I_blur_dft);
iner_r = 1; %intialise value of iner radius
K = fix(sizeI(1)/2);%center cordinate of Filter
L = fix(sizeI(2)/2);
%% 
%Estimation of width up to Pass band
while I_blur_dft(K,L) == 255 && K < sizeI(1) && L <sizeI(2)
    iner_r = iner_r+1;
    K = K+1;
    L = L+1;
end
% r = iner_r/2;
%%
% Estimation of width up to stop band
K = fix(sizeI(1)/2);% center Cordinate
L = fix(sizeI(2)/2);%center cordinate
outer_r = 1;% Initiate outer radius
while I_blur_dft(K,L) ~= 0 && K < sizeI(1) && L < sizeI(2) 
    outer_r = outer_r+1;
    K = K+1;
    L = L+1;
end
%% Estimation of Redius 
est = ((outer_r./4)+(iner_r./2))./2;
nest = outer_r-iner_r;
r = (nest+est)./2;
