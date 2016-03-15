function [subscript, varargout]= m_par_corr_method_function(exp_projection, particle, pcimg_cell, pcimg_interpolation, weight)
% parallel version of Correlation-ML method in orientation
% input:
% exp_projection: experiment image need to orientate
% particle: struct of particle information. 
%           PAY ATTENTION: all simulated projections are saved as
%           matrix format. And the index increasing in order of
%           phi(k), psi(j), thata(i)
% pcimg_cell: all C2 image in polar cart should calculate previously
% pcimg_interpolation: the interpolation method in creating C2 image.
% weight: weight method in C2 image.
% output:
% subscript: the subscript in simulated_projection.
% corr(optional): corrlation-maximum likelihood probability.
% prob_k(optional): maximum likelihood probability in Phi angle.

if exist('pcimg_interpolation', 'var') == 0;
    pcimg_interpolation = 'linear';
end
if exist('weight', 'var') == 0;
    weight = 'none';
end

nx = particle.simulated_size(1);
ny = particle.simulated_size(2);
nz = particle.simulated_size(3);

corr = zeros(1, nx*ny);
exp_C2 = m_corr_function_fft(exp_projection, pcimg_interpolation, weight);
% exp_C2(1, :) = [];  % extreme error happens in first line

parfor index = 1:nx*ny
    ref_C2 = pcimg_cell{index};
%     ref_C2(1, :) = []; % extreme error happens in first line
    scale_factor = exp_C2(:) \ ref_C2(:);
    exp_up_term = (exp_C2 -  scale_factor * ref_C2) .^2 ./ ( -2 * exp_C2 .^2 );
    exp_up_term( isnan(exp_up_term) ) = 0;
    exp_up_term( isinf(exp_up_term) ) = 0;
    corr(index)=sum( exp_up_term(:) );
end

        % centrosymmetry problem
        [corr_sort, index_sort] = sort(corr, 'descend');
        corr_sort = diff(corr_sort);
        num_of_ij_max = find( corr_sort(1:12) == min(corr_sort(1:12)) );
%         num_of_ij_max = 1;
        index_of_ij_max = index_sort(1:num_of_ij_max);
        [sub_i, sub_j] = ind2sub([nx, ny], index_of_ij_max);

        % normalize corr curve
        corr = exp( corr ./ 10^( round(log10(-corr_sort(1)))+1 ) );
        
        % calculate phi angle
        prob_k = zeros(num_of_ij_max, nz);
        for n = 1 : num_of_ij_max  % there is n max value in ij
            reference_projections_k = cell(1,nz);
            reference_projections_k(:) = particle.simulated_projection(sub_i(n), sub_j(n), :);
            parfor k = 1:nz
                scale_factor = exp_projection(:) \ reference_projections_k{k}(:);
                exp_up_term = ( exp_projection - scale_factor * reference_projections_k{k} ) .^2 ./ ( -2 * exp_projection );
                exp_up_term( isnan(exp_up_term) ) = 0;
                exp_up_term( isinf(exp_up_term) ) = 0;
                prob_k(n, k) = sum( exp_up_term(:) );
            end
        end
        
        % arrange the subscript
        subscript = zeros(1,3);
        for n = 1 : num_of_ij_max
            [prob_k_sort, index_k_sort] = sort(prob_k(n,:), 'descend');
            prob_k_sort = diff(prob_k_sort);
            num_of_k_max = find( prob_k_sort(1:4) == min(prob_k_sort(1:4)) );
            index_of_k_max = index_k_sort(1:num_of_k_max);
            subscript_temp = [repmat([sub_i(n), sub_j(n)],[num_of_k_max,1]),index_of_k_max'];
            subscript = [subscript; subscript_temp];
        end
        
% Output information
subscript(1,:) = [];
varargout{1} = corr;
varargout{2} = prob_k;
end