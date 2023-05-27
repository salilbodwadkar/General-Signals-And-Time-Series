function X = waveletrec2D(C, L, Lo_R, Hi_R)
    % Lo_R/Hi_R are filters from scaling
    % coefficients
    N = length(C);
    A = C{N};
    for i = N:-1:1
        % Upsample by 2
        A = upsample2(A);
        % Apply column-wise synthesis filters
        A = apply_column_filter(A, Lo_R, Hi_R, L{i}(1));
        % Apply row-wise synthesis filters
        A = apply_row_filter(A, Lo_R, Hi_R, L{i}(2));
        % Add the detail coefficients to the approximation
        A = A + C{i};
    end
    X = A;
end