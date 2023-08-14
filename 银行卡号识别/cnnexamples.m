clear; close all; clc;  
% addpath('../data');  
% addpath('../util'); 

% load PT;
% load('data/mnist_uint8.mat');
%load LT;
load all_data_labelsx.mat
%   
% train_x = double(reshape(train_x,28,28,140))/255;%ѵ������Ϊ28*28�ľ����ܹ���30������
% test_x = double(reshape(test_x,28,28,1))/255;  
% train_y = double(train_y'); 
% test_y =double(test_y');  
p_train=size(train_y);
p_test=size(test_y);
num=p_train(1);%ѵ��������
testnum=p_test(1);%���Լ�����
% train_x = double(reshape(p,28,28,num))/255; 
% test_x = double(reshape(test_x,28,28,testnum))/255; 
% train_y = double(t');  
% test_y =double(test_y'); 



% train_x = double(reshape(train_x,28,28,num))/255; 
% test_x = double(reshape(test_x,28,28,testnum))/255; 
train_x=double(train_x);
test_x=double(test_x);
train_y = double(train_y');  
test_y =double(test_y'); 
% 
% figure(1)
% 
%       for k=1:10
% %     k=fix(i/10+1);
%             subplot(fix(10/10+1),10,k);imshow(train_x(:,:,k),[]);title(num2str(k));
%       end
% figure(2)
% 
%       for k=1:testnum
% %     k=fix(i/10+1);
%             subplot(fix(testnum/10+1),10,k);imshow(test_x(:,:,k),[]);title(num2str(k));
%       end
cnn.layers = {  
    struct('type', 'i') %input layer  
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer  
    struct('type', 's', 'scale', 2) %sub sampling layer  
    struct('type', 'c', 'outputmaps', 10, 'kernelsize', 5) %convolution layer  
    struct('type', 's', 'scale', 2) %subsampling layer  
%     struct('type', 'c', 'outputmaps', 20, 'kernelsize', 5) %convolution layer 
%     struct('type', 's', 'scale', 2) %subsampling layer
};  %6 10 0.08 500 28% error
  
% �����cnn�����ø�cnnsetup������ݴ˹���һ��������CNN���磬������  
cnn = cnnsetup(cnn, train_x, train_y);  
  
% ѧϰ��  
opts.alpha = 0.09;  
% ÿ������һ��batchsize��batch��ѵ����Ҳ����ÿ��batchsize�������͵���һ��Ȩֵ��������  
% �����������������ˣ�������������������˲ŵ���һ��Ȩֵ  
% BatchSize������С�� ͨ�����������ݿ��������������
opts.batchsize =1;   
% ѵ����������ͬ��������������ѵ����ʱ��  
%��д���ּ���60��ѵ������ 10������������
% 100��ʱ�� 0% error
% 50��ʱ�� 3.333%error  0%error 0.5s
% 10��ʱ�� 80% error  
%��д���ּ���140��ѵ������ 40������������
%10��ʱ��  25% error 6.5s
%50       2.5% errorÿ��6.5s
%100      2.5% errorÿ��6.5s 
opts.numepochs=1000;  
  
% Ȼ��ʼ��ѵ��������������ʼѵ�����CNN����  
cnn = cnntrain(cnn, train_x, train_y, opts);  

%������ǩ�Ĳ�������
% kk=0;
% m =strcat('test_letters\',int2str(kk),'.jpg');% �γ�ѵ������ͼ����ļ���(100-139.jpg)
% x=imread(m,'jpg');% ����ѵ������ͼ���ļ�   
% bw=im2bw(x,0.5);% �������ѵ������ͼ��ת��Ϊ��ֵͼ��  
% bw=im2uint8(bw); 
% for m=0:27%��������
%    test(m*28+1:(m +1)*28,1)=bw(1:28,m+1); 
% end
% test=double(reshape(test,28,28,1))/255; 
% net=cnnff2(cnn,test);
% [~,h]=max(net.o);
% disp(['ʶ������' num2str(h-1) ]);

% ����ǩ�Ĳ�������
k=size(test_x,3);
er=0;%ͳ�ƴ���ʶ��ĸ���
for i=1:k
    fprintf('��%d��ͼƬ��ʶ�������\n',i);
    bad = cnntest(cnn, test_x(:,:,i), test_y(:,i)); %er��ʶ�����ĸ�����������ַ���֮�� 
    er=er+numel(bad);
   % disp(['size(bad)=' num2str(size(bad))]);
   % disp(['bad=' num2str(numel(bad))]);
    %disp(['ernum=' num2str((er)) ]);
end
disp(['���������' num2str(er)]);
%disp(['size(test_y, 2)=' num2str(size(test_y, 2))]);
er = er / size(test_y, 2); % ���������,size(y, 2)�ǲ������������� 
 %plot mean squared error  
plot(cnn.rL);  % ���ۺ���ֵ��Ҳ����ѵ������ʱ��ľ������ֵ��
title('\bf���ۺ���--��������');
xlabel('\bf��������');
ylabel('\bf���ۺ���H(W,b)');
 %show test error  
disp([num2str(er*100) '% error']); 
save all_data_cnnx cnn





 