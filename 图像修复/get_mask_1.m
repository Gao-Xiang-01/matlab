function [line_mask] = get_mask_1(I_gray, black_area)
%���ͼƬһ�����˵�λ��

BW=imbinarize(I_gray,0.14); %��ֵ��
%figure;
BW=((1-BW).*255);
BW(black_area:end, :)=0; %ȥ������ĸ��Ų���
%imshow(BW)

[lines] = get_hough_lines(BW, 100); %hough�任��ȡֱ��

%����⵽��ֱ�߱�׼����ת����k��b��ʽ����ȥ�������ֱ��
[new_lines] = lines_integrate(lines, 10, 30);

%��������ֱ�߼�ľ��룬������©��ֱ��
delta_m = new_lines(2).m-new_lines(1).m;
for i=2:length(new_lines)
    if abs(new_lines(i+1).k)<5 %��һ����������
        middle_m = new_lines(i).m+delta_m;
        middle_k = new_lines(i).k;
        middle_b = 1-middle_k*middle_m;
        count = length(new_lines)+1;
        new_lines(count).m = middle_m; %����һ������
        new_lines(count).k = middle_k;
        new_lines(count).b = middle_b;

        break;
    end
    
    if (new_lines(i+1).m-new_lines(i).m)>1.5*delta_m %�м�ȱһ����
        middle_m = (new_lines(i+1).m+new_lines(i).m)/2;
        middle_k = (new_lines(i+1).k+new_lines(i).k)/2;
        middle_b = 1-middle_k*middle_m;
        count = length(new_lines)+1;
        new_lines(count).m = middle_m;
        new_lines(count).k = middle_k;
        new_lines(count).b = middle_b;
    else
        delta_m = new_lines(i+1).m-new_lines(i).m;
    end
end

%figure;
%imshow(I_gray); hold on;
% for i=1:length(new_lines)
%     line=new_lines(i);
%     p1=[0 -line.b/line.k];
%     p2=[size(I_gray,2) (size(I_gray,2)-line.b)/line.k];
%     plot([p1(1) p2(1)], [p1(2) p2(2)],'LineWidth',2,'Color','green');
% end

%����ֱ��λ�õõ�mask
line_width=floor(2*size(I_gray)/719);
[line_mask] = maskFromlines(I_gray, line_width, new_lines, black_area, 30, false);

%imshow(uint8(line_mask));