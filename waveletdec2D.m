function [C, L] = waveletdec2D(X, N, Lo_D, Hi_D)
    % X is input image, N is level, Lo_D/Hi_D are filters from scaling
    % coefficients
    C = cell(1, N);
    L = cell(1, N+1);
    A = X;
    for i = 1:N
        % Apply row-wise filtering
        C{i} = apply_row_filter(A, Lo_D, Hi_D);
        % Apply column-wise filtering
        C{i} = apply_column_filter(C{i}, Lo_D, Hi_D);
        % Store the size of approximation coefficients
        L{i} = size(A);
        % Downsample by 2
        A = downsample2(A);
    end
    % Store the size of the final approximation coefficients
    L{N+1} = size(A);
end