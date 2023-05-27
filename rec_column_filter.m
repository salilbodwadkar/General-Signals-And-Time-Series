function Y = rec_column_filter(X, Lo, Hi, size_out)
    % Apply column-wise filtering to the input matrix X
    L = length(Lo);
    Lo = fliplr(Lo');
    Hi = fliplr(Hi');
    Y = conv2(X, Lo, 'same');
    Y(1:L-1, :) = Y(1:L-1, :) + conv2(X(end-L+2:end, :), Hi, 'same');
    Y = Y(1:size_out, :);
end