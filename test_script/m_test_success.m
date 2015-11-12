function [success, varargout] = m_test_success(particle, method, pcimg_interpolation, weight)
% particle = EMD_2325_30;
% method='correlation';
% pcimg_interpolation = 'none';
% weight='linear';

[nx, ny, nz] = size(particle.simulated_projection);

success = [];
for i= 2:2:nx-1
    for j = 2:2:ny-1
        for k = 2:2:nz-1
            num_suc = 0;
            for loop = 1:50;
                exp_data = m_create_exp_data(particle.simulated_projection{i,j,k}, 3)+1;
                switch method
                    case 'relion'
                        [~, subscript] = m_relion_function(exp_data, particle.simulated_projection);
                    case 'correlation'
                        [subscript] = m_corr_method_function(exp_data, particle.simulated_projection, pcimg_method, weight);
                end
                
                index = [i, j, k];
                match = m_find_correct(index, subscript);
                index
                subscript
                match
                if match == 1
                    num_suc = num_suc + 1;
                end
            end
            success = [success, num_suc];
        end
    end
end

figure
plot(success/4*100)
axis([0 length(success) 0 120])
xlabel('index of (\theta, \psi, \Phi)')
ylabel('success rate (%)')
title(['Match Test of ',method]);


index = find(success == 4);
[sub_k, sub_j, sub_i] = ind2sub([nz, ny, nx], index);
sub = [sub_i;sub_j;sub_k]';
length(sub);
success_rate = length(sub)/(nx*ny*nz);
varargout{1} = success_rate;