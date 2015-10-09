num_theta = length(EMD_2325_30.theta);
num_psi = length(EMD_2325_30.psi);
num_phi = length(EMD_2325_30.phi);
projection = EMD_2325_30.simulated_projection;
step = EMD_2325_30.step;

figure(1)
for i = 1:4
    subplot(1,4,i)
    x = randi(num_theta);
    y = randi(num_psi);
    z = randi(num_phi);
    imshow(projection{x, y, z}, [0 100]);
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
    imshow(exp_projection{x, y, z},[0,250]);
    xlabel(['theta=',num2str(x*step),',psi=',num2str(y*step),',phi=',num2str(z*step)]);
end