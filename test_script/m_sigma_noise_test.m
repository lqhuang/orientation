[success_relion,success_rate_relion] = m_test_success(EMD_6044_30, 'relion', 'none', 'none');
% [success_corr_1,success_rate_1] = m_test_success(EMD_6044_30, 'correlation', 'none', 'none');
% [success_corr_2,success_rate_2] = m_test_success(EMDCurve_6044_30, 'correlation', 'bilinear', 'none');
% [success_corr_3,success_rate_3] = m_test_success(EMD_6044_30, 'correlation', 'none', 'linear');
% [success_corr_4,success_rate_4] = m_test_success(EMD_6044_30, 'correlation', 'bilinear', 'linear');
% 

success_rate_relion = sum(success_relion)/ (50*108)
success_rate_1 = sum(success_corr_1)/ (50*108)
success_rate_2 = sum(success_corr_2)/ (5*108)
success_rate_3 = sum(success_corr_3)/ (5*108)
success_rate_4 = sum(success_corr_4)/ (5*108)
