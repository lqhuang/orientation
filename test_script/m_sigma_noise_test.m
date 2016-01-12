% particle = EMD_6044_3
reprojection = m_projector(particle.object, [60, 60, 60]) ;
mat_mean = mean(reprojection(:));
mat_var = var(reprojection(:));
reprojection = (reprojection - mat_mean) / sqrt(mat_var);
sim_data = reprojection;

% euler_angle = [21, 21, 21];?
SNR = 0:1:10;
Curve = zeros(5, length(SNR));

load([path,'/corr_none_linear.mat'], 'pcimg_cell')
pcimg_cell_linear = pcimg_cell;
load([path,'/corr_none_none.mat'], 'pcimg_cell')

for i = 1:length(SNR);
    t = SNR(i);
    particle.sigma2 = t;
    for loop=1:111
        % RELION
		exp_data = m_create_exp_data(sim_data, t);
        
        %%%%%%%%%%%%%%%%%%
        exp_data = abs( fftshift( fft2(exp_data) ) );
        %%%%%%%%%%%%%%%%%%%
        
        subscript=m_par_ML_function(exp_data, particle);
        Match = m_find_correct(euler_angle, subscript);
        if Match == 1
            Curve(1,i) = Curve(1,i)+1;       
        end
        clear Match
        
		% Corr + None + None
        exp_data = m_create_exp_data(sim_data, t);
        
        %%%%%%%%%%%%%%%%%%%%%%
        exp_data = abs( fftshift( fft2(exp_data) ) );
        %%%%%%%%%%%%%%%%%%%%%%%%

        subscript=m_par_corr_method_function(exp_data, particle, pcimg_cell, 'none', 'none');
        Match = m_find_correct(euler_angle, subscript);
        if Match == 1
            Curve(2,i) = Curve(2,i)+1;
        end
		clear Match
        
        % Corr + Biliner + None
%         exp_data = m_create_exp_data(sim_data, t);
%         tic
%         subscript=m_corr_method_function(exp_data, particle.simulated_projection, 'bilinear', 'none');
%         toc
%         Match = m_find_correct(euler_angle, subscript);
%         if Match == 1
%             Curve(3,i) = Curve(3,i)+1;
%         end
        clear Match
        
		% Corr + None + Linear
		exp_data = m_create_exp_data(sim_data, t);
        
        %%%%%%%%%%%%%%%%%%%%%%%%
        exp_data = abs( fftshift( fft2(exp_data) ) );
        %%%%%%%%%%%%%%%%%%%%%%%%
        
        subscript=m_par_corr_method_function(exp_data, particle, pcimg_cell_linear, 'none', 'linear');
        Match = m_find_correct(euler_angle, subscript);
        if Match == 1
            Curve(4,i) = Curve(4,i)+1;
        end
        clear Match
		% Corr + Biliner + Linear
%         exp_data = m_create_exp_data(sim_data, t);
%         subscript=m_corr_method_function(exp_data, particle.simulated_projection, 'bilinear', 'linear');
%         Match = m_find_correct(euler_angle, subscript);
%         if Match == 1
%             Curve(5,i) = Curve(5,i)+1;
%         end
% 		clear Match
        disp(['Now,t=',num2str(t),',in Loop:',num2str(loop),10,...
              'RELION_SN=',num2str(Curve(1,i)),10,...
              'raw_1_SN=',num2str(Curve(2,i)),10,... %               'bi_1_SN=',num2str(Curve(3,i)),10,...
              'raw_2_SN=',num2str(Curve(4,i)),10,... %               'bi_2_SN=',num2str(Curve(5,i)),10,...
              '====================================================================='
             ])
    end
end
save([path,'/noise_test.mat'], 'Curve');