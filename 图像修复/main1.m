% ����ͼƬ1
close all;clear;

addpath(genpath('FFM_inpaint'));
addpath(genpath('get_mask'));

I1 = imread('img1.JPG');
I1 = imresize(I1, 0.4); %Ϊ����������ٶȣ���СͼƬ
I1_gray = rgb2gray(I1);

line1_mask = get_mask_1(I1_gray, floor(509*size(I1,1)/719));

figure;imshow(line1_mask);
new_gray=I1_gray;
new_gray(line1_mask>0)=255;
%imshow(new_gray);

result_img = inpaint_FMM( I1, uint8(line1_mask/255), 3 );
figure;imshow(result_img);

%%
close all;clear;
addpath(genpath('FFM_inpaint'));
addpath(genpath('get_mask'));

I1 = imread('a.jpg');
%%
% I2=imadjust(I1,[.2 .3 0; .6 .7 1],1.5);


I=rgb2gray(I1*0.8);
BW = imbinarize(I,'adaptive');
line1_mask=imcomplement(BW);

result_img = inpaint_FMM( I1, uint8(line1_mask), 12);

figure()
imshow(result_img)
% imshow(result_img)
