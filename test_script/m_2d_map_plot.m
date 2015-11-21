theta_range = 325:0.2:335;
psi_range = 55:0.2:65;

theta_length = length(theta_range);
psi_length = length(psi_range);

[Theta, Psi] = meshgrid(theta_range, psi_range);

P = round(projection_cell{11,2,4});
C2 = m_corr_function_fft(P);
C2(1,:) = [];
Corr = zeros(size(Theta));

P_Cell = cell(size(Corr));
for i = 1:leng
    for j = 1:leng
        P_Cell{i,j} = m_projector(object, [theta_range(i), psi_range(j),90]);
        P_Cell{i,j} = 154 .* P_Cell{i,j} ./ maximum + 100;
        P_Cell{i,j} = round(m_create_exp_data(P_Cell{i,j}));
%         scale_factor = P_Cell{i,j}(:) \ P(:);
%         RELION(i,j) =  sum( sum( ( P_Cell{i,j} - P ).^2 ./ (-2 .* P_Cell{i,j} ) ) ) ;
    end
end
disp('OK')


C2_Cell = cell(size(Corr));
for i = 1:leng
    for j = 1:leng
        C2_Cell{i,j} = m_corr_function_fft(P_Cell{i,j});    
        C2_Cell{i,j}(1,:) = [];
        Corr(i,j) =  sum( sum( ( C2_Cell{i,j} - C2 ).^2 ./ (-2  ) ) ) ;
    end
end


% figure
% surface(Theta, Psi, RELION)
% xlabel('\Theta')
% ylabel('\Psi')

figure
surface(Theta, Psi, Corr)
xlabel('\Theta')
ylabel('\Psi')
