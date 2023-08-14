function [line_mask] = maskFromlines(I_gray, line_width, new_lines, black_area, find_len, upLineFind)
%����ֱ��λ�õõ�mask����ֱ�߸����Ҷ�ֵ�͵Ĳ���maskֵΪ1����������maskΪ0

line_mask=zeros(size(I_gray));
for i=1:length(new_lines)
    line = new_lines(i);
    if abs(line.k)==inf
        continue;
    end
    
    if abs(line.k)>5 %����
        for p_j=1:size(I_gray,2) %ֱ��������������
           p_i=(p_j - line.b)/line.k; %ֱ���϶�Ӧ�ĺ�����
           if p_i<1 || p_i>size(I_gray,1)
               continue;
           end
           
           if p_i>black_area
               min_i = p_i;
           else
               find_dis=find_len;
               if p_i-find_dis<1
                   find_dis=p_i-1;
               end
               if p_i+find_dis>size(I_gray,1)
                   find_dis=size(I_gray,1)-p_i;
               end
               [min_g, min_i] = min(I_gray(floor(p_i-find_dis):floor(p_i+find_dis), p_j)); %ֱ���ϸõ�ͬһ�и�����Сֵ��
               min_i = p_i-find_dis+min_i-1;
           end
           
           for mask_i=min_i-line_width:min_i+line_width %��Сֵ�㸽���ĺڵ�
              if mask_i<1 || mask_i>size(I_gray,1)
                continue;
              end
              line_mask(floor(mask_i), p_j)=255;
           end
        end
    else %����
        for p_i=1:size(I_gray,1) %ֱ�������к�����
           p_j=p_i*line.k+line.b; %ֱ���϶�Ӧ��������
           if p_j<1 || p_j>size(I_gray,2)
               continue;
           end
           
           if upLineFind==true
               find_dis=find_len;
               if p_j-find_dis<1
                   find_dis=p_j-1;
               end
               if p_j+find_dis>size(I_gray,2)
                   find_dis=size(I_gray,2)-p_j;
               end
               [min_g, min_j] = min(I_gray(p_i, floor(p_j-find_dis):floor(p_j+find_dis))); %ֱ���ϸõ�ͬһ�и�����Сֵ��
               min_j = p_j-find_dis+min_j-1;
           else
               min_j=p_j;
           end
           
           for mask_j=min_j-line_width-1:min_j+line_width+1 %��Сֵ�㸽���ĺڵ�
              if mask_j<1 || mask_j>size(I_gray,2)
                continue;
              end
              line_mask(p_i, floor(mask_j))=255;
           end
        end
    end
end

end