[filename, filepath] = uigetfile([pwd,'\particle\*'],'Select the EMD map file')
file = [filepath,filename];
object = m_readMRCfile(file);
filter = 30.4;
object(object < filter) = 0;  % filter
resize_radius = 60;
object_size = size(object);
object_radius = round(object_size(1)/2)-1;
resize_range = object_radius-resize_radius+1 : object_radius+resize_radius;
object = object(resize_range, resize_range, resize_range);

theta_range = 0:0.5:180;
psi_range = 0:0.5:90;
theta_length = length(theta_range);
psi_length = length(psi_range);

sim_projection_matrix = zeros(120,120, theta_length*psi_length);

parfor index = 1: theta_length*psi_length
	[i,j]=ind2sub([theta_length, psi_length], index)
	sim_projection_matrix(:,:,index) = m_projector(object, [theta_range(i), psi_range(j), 60]);
    disp(['now, index=',num2str(index)]);
end
save /mnt/data/lqhuang/2Dmap/sim_projection_matrix.mat sim_projection_matrix
exp_index = sub2ind([theta_length, psi_length], 121, 121);
exp_projection = m_create_exp_data(sim_projection_matrix(:,:,exp_index), 1) + 1;
disp('complete build sim_projection_matrix')
[Theta, Psi] = meshgrid(theta_range, psi_range);
% 'Maximum Likelihood'
[prob] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, 'ML', 'none', 'none');
prob = reshape(prob, theta_length, psi_length);
disp('finish ML');
%%
method = 'corr';
% 'Corr+None+None'
[corr_1] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, method, 'none', 'none');
corr_1=reshape(corr_1, theta_length, psi_length);
% 'Corr+Bilinear+None'
[corr_2] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, method, 'bilinear', 'none');
corr_2=reshape(corr_2, theta_length, psi_length);
disp('finish none weight');
% 'Corr+None+Linear Weight'
[corr_3] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, method, 'none', 'linear');
corr_3=reshape(corr_3, theta_length, psi_length);
% 'Corr+None+Linear'
[corr_4] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, method, 'bilinear', 'linear');
corr_4=reshape(corr_4, theta_length, psi_length);
disp('finish weight');
save /mnt/data/lqhuang/2Dmap/2Dmap.mat Theta Psi prob corr_1 corr_2 corr_3 corr_4
disp('finish all');