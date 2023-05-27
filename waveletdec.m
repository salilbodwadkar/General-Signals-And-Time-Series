function [C, L] = waveletdec(x, N, Lo_D, Hi_D)
    % x is signal, N deccomposition level, and Lo_D/Hi_D are the filters
    % obtained by the scaling coefficients 

    % remind user that legnth of x must be divisible by 2^N
    len = length(x);
    if ~(len == 2^N)
        error('Length of x should be 2^N')
    end

    C = cell(1, N+1);
    L = zeros(N+1, 2);

    % Perform wavelet decomposition
    for i = 1:N
        % Apply low-pass and high-pass filters, using 'valid' as we zero
        % pad
        A = conv(x, Lo_D, 'valid');
        D = conv(x, Hi_D, 'valid');

        % Downsample by 2
        A = downsample(A,2);
        D = downsample(D,2);

        % Store the coefficients and levels
        C{i} = D;
        L(i, :) = [length(D) length(A)];

        % Update the input signal for the next level
        x = A;
    end

    % Store the final approximation coefficients and level
    C{N+1} = x;
    L(N+1, :) = [length(x) 0];
end