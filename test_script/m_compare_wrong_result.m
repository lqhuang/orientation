figure(1)
p_1 = m_create_exp_data( projection{2,2,2} + 100 );
p_1_2 = m_create_exp_data( projection{2,2,4} + 100 );
p_right = projection{2,2,2};
p_wrong = projection{2,5,1};

c_1=m_corr_function_fft(p_1,'none');
c_1_2=m_corr_function_fft(p_1_2,'none');
c_right = m_corr_function_fft(p_right,'none');
c_wrong = m_corr_function_fft(p_wrong,'none');

subplot(2,4,1);imagesc(p_1,[0 max(max(p_1))]);title('30�ȣ�30�ȣ�30��');
subplot(2,4,2);imagesc(p_1_2,[0 max(max(p_1_2))]);title('30�ȣ�30�ȣ�90��');
subplot(2,4,3);imagesc(p_right);title('��ȷ��')
subplot(2,4,4);imagesc(p_wrong);title('��������ĽǶ�(�����)(60��120��330)')

subplot(2,4,5);imagesc(c_1);colorbar;title('��һ��ͼ')
subplot(2,4,6);imagesc(c_1_2);colorbar

subplot(2,4,7);imagesc(c_right);colorbar;title('�͵�һ��ͼ��Corr:-9.0312e10')
subplot(2,4,8);imagesc(c_wrong);colorbar;title('�͵�һ��ͼ��Corr:-7.8334e10')

scale_factor = c_1(:) \ c_right(:);
Corr_1= sum(sum( (c_1 - scale_factor * c_right ).^2  ./ (-2 * c_1 ) )) 
scale_factor = c_1(:) \ c_wrong(:);
Corr_2= sum(sum( (c_1 - scale_factor * c_wrong ).^2  ./ (-2 * c_1 ) )) 

% 
% figure(2)
% p_1 = m_create_exp_data( projection{3,2,2})+100;
% p_1_2 = m_create_exp_data( projection{3,2,9})+100;
% 
% c_1=m_corr_function_fft(p_1,'none');
% c_1_2=m_corr_function_fft(p_1_2,'none');
% 
% subplot(2,2,3);imagesc(c_1);colorbar;subplot(2,2,4);imagesc(c_1_2);colorbar
%  
% subplot(2,2,1);imagesc(p_1,[0 max(max(p_1))]);title('60�ȣ�60�ȣ�60��');
% subplot(2,2,2);imagesc(p_1_2,[0 max(max(p_1_2))]);title('60�ȣ�60�ȣ�120��');
%