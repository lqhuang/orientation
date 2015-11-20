particle = EMD_6044_30;
sim_data = particle.simulated_projection{4,5,6};
index = [4,5,6];
Curve = zeros(5,100);
T = 0.5:0.5:9;
for i= 1:length(T);
    t = T(i);
    for loop=1:25
        % RELION
		exp_data = m_create_exp_data(sim_data, t) + 1;
        subscript=m_relion_function(exp_data, particle.simulated_projection);
        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(1,i) = Curve(1,i)+1;       
        end
        clear Match
		% Corr + None + None
        exp_data = m_create_exp_data(sim_data, t) + 1;
        subscript=m_corr_method_function(exp_data, particle.simulated_projection, 'none', 'none');
        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(2,i) = Curve(2,i)+1;
        end
		clear Match
        % Corr + Biliner + None
        exp_data = m_create_exp_data(sim_data, t) + 1;
        tic
        subscript=m_corr_method_function(exp_data, particle.simulated_projection, 'bilinear', 'none');
        toc
        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(3,i) = Curve(3,i)+1;
        end
        clear Match
		% Corr + None + Linear
		exp_data = m_create_exp_data(sim_data, t) + 1;
        subscript=m_corr_method_function(exp_data, particle.simulated_projection, 'none', 'linear');
        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(4,i) = Curve(4,i)+1;
        end
        clear Match
		% Corr + Biliner + Linear
        exp_data = m_create_exp_data(sim_data, t) + 1;
        subscript=m_corr_method_function(exp_data, particle.simulated_projection, 'bilinear', 'linear');
        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(5,i) = Curve(5,i)+1;
        end
		clear Match
        disp(['Now,t=',num2str(t),',in Loop:',num2str(loop),10,...
              'RELION_SN=',num2str(Curve(1,i)),10,...
              'raw_1_SN=',num2str(Curve(2,i)),10,...
              'bi_1_SN=',num2str(Curve(3,i)),10,...
              'raw_2_SN=',num2str(Curve(4,i)),10,...
              'bi_2_SN=',num2str(Curve(5,i)),10,...
              '====================================================================='
             ])
    end
end