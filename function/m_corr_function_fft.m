function C2 = m_corr_function_fft(img, weight)
    % Using imgpolarcoord function and 
    % fourier space to creat correlation image
    
    [nx, ny] = size(img);
    cx = round(nx/2);
    cy = round(ny/2);
    pcimg = m_imgpolarcoord(img, cx, cy);
    F = fftshift( fft(pcimg, [], 2) );
    C2 = ifft( ifftshift( F .* conj(F) ), [], 2);
    
    switch weight
        case 'none'

        case 'linear'
            [rows, cols] = size(C2);
            weight = 1:rows;
            weight_Matrix = repmat(weight',1,cols);
            C2 = C2 .* weight_Matrix;
    end
    
end