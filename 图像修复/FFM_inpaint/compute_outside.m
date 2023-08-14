function [T] = compute_outside(T, F, h_band, radius)
%����һ�����ⲿ�㣨��֪����ֵ�㣩��T����ֵ

 h_band.size=h_band.size;
 F_temp=F;
 %���ڲ�����ⲿ�������ݣ�����������inpaint_FMM��ͬ�����㷨���м�����
 F(F_temp==2)=0; 
 F(F_temp==0)=2;
 
 last_t=0.0;
 radius_2 = radius * 2;
 
 while h_band.size~=0
    if last_t>=radius_2 %ֻ�����һ����Χ�ڵ��ⲿ��
       break; 
    end
    [min_p,~]=h_band.min_heap_popup();
    i = min_p.x;
    j = min_p.y;

    F(i, j) = 0; %����ⲿ��

    neighbors_i = [i+1, i-1, i, i];
    neighbors_j = [j, j, j+1, j-1];

    for p=1:length(neighbors_i)
       i_neib = neighbors_i(p);
       j_neib = neighbors_j(p);

       if i_neib<1 || i_neib>size(F,1) || j_neib<1 || j_neib>size(F,2)
         continue
       end

       if F(i_neib, j_neib) == 2 %�ڲ���
           T(i_neib, j_neib) = min([solve_T(T, F, i_neib, j_neib+1, i_neib-1, j_neib),...
                            solve_T(T, F, i_neib, j_neib-1, i_neib-1, j_neib),...
                            solve_T(T, F, i_neib, j_neib+1, i_neib+1, j_neib),...
                            solve_T(T, F, i_neib, j_neib-1, i_neib+1, j_neib)]);

           last_t=T(i_neib, j_neib);
           point.x=i_neib;
           point.y=j_neib;
           h_band.min_heap_insert(point, T(point.x,point.y));
           
           F(i_neib, j_neib) = 1; %��ɱ�Ե��
       end
    end
 end
T=T.*-1; %�ⲿ���TС��0
end