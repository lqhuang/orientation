function C2 = m_corr_function_fft(img, pcimg_interpolation, weight)
    % Using different interpolation and fourier space to creat correlation image
    % input:
    % img: the image need to change
    % pcimg_interpolation: 
    %   'nearest' --> nearest interpolation imgpolarcoord function
    %   'linear' --> linear interpolation 
    %   'bilinear' --> ImToPolar function
    % weight:
    %   'none' --> no weight
    %   'linear' --> weight = 1:radius
    % output:
    % C2: the correlation image
    
    if exist('pcimg_interpolation', 'var') == 0
        pcimg_interpolation = 'nearest';
    end
    if exist('weight', 'var') == 0
        weight = 'none';
    end
    
    [nx, ny] = size(img);
    cx = round(nx/2);
    cy = round(ny/2);
    switch pcimg_interpolation
        case 'nearest'
            pcimg = m_imgpolarcoord(img, cx, cy);
        case 'linear'
            if (nx/2) - floor(nx/2) == 0
                [xs, ys]=meshgrid(1:nx-1,1:ny-1);
            else
                [xs, ys]=meshgrid(1:nx,1:ny);
            end
            radius = min([nx-cy, ny-cx]);
            pcimg = m_imgpolarcoord3(img, xs, ys, cx, cy, radius, radius, 360);
        case 'bilinear'
            pcimg = m_ImToPolar(img, 0, 1, 60, 360);
    end
	
    F = fftshift( fft(pcimg, [], 2) );
    C2 = ifft( ifftshift( F .* conj(F) ), [], 2 );
    [rows, cols] = size(C2);
    switch weight
        case 'none'

        case 'linear'
            weight = 1:rows;
            weight_Matrix = repmat(weight', 1, cols);
            C2 = C2 .* weight_Matrix;
    end
%     meanC2Row = mean(C2,2);
%     C2 = C2 - repmat(meanC2Row, 1, cols);
end