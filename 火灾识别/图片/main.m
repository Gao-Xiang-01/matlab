%  ��������: ������
%main()
%9.4.7 
 
clc
clear
close all

%  ��ȡͼ���ļ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imgs_array = read_images();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  ��ɫͼ��ҶȻ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
colorflame_img1 = imgs_array(1).img;     %�Լ�ѡ��Kֵ����ʾ��ȡ���ļ����µڼ���ͼ��ʵ��ѡ���˵�һ��ͼ��
Gray_Img  = RGBtoGray(colorflame_img1);

figure(10)
imshow(colorflame_img1)
title('ԭʼͼ��')                    %��һ��ͼ��
figure(11)
imshow(uint8(Gray_Img.Max_Intensity))
title('���ֵ��')
figure(12)
imshow(uint8(Gray_Img.Mean_Intensity))
title('ƽ��ֵ��')
figure(13)
imshow(uint8(Gray_Img.Weight_Intensity))
title('��Ȩƽ��ֵ��')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ����5�ֱ�Ե������ӽ��б�Ե���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Extra_Edge  = operator5(colorflame_img1);
figure(14)
imshow(Extra_Edge.sobel_edge)
title('��Ե��ȡ(sobel����)')
figure(15)
imshow(Extra_Edge.prewitt_edge)
title('��Ե��ȡ(prewitt����)')
figure(16)
imshow(Extra_Edge.roberts_edge)
title('��Ե��ȡ(roberts����)')
figure(17)
imshow(Extra_Edge.log_edge)
title('��Ե��ȡ(log����)')
figure(18)
imshow(Extra_Edge.canny_edge)
title('��Ե��ȡ(canny����)')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  �����⣬������ͼ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flame_image1  = flame_detection(colorflame_img1);
figure(19)
imshow(uint8(flame_image1))
title('����ģ��������ȡ')            %��һ��ͼ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
