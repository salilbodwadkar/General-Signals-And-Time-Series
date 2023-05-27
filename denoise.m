function gImgD = denoise(cImgUint8, n, r, Lo_D, Hi_D, Lo_R, Hi_R)
    % obtain cImgUnit 8 by cImgUint8= imread('ImageSample'); n is level, r
    % is threshold
    
    cImg=im2double(cImgUint8);
    gImg=im2gray(cImg);
    gImgNoisy=imnoise(gImg,"gaussian",0,v);
    
    [C,L]=waveletdec2D(gImgNoisy,n,Lo_D, Hi_D);
    p=prod(L(1,:))+1;
    detCeofs=C(p:length(C));
    cdet=compress(detCeofs,r);
    cc=[C(1:(p-1)) cdet];
    gImgD=waveletrec2D(cc,L,Lo_R, Hi_R);
    
    imshow(gImgD)
    imshow(gImgNoisy)
end