
clc;
clear;
tic
% imagepath =imread( 'chunhua.bmp');    %ԭͼ��
% maskpath =imread('chunhuamask.bmp');  %����ͼ��
% fillColor=[0,0,0];     %����ͼ���б궨����������RGB��ɫֵ
imagepath =imread( '1.png');    %ԭͼ��
maskpath =imread('2.png');  %����ͼ��
% fillColor=[255,255,0];     %����ͼ���б궨����������RGB��ɫֵ����ɫ
fillColor=[0,255,0];  %��ɫ


[Psnr,inpaintedImg] =RGB_Criminisi(imagepath,maskpath,fillColor);
toc   
  

