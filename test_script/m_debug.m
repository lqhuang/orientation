step = 30;

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
for index = 1 : num_theta * num_psi * num_phi
    [i, j, k] = ind2sub([num_theta, num_psi, num_phi], index);
    disp([theta(i), psi(j), phi(k)]);
    disp(['i=',num2str(i),',j=',num2str(j),',k=',num2str(k)]);
end