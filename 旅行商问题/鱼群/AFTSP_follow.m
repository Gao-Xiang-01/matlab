function [Xi,flag]=AFTSP_follow(X,afNum,cityNum,visual,crowd,i,Distance,crossNum)        %��׷β�ɹ�����flag Ϊ1������flagΪ0
label=NBlabel(X,afNum,cityNum,i,visual);    %�����ڻ����
nf=length(label);
Xi=[];                                      %Ĭ��׷βʧ��
flag=0;
if(nf==0)                        %������û�л��
       return
end
bestY=inf;
bestj=0;
for jj=1:length(label)
      Ynb=AFTSP_foodconsistence(X(label(jj),:),Distance);
       if(bestY>Ynb)
           bestY=Ynb;
           bestj=label(jj);
       end
end                                          %������״̬��ѵĻ��X(bestj,:)
Xii=X(bestj,:);
if(AFTSP_foodconsistence(X(i,:),Distance)>AFTSP_foodconsistence(Xii,Distance)&nf/afNum<crowd)                 
    Xi=Xii;
    flag=1;
    return
end
if(dis(Xii,X(i,:),cityNum)<crossNum)          %���û����������̫�����򽻻�λ�ã����־���
    for i=1:crossNum
        for i=1:ceil(crossNum/2)
            t1=ceil(rand*(cityNum-1))+1;
            t2=ceil(rand*(cityNum-1))+1;
            temp=Xii(t1);
            Xii(t1)=Xii(t2);
            Xii(t2)=temp;
        end
        if(dis(Xii,X(i,:),cityNum)>=crossNum)
            break
        end
    end
%     for i=1:crossNum
%         t1=ceil(rand*(cityNum-1))+1;
%         t2=ceil(rand*(cityNum-1))+1;
%         temp=Xii(t1);
%         Xii(t1)=Xii(t2);
%         Xii(t2)=temp;
%         if(dis(Xii,X(i,:),cityNum)>=crossNum)
%             Xi=Xii; 
%             return
%         end
%     end
else
    return
end
if(AFTSP_foodconsistence(X(i,:),Distance)>AFTSP_foodconsistence(Xii,Distance))                 
    Xi=Xii;
    flag=1;
end
    
    
    
    
    
    
    
    
    
    
    