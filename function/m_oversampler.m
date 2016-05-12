function output_image = m_oversampler(image, oversampling_factor, output_size)
% Use to oversample image in fourier space.
% input an image in Real Space
% put it into a larger framework
% transform to Fourier Space
% Cut central part to a small image
%
% input information:
% image:
% oversampling_factor: default = 5
% output_szie: default = [0 0]
% output information:
%

% check input information
if exist('oversampling_factor', 'var') == 0
    oversampling_factor = 5;
end
if exist('output_size', 'var') == 0
    output_size = 0;
end

% check the size of input image (odd / even)
[rows, cols] = size(image);
if (rows/2 - floor(rows/2) == 0) || (cols/2 - floor(cols/2) == 0)
    warning('the input image maybe is not suitable for fft')
end

% oversampling
framework_rows = oversampling_factor * rows;
framework_cols = oversampling_factor * cols;
framework = zeros(framework_rows, framework_cols);
cx = round(framework_rows/2);
cy = round(framework_cols/2);
framework(cx-floor(rows/2):cx+floor(rows/2), cy-floor(cols/2):cy+floor(cols/2)) = image;

framework_in_fourer = abs( fftshift( fft2( framework ) ) );

if output_size == 0
    output_image = framework_in_fourer(cx-floor(rows/2):cx+floor(rows/2), cy-floor(cols/2):cy+floor(cols/2));
else
    
end

end

