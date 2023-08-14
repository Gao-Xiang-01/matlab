function [result_img] = inpaint_criminisi(img, mask, patch_size, speed)
    %criminisi�㷨�ĳ�ʼ������ѭ��
    %�޲���Ĵ�СΪpitch_size*pitch_size, patch_size��ҪΪ����
    %maskӦ��Ϊ0 1����Ϊ1�Ĳ�������Ҫ�޸��Ĳ���
    img = double(img);
    img_lab = rgb2lab(img);
    
    C = double(~mask); %C�ĳ�ʼ��
    
    %��Ip��ͼƬ����ֵ�ݶȵĵȳ�����
    [gradient_i1, gradient_j1] = gradient(img(:,:,1));
    [gradient_i2, gradient_j2] = gradient(img(:,:,2));
    [gradient_i3, gradient_j3] = gradient(img(:,:,3));
    gradient_i = double(gradient_i1+gradient_i2+gradient_i3)/3.0;
    gradient_j = double(gradient_j1+gradient_j2+gradient_j3)/3.0;
    Ip_i = -gradient_j/255.0;
    Ip_j = gradient_i/255.0; %�ݶ�ת90��
    
    SE=strel('square',3);%����mask
    size_img = size(img);
    pSize_half = (patch_size-1)/2;
    
    mask_sum = sum(sum(mask));
    while mask_sum > 0
        %���Ե��
        fat_mask = imdilate(mask, SE); %mask����
        contour_mart = fat_mask-mask; %mask�ı�Ե
        contour_index = find(contour_mart>0);
        
        %����ÿ����Ե���C
        for i=1:length(contour_index) 
            c = contour_index(i);
            [c_i, c_j] = getIJ_index(round(c), size_img(1));
            [i_neibor, j_neibor] = get_neiborIndex(c_i, c_j, pSize_half, size_img);
            C_patch = C(i_neibor, j_neibor);
            C(c_i, c_j) = double(sum(sum(C_patch)))/double(numel(C_patch));
        end
        
        %������޸������Ե�ߵĴ���
        [np_i, np_j] = gradient(double(~mask));
        np_dis = sqrt(np_i.^2+np_j.^2);
        %np_dis(np_dis==0)=1e-6;
        np_i = np_i./np_dis;
        np_j = np_j./np_dis;%ͼ��mask��Ե���ݶȣ����ɵ�λ����
        %np_i(isnan(np_i))=0;
        %np_j(isnan(np_j))=0;
        np_i(~isfinite(np_i))=0;
        np_j(~isfinite(np_j))=0;
        
        %��Ե���Dֵ
        D_contour = np_i(contour_index).*Ip_i(contour_index) + np_j(contour_index).*Ip_j(contour_index);
        D_contour = abs(D_contour);
        %D_contour(D_contour<1e-6)=1e-6;
        D_contour=D_contour+1e-3;
        
        %�����Ե�����ȼ�����ȡ���ȼ���ߵĵ�
        Priority_contour = D_contour.* C(contour_index); 
        [~, best_index] = max(Priority_contour);
        best_contour = contour_index(best_index);
        [bC_i, bC_j] = getIJ_index(best_contour, size(img,1));
        [i_neibors, j_neibors] = get_neiborIndex(bC_i, bC_j, pSize_half, size_img);
        
        %img1 = img_lab(:,:,1);
        %�ҵ�ƥ�����ߵĿ�
        if speed=='fast'
            [best_match_is, best_match_js] = bestMatch_fast(i_neibors, j_neibors, mask, img_lab, patch_size*9);
        else
            [best_match_is, best_match_js] = bestMatch(i_neibors, j_neibors, mask, img_lab); 
        end
        
        %��������ֵ
        img(i_neibors, j_neibors, :) = img(best_match_is, best_match_js,:); %����ͼ���rgbֵ
        img_lab(i_neibors, j_neibors, :) = img_lab(best_match_is, best_match_js,:); %����ͼ���labֵ
        
         %����C
        mask_patch = mask(i_neibors,j_neibors);
        unknow_pNum = sum(sum(double(mask_patch)));
        C_patch = C(i_neibors, j_neibors);
        C_patch(mask_patch>0)=C(bC_i,bC_j);
        C(i_neibors, j_neibors) = C_patch;
        
        %����mask
        mask(i_neibors,j_neibors)=0; 
        
        mask_sum = mask_sum-unknow_pNum
    end
    
    result_img = img;
end

%���һ��pitch�е��к���
function [is, js] = get_neiborIndex(center_i, center_j, half_len, size_img)
    up = max(center_i-half_len, 1);
    down = min(center_i+half_len, size_img(1));
    left = max(center_j-half_len, 1);
    right = min(center_j+half_len, size_img(2));
    is = up:down;
    js = left:right;
end

function [i, j] = getIJ_index(index, rowNum)
    j = floor((index-1)/rowNum)+1;
    i = rem(index-1,rowNum)+1;
end