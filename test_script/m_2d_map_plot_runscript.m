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

phi_range = 0:0.5:180;
theta_range = 0:0.5:90;
phi_length = length(phi_range);
theta_length = length(theta_range);

sim_projection_matrix = zeros(120,120, phi_length*theta_length);

parfor index = 1: phi_length*theta_length
	[i,j]=ind2sub([phi_length, theta_length], index)
	sim_projection_matrix(:,:,index) = m_projector(object, [phi_range(i), theta_range(j), 60]);
    disp(['now, index=',num2str(index)]);
end
save /mnt/data/lqhuang/2Dmap/sim_projection_matrix.mat sim_projection_matrix
exp_index = sub2ind([phi_length, theta_length], 121, 121);
exp_projection = m_create_exp_data(sim_projection_matrix(:,:,exp_index), 1) + 1;
disp('complete build sim_projection_matrix')
[Phi, Theta] = meshgrid(phi_range, theta_range);
% 'Maximum Likelihood'
[prob] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, 'ML', 'none', 'none');
prob = reshape(prob, phi_length, theta_length);
disp('finish ML');
%%
method = 'corr';
% 'Corr+None+None'
[corr_1] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, method, 'none', 'none');
corr_1=reshape(corr_1, phi_length, theta_length);
% 'Corr+Bilinear+None'
[corr_2] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, method, 'bilinear', 'none');
corr_2=reshape(corr_2, phi_length, theta_length);
disp('finish none weight');
% 'Corr+None+Linear Weight'
[corr_3] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, method, 'none', 'linear');
corr_3=reshape(corr_3, phi_length, theta_length);
% 'Corr+None+Linear'
[corr_4] = m_2d_map_plot_function(exp_projection, sim_projection_matrix, method, 'bilinear', 'linear');
corr_4=reshape(corr_4, phi_length, theta_length);
disp('finish weight');
save /mnt/data/lqhuang/2Dmap/2Dmap.mat Phi Theta prob corr_1 corr_2 corr_3 corr_4
disp('finish all');