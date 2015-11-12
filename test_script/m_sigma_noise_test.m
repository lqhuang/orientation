sim_data = EMD_6044_30.simulated_projection{5,6,7};
index = [5,6,7];
Curve = zeros(5,100);
T = 0.5:0.5:9
for i= 1:length(T);

    t = T(i);
    for loop=1:25
        exp_data = m_create_exp_data(sim_data, t) + 1;
        
        [~, subscript]=m_relion_function(exp_data, EMD_6044_30.simulated_projection);

        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(1,i) = Curve(1,i)+1;       
        end
        clear Match
        subscript=m_corr_method_function(exp_data, EMD_6044_30.simulated_projection, 'none', 'none');
        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(2,i) = Curve(2,i)+1;
        end
         
        subscript=m_corr_method_function(exp_data, EMD_6044_30.simulated_projection, 'bilinear', 'none');
        clear Match
        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(3,i) = Curve(3,i)+1;
        end
         
        subscript=m_corr_method_function(exp_data, EMD_6044_30.simulated_projection, 'none', 'linear');
        clear Match
        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(4,i) = Curve(4,i)+1;
        end
         
        subscript=m_corr_method_function(exp_data, EMD_6044_30.simulated_projection, 'bilinear', 'linear');

        Match = m_find_correct(index, subscript);
        if Match == 1
            Curve(5,i) = Curve(5,i)+1;
        end
        disp(['Now,t=',num2str(t),',in Loop:',num2str(loop),10,...
              'RELION_SN=',num2str(Curve(1,i)),',Time:',num2str(0),10,...
              'raw_1_SN=',num2str(Curve(2,i)),',Time:',num2str(0),10,...
              'bi_1_SN=',num2str(Curve(3,i)),',Time:',num2str(0),10,...
              'raw_2_SN=',num2str(Curve(4,i)),',Time:',num2str(0),10,...
              'bi_2_SN=',num2str(Curve(5,i)),',Time:',num2str(0),10,...
              '====================================================================='
             ])
    end
end