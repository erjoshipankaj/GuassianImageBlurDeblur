function I_blur = GaussianBlur(I,r)
if length(size(I))>2
    I = rgb2gray(I);
end
I = im2double(I);
I_dft = fft2(I);
H = gaussian_lp(size(I,1),size(I,2),r);
I_blur_dft = I_dft.*H;
I_blur = ifft2(I_blur_dft);