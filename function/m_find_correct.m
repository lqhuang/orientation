function match = m_find_correct(reference_subscript, experiment_subscript)

[rows, ~] = size(experiment_subscript);
if rows == 0
    match = 0;
else
    match = 0;
    for i = 1:rows
        if reference_subscript == experiment_subscript(i,:);
            match = 1;
        end
    end
end

end