%ѵ�����п�������(����������Ŀ������)----hty
clc;
clear;
close all
trainNum=2;
for classnum=0:9
for kk=0:trainNum-1 
    %p1=ones(28,28);% ��ʼ��28��28�Ķ�ֵͼ������ֵ(ȫ��)
    switch classnum
        case 0 
            m =strcat('trainx\0\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)  
        case 1
             m =strcat('trainx\1\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)  
        case 2
             m =strcat('trainx\2\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 3
             m =strcat('trainx\3\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 4
             m =strcat('trainx\4\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 5
             m =strcat('trainx\5\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 6
             m =strcat('trainx\6\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 7
             m =strcat('trainx\7\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 8
             m =strcat('trainx\8\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 9
             m =strcat('trainx\9\',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
    end
    x=imread(m,'jpg');% ����ѵ������ͼ���ļ�  
    if(length(size(x))>2)
        x=rgb2gray(x);
    end
%     [labels,bw]=KmeansSg(x,3);
%     if(classnum==0||classnum==4)
%     [L, num] = bwlabel(bw, 8);
%     for i=1:num
%         if(size(find(L==i))<300)
%             bw(L==i)=0;
%         end
%     end
%     end
%         figure;
%     imshow(bw,[]);
%     bw=Otsu(x);
%     bw=edge(x,'canny');
%     bw=im2bw(x,0.25);% �������ѵ������ͼ��ת��Ϊ��ֵͼ��  
%     figure;
%     imshow(bw,[]);
%     bw=im2uint8(bw);
    bw=imresize(x,[28,28]);
%     figure;
%     imshow(bw,[]);
%     [i,j]= find(bw==0);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)���кź��к�  
%     imin=min(i);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)����С�к� 
%     imax=max(i);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)������к�   
%     jmin=min(j);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)����С�к�   
%     jmax=max(j);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)������к�   
%     bw1=bw(imin:imax,jmin:jmax);% ��ȡͼ������ֵΪ0(��)������������ 
%    % rate=28/max(size(bw1));% �����ȡͼ��ת��Ϊ28��28�Ķ�ֵͼ������ű���(�������ű���  
%                                % ���������²�Ϊ28�ı���,���Կ��ܴ���ת�����)
%     bw1=imresize(bw1,[28,28]);% ����ȡͼ��ת��Ϊ28��28�Ķ�ֵͼ�� 
%   % [i,j]=size(bw1);% ת��ͼ��Ĵ�С   
%  %  i1=round((28-i)/2);% ����ת��ͼ�����׼28��28��ͼ�����߽��    
%  %  j1=round((28-j)/2);% ����ת��ͼ�����׼28��28��ͼ����ϱ߽��    
%  %  p1(i1+1:i1+i,j1+1:j1+j)=bw1;% ����ȡͼ��ת��Ϊ��׼��28��28��ͼ�� 
%    p1=bw1;
%    p1= -1.*p1+ones(28,28);% ��ɫ����    % ��ͼ�������γ��������������� 
%    for m=0:27      
%    p(m*28+1:(m+1)*28,kk+1)=bw(1:28,m+1);   
%    end    % �γ�������Ŀ������  
   train_x(:,:,kk+1+trainNum*classnum)=bw;
   train_y(kk+1+trainNum*classnum,classnum+1)=1;%ѵ��������ǩ
end
end
% for kk=0:9
%     m =strcat('train_nums\num',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)    
%     x=imread(m,'jpg');% ����ѵ������ͼ���ļ�   
%     bw=im2bw(x,0.5);% �������ѵ������ͼ��ת��Ϊ��ֵͼ��  
%     bw=im2uint8(bw);
%     bw=imresize(bw,[28,28]);
%     train_x(:,:,kk+27)=bw;
%     train_y(kk+27,kk+27)=1;%ѵ��������ǩ
% end


%���ֵ���ѵ��
% for kk=0:6
%     m =strcat('train_word\hanzi',int2str(kk+1),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)    
%     x=imread(m,'jpg');% ����ѵ������ͼ���ļ�   
%     bw=im2bw(x,0.5);% �������ѵ������ͼ��ת��Ϊ��ֵͼ��  
%     bw=im2uint8(bw);
%     bw=imresize(bw,[28,28]);
%     train_x(:,:,kk+1)=bw;
%     train_y(kk+1,kk+1)=1;%ѵ��������ǩ
% end
testNum=1;
test_y=zeros(10,5);
trainNum=0;%��������
for classnum1=0:9
for k=0:testNum-1
    %p2=ones(28,28);% ��ʼ��28��28�Ķ�ֵͼ������ֵ(ȫ��)   
     switch classnum1
        case 0 
             m2 =strcat('test\0\',int2str(k+1+trainNum),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)  
        case 1
             m2 =strcat('test\1\',int2str(k+1+trainNum)','.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)  
        case 2
             m2 =strcat('test\2\',int2str(k+1+trainNum),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 3
             m2 =strcat('test\3\',int2str(k+1+trainNum),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 4
             m2 =strcat('test\4\',int2str(k+1+trainNum),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 5 
             m2 =strcat('test\5\',int2str(k+1+trainNum),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)  
        case 6
             m2 =strcat('test\6\',int2str(k+1+trainNum)','.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)  
        case 7
             m2 =strcat('test\7\',int2str(k+1+trainNum),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 8
             m2 =strcat('test\8\',int2str(k+1+trainNum),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
        case 9
             m2 =strcat('test\9\',int2str(k+1+trainNum),'.jpg');% �γ�ѵ������ͼ����ļ���(0��259.bmp)
     end 
    x=imread(m2,'jpg');% ����ѵ������ͼ���ļ�   
     if(length(size(x))>2)
        x=rgb2gray(x);
    end
    bw=imresize(x,[28,28]);
%     [i,j]= find(bw==0);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)���кź��к�  
%     imin=min(i);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)����С�к� 
%     imax=max(i);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)������к�   
%     jmin=min(j);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)����С�к�   
%     jmax=max(j);% Ѱ�Ҷ�ֵͼ��������ֵΪ0(��)������к�   
%     bw2=bw(imin:imax,jmin:jmax);% ��ȡͼ������ֵΪ0(��)������������ 
%    % rate=28/max(size(bw1));% �����ȡͼ��ת��Ϊ28��28�Ķ�ֵͼ������ű���(�������ű���  
%                                % ���������²�Ϊ28�ı���,���Կ��ܴ���ת�����)
%     bw2=imresize(bw2,[28,28]);% ����ȡͼ��ת��Ϊ28��28�Ķ�ֵͼ�� 
%   % [i,j]=size(bw1);% ת��ͼ��Ĵ�С   
%  %  i1=round((28-i)/2);% ����ת��ͼ�����׼28��28��ͼ�����߽��    
%  %  j1=round((28-j)/2);% ����ת��ͼ�����׼28��28��ͼ����ϱ߽��    
%  %  p1(i1+1:i1+i,j1+1:j1+j)=bw1;% ����ȡͼ��ת��Ϊ��׼��28��28��ͼ�� 
%    p2=bw2;
%    p2= -1.*p2+ones(28,28);% ��ɫ����    % ��ͼ�������γ��������������� 
%    for m=0:27       
%    test_x(m*28+1:(m +1)*28,k+1)=bw(1:28,m+1);   
%    end    % �γ�������Ŀ������  
   test_x(:,:,k+1+testNum*classnum1)=bw;
   test_y(k+1+testNum*classnum1,classnum1+1)=1;
% switch k   
%     case{0,5}  % ��ĸA       
%     test_y(k+1,1)=1;   
%     case{1,6} % ��ĸB    
%     test_y(k+1,2)=1;    
%     case{2,7}  % ��ĸC      
%     test_y(k+1,3)=1;    
%     case{3,8}  % ��ĸD      
%     test_y(k+1,4)=1;    
%     case{4,9}  %��ĸE           
%     test_y(k+1,5)=1;       
%     case{5,31}  %��ĸF        
%     test_y(k+1,6)=1;    
%     case{6,32}  % ��ĸG       
%     test_y(k+1,7)=1;     
%     case{7,33}  % ��ĸH        
%     test_y(k+1,8)=1;            
%     case{8,34}  % ��ĸI     
%     test_y(k+1,9)=1;       
%     case{9,35}  % ��ĸJ      
%     test_y(k+1,10)=1; 
%     case{10,36}  % ��ĸK     
%     test_y(k+1,11)=1;
%     case{11,37}  % ��ĸL     
%     test_y(k+1,12)=1; 
%     case{12,38}  % ��ĸM    
%     test_y(k+1,13)=1; 
%     case{13,39}  % ��ĸN     
%     test_y(k+1,14)=1;
%     case{14,40}  % ��ĸO      
%     test_y(k+1,15)=1;
%     case{15,41}  % ��ĸP      
%     test_y(k+1,16)=1;
%     case{16,42}  % ��ĸQ      
%     test_y(k+1,17)=1; 
%     case{17,43}  % ��ĸR     
%     test_y(k+1,18)=1; 
%     case{18,44}  % ��ĸS     
%     test_y(k+1,19)=1; 
%     case{19,45}  %��ĸT     
%     test_y(k+1,20)=1; 
%     case{20,46}  % ��ĸU     
%     test_y(k+1,21)=1;
%     case{21,47}  % ��ĸV      
%     test_y(k+1,22)=1; 
%     case{22,48}  % ��ĸW      
%     test_y(k+1,23)=1;
%     case{23,49}  % ��ĸX    
%     test_y(k+1,24)=1; 
%     case{24,50}  % ��ĸY     
%     test_y(k+1,25)=1; 
%     case{25,51}  % ��ĸZ      
%     test_y(k+1,26)=1;    
% end
end
end
%save LT test_x test_y;  

save all_data_labelsx train_x train_y test_x test_y;    % �洢�γɵ�ѵ��������(����������Ŀ������)
disp('����������Ŀ���������ɽ�����')