function particle = m_initial_particle(file, filter, step, fft)
% use to initial a EMD object
% In:
% file: input file. Full filepath and filename is required(.map format).
% filter: filter number of object
% fft: create fourier space or not
% Out:
% particle: struct format. inlude different information


if exist('fft','var') == 0
    fft = 'none';
end
    

% read EMD map file
if exist('file','var') == 0
    [filename, filepath] = uigetfile([pwd,'\particle\*'],'Select the EMD map file')
    file = [filepath,filename];
end
object = m_readMRCfile(file);
object(object < filter) = 0; % filter

% Does the object need to resize or not
resize_radius = input('radius after resize object, default as a cube, input a number is better:');
object_size = size(object);
object_radius = round(object_size(1)/2)-1;
resize_range = object_radius-resize_radius+1 : object_radius+resize_radius;
object = object(resize_range, resize_range, resize_range);
close

% create simulated projections
% set intervals of simlated projections
if mod(180, step) == 0
    theta = 0 : step : 360;
    psi = 0 : step : 180;
    phi = 0 : step : 360;
else
    disp('this interval is not recommended, please consider to input again.')
end


% save projections into a cell
num_theta = length(theta);
num_psi = length(psi);
num_phi = length(phi);

projection = cell(num_theta, num_psi, num_phi);
disp('begin to caculate projection');

switch fft
    case 'none'
        parfor index = 1 : num_theta * num_psi * num_phi
            [i, j, k] = ind2sub([num_theta, num_psi, num_phi], index);
            reprojection = m_projector(object, [theta(i), psi(j), phi(k)]);
            mat_mean = mean(reprojection(:));
            mat_var = var(reprojection(:));
            projection{index} = (reprojection - mat_mean) / sqrt(mat_var); % none case
            disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(k)]);
        end
    case 'fft'
        parfor index = 1 : num_theta * num_psi * num_phi
            [i, j, k] = ind2sub([num_theta, num_psi, num_phi], index);
            reprojection = m_projector(object, [theta(i), psi(j), phi(k)]);
            mat_mean = mean(reprojection(:));
            mat_var = var(reprojection(:));
            projection{index} = log( abs( fftshift( fft2( (reprojection - mat_mean) / sqrt(mat_var) ) ) ) ); % fft case
            disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(k)]);
        end
end

% delte ? ...
% normalize projection cell value
% maximum_value = find_max_value(projection);
% if maximum_value >= 255
%     parfor i = 1: num_theta
%         for j = 1:num_psi
%             for k = 1:num_phi
%                 projection{i,j,k} = projection{i,j,k} ./ maximum_value .* 255;
%             end
%         end
%     end
% end


% output information:
particle = struct;
particle.filename = filename;
particle.filter = filter;
particle.simulated_projection = projection;
particle.step = step;
particle.simulated_size = [num_theta, num_psi, num_phi];
particle.object = object;
particle.theta = theta;
particle.psi = psi;
particle.phi = phi;
% particle.maximum_value = maximum_value;
end

% function maximum = find_max_value(projection)
% [nx, ny, nz] = size(projection);
% maximum = 0;
% for i = 1:nx
%     for j = 1:ny
%         for k = 1:nz         
%             max_value = max( max( projection{i,j,k} ) );
%             if max_value > maximum
%                 maximum = max_value;
%             end         
%         end
%     end
% end
% end