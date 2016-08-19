function expImage = m_create_exp_data(simImage, sigma2, type)
%   M_CREATE_EXP_DATA Summary of this function goes here
%   simImage follows Normal(0, 1)
%   Noise follows Normal(0, sigma2)
%   normalize again, let expImage follows Normal(0, 1), too.

[rows, cols] = size(simImage);

switch type
    case 'Normal'
        expImage = simImage + normrnd(0, sqrt(sigma2), rows, cols);
%         expImage = ( expImage - mean(expImage(:)) ) / sqrt(var(expImage(:)));
    case 'Poisson'
        expImage = poissrnd(simImage);
end

end