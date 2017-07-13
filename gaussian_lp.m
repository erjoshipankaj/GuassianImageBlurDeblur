function b = gaussian_lp(M,N,sigma)
if nargin ~= 3
    eid = sprintf('Images:%s:wrongNumberOfLowPassInputs',mfilename);
    msg = 'Wrong Number of inputs for ''Gaussian Low Pass'' filter.';
    error(eid,'%s',msg);
end
a = ischar(M) || ischar(N) || ischar(sigma);
if a ~= 0
    eid = sprintf('Images:%s:wrongInputType',mfilename);
    msg = 'Wrong type of Input Arguments for''Gaussian LPF';
    error(eid,'%s',msg);
end
if sigma > prod(M,N)
    eid = sprintf('Images:%s:badCutOffValue',mfilename);
    msg = 'Bad Cut of Value for''Gaussian LPF';
    error(eid,'%s',msg);
end
dist = distencematrix(M,N);
b = exp(-(dist.^2)/(2 * (sigma ^ 2)));