function x = waveletrec(C, L, Lo_R, Hi_R)
    % C,L are as in waveletdec.m, Lo_R,Hi_R are the filters obtained from
    % scaling coefficients
    N = size(L, 1) - 1;

    % retrieve the final approximation coefficients
    x = C{N+1};

    % Perform wavelet reconstruction
    for i = N:-1:1
        % Upsample by 2 and apply reconstruction filters
        x = upsample(x, 2);
        x = conv(x, Lo_R, 'valid');
        x = x(1:length(x)-length(Lo_R)+1);

        % Retrieve the detail coefficients for the current level
        D = C{i};

        % Upsample by 2 and apply reconstruction filters
        D = upsample(D, 2);
        D = conv(D, Hi_R, 'valid');
        D = D(1:length(D)-length(Hi_R)+1);

        % Combine the approximation and detail coefficients
        x = x + D;
    end
end