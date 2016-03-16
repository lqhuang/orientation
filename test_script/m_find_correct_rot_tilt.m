function match = m_find_correct_rot_tilt(reference_subscript, experiment_subscript)

[rows, ~] = size(experiment_subscript);
if rows == 0
    match = 0;
else
    match = 0;
    for i = 1:rows
        if and(reference_subscript(1) == experiment_subscript(i,1),  reference_subscript(2) == experiment_subscript(i,2));
            match = 1;
        end
    end
end

end