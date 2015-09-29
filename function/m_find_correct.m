function match = m_find_correct( index, subscript )
[nx, ny] = size(subscript);

if length(subscript) == 0
    match = 0;
else
    match = 0;
    for i = 1:nx
%         if index(1) == subscript(i, 1) & index(2) == subscript(i, 2);
        if index == subscript(i,:);
            match = 1;
        end
    end
end

end