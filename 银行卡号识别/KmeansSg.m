%ͨ��K-means����ͼ��ָ�
function [IX,IMMM]=KmeansSg(IM,cent)
IM=uint8(IM);
IM=IM(:,:,1);
IM=double(IM);
[maxX,maxY]=size(IM);
 
[a,IX]=imKmeans(IM,cent);
store(1:9)=[255,230,200,170,140,110,80,50,0];
% store(1:2)=[0,255];

IMMM=zeros(maxX,maxY);%��ʼ�ָ����
for i=1:maxX
    for j=1:maxY
        for pp=1:cent
         if IX(i,j)==pp
            IMMM(i,j)=store(pp);
         end
        end
    end
end
IMMM=uint8(IMMM);

 