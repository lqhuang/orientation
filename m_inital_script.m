% read EMD map file
[filename, filepath] = uigetfile([pwd,'\particle\*'],'Select the EMD map file')
file = [filepath,filename];
object = m_readMRCfile(file);

filter = input('input the filter of particle:')

object(object < filter) = 0; % filter
m_display_object(object)

% Does the object need to resize or not

resize_radius = input('radius after resize object, default as a cube, input a number is better:')
object_size = size(object);
object_radius = object_size(1)/2;
resize_range = object_radius-resize_radius+1 : object_radius+resize_radius;
object = object(resize_range, resize_range, resize_range);
close
m_display_object(object)

% create simulated projections
% set intervals of simlated projections
step = 7;
while mod(180, step) not 0
step = input('input interval of projection:');
if mod(180, step) == 0
    theta = 0 : step : 360;
    psi = 0 : step : 180;
    phi = 0 : step : 360;
else
    disp('this interval is not allowed, please input again.')
end
end

% save projections into a cell
num_theta = length(theta);
num_psi = length(psi);
num_phi = length(phi);

projection = cell(num_theta, num_psi, num_phi);
disp('begin to caculate projection');
for i = 1: num_theta
    for j = 1:num_psi
        for k = 1:num_phi
            projection{i,j,k} = m_projector(object, [theta(i), psi(j), phi(k)]);
            disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(k)]);
        end
    end
end

close
figure(1)
for i = 1:4
    subplot(1,4,i)
    x = randi(num_theta);
    y = randi(num_psi);
    z = randi(num_phi);
    imagesc(projection{x, y, z});
    xlabel(['theta=',num2str(x*step),',psi=',num2str(y*step),',phi=',num2str(z*step)]);
end

% add noise, create simlated experiment projection
exp_projection = cell(num_theta, num_psi, num_phi);

for i = 1:num_theta
    for j = 1:num_psi
        for k = 1:num_phi
            exp_projection{i,j,k} = m_create_exp_data( projection{i,j,k}+100 );
        end
    end
end

figure(2)
for i = 1:4
    subplot(1,4,i)
    x = randi(num_theta);
    y = randi(num_psi);
    z = randi(num_phi);
    imagesc(exp_projection{x, y, z});
    xlabel(['theta=',num2str(x*step),',psi=',num2str(y*step),',phi=',num2str(z*step)]);
end


EMD_2325_30 = struct;
EMD_2325_30.filename = filename;
EMD_2325_30.fileter = filter;
EMD_2325_30.simulated_projection = projection;
EMD_2325_30.exp_projection_1_sigma = exp_projection;
EMD_2325_30.step = step;
EMD_2325_30.siumlated_size = [num_theta, num_psi, num_phi];
EMD_2325_30.object = object;
EMD_2325_30.theta = theta;
EMD_2325_30.psi = psi;
EMD_2325_30.phi = phi;

save EMD_2325_30 EMD_2325_30