function imgs_array = read_images()
  %9.4.1
%  �������ܣ���ȡ�ļ����������ͼ��
%  �������������Ҫ�������
%  ���������imgs_array   �ṹ�壬��������ͼ��
pathname = 'C:\Users\86182\Desktop\Fire\ͼƬ\';
%pathname=uigetfile({'*.jpg;*.bmp;*.tif;*.png;*.gif','All Image Files';'*.*','All Files'});
cd(pathname);
files = dir('*.jpg');
 
K = size(files,1);
imgs_array = [];

for i=1:K
    temp = imread(files(i).name);
    imgs_array(i).img = temp;
end

