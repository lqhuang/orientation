function [loose_match, varargout] = m_find_correct(reference_subscript, experiment_subscript, mode)

if exist('mode', 'var') == 0
    mode = 'none';
end

[rows, ~] = size(experiment_subscript);
position = 0;
if rows == 0
    loose_match = 0;
else
    loose_match = 0;
    for i = 1:rows
        if reference_subscript == experiment_subscript(i,:);
            loose_match = 1;
            position = i;
            break
        end
    end
end

% if strcmp(mode, 'real') && (poission == 1) % fourier space 和 找到位置== 1 要同时成立
%     varargout{1} = 1;
% elseif strcmp(mode, 'fourier') && (poission <= 2) % fourier space 和 找到位置<=2 要同时成立
% 	varargout{1} = 1;
% else
%     varargout{1} = 0;
% end

varargout{1} = position;

end