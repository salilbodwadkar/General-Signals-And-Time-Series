function yc = waveaudiocomp(y, Fs, r, n, Lo_D, Hi_D, Lo_R, Hi_R)
    % to obtain y and Fs, first run the function
    % [y,Fs]=audioread('Audiosample') on the audio you wish to process

    % r is the compression threshold, n is level, Lo_D, Hi_D, Lo_R, Hi_R are the
    % decomposition and reconstruction filters (respecitvely) which are
    % obtained through the scaling coefficients

    if (r < 0) ||(r>1 )
    error('r should be between 0 and 1')
    end

    [numRows,numCols]=size(y);

    y1=[zeros(1,numCols)];
    
    for i=1:numCols
        y1(i)=y(i,1);
    end

    t=(0:length(y1)-1)./Fs;
    
    % performs decomposition, compression, reconstruction
    [C,L]=waveletdec(y1, n, Lo_D, Hi_D);
    CC=compress(C,r);
    yc=waveletrec(CC,L,Lo_R, Hi_R);
    plot(t,y1,t,yc)
    err=norm(y1-yc,2)/norm(y1);
    
    
    % plays the new signal
    sound(yc,Fs)

