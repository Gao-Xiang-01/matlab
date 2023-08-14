%��͹�ַ��ָ�
clc;clear;close all;
addpath('util/');
addpath('ӡˢ/');
inputpath='ӡˢ/';
fdir=dir(strcat(inputpath,'*.jpg'));

% fdir='a1.jpg'

p=size(fdir);
method=2;%��λ����
levelth=0.3;%ˮƽ�ָ�������ֵ
for i=1:p(1)
im=imread(fdir(i).name);
imtp=imresize(im,0.25);
%ͼ��ҶȻ�
if(length(size(im))>1)
    im=double(rgb2gray(im));
else
    im=double(im);
end
    im=imresize(im,0.25);
    
    th=graythresh(im);
    pt=size(im);
    
%��ȡ����λ��  
    if(method==1)
       im=GuassSmoothfilter(im)*255;%ƽ��
       cent=2;
       [Labels,BW]=KmeansSg(im,cent);%kmeans����
       [pMax,pMin]=Findline(BW);%Hough�任
       downlevel=pMax.y-(pMax.y-pMin.y)*0.30;
       uplevel=pMin.y+(pMax.y-pMin.y)*0.55;
    else
       [pMax,pMin,pxMax,pxMin]=levelSg(im,levelth);%ˮƽ���ָ�
       downlevel=pMax-(pMax-pMin)*0.29;
       uplevel=pMin+(pMax-pMin)*0.55;
    end
    pxMin=pxMin+40;pxMax=pxMax-20;
   imcrop=im(uplevel:downlevel,pxMin:pxMax);%��λ���п���
   po=size(imcrop);
   imtpcrop=zeros(po(1),po(2),3);
   imtpcrop(1:po(1),:,1)=imtp(uplevel:downlevel,pxMin:pxMax,1);
   imtpcrop(1:po(1),:,2)=imtp(uplevel:downlevel,pxMin:pxMax,2);
   imtpcrop(1:po(1),:,3)=imtp(uplevel:downlevel,pxMin:pxMax,3);
   figure;
   imshow(imcrop,[]);title('�Ҷ��и�')
   figure;
   imshow(imtpcrop,[]);title('��ɫ�и�')
   
   srcyuv=rgb2yuv(imtpcrop);%rgbת��ΪYUVͨ��
   figure;
   imshow(srcyuv(:,:,2),[]);title('yuvͨ��')
   
   
   figure;
   B=im2bw(uint8(imcrop),0.2);
   imshow(B,[]);title('��ֵ��')
   edg=edge(srcyuv(:,:,3),'sobel');%canny��Ե���
   figure;imshow(edg,[]);title('��Ե')
   %[L,num] = bwlabel(~B,4);%��ȡ��ͨ����
   imwrite(uint8((~B)*255),'x.jpg');
 
   B=uint8((~B)*255);
   cropAllx(edg,imcrop)%���ղü�
%    recognizex%����ʶ��
   
end