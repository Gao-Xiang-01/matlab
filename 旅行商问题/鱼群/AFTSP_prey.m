function Xi=AFTSP_prey(X,cityNum,i,visual,try_number,Distance,crossNum)
%Xi=AFTSP_init(cityNum);
for j=1:try_number
    jj=ceil(rand*visual);
    S(1)=ceil(rand*(cityNum-1))+1;       %�������2��cityNum֮�����
    p=1;
    while(p<jj)
       t=ceil(rand*(cityNum-1))+1;
       if((S==t)==0)
           p=p+1;
           S(p)=t;
       end
    end                                  %�������S������Ԫ�ظ�������
   Xii=X(i,:);
   t=Xii(S(1));
   for k=1:jj-1
       Xii(S(k))=Xii(S(k+1));
   end
   Xii(S(jj))=t;
   if(j==1)
       Xibest=Xii;                      
   end
   if(AFTSP_foodconsistence(Xii,Distance)<AFTSP_foodconsistence(Xibest,Distance))
       Xibest=Xii;                      %Xibest�洢��ʳ��Ϊ�õ������Ž�
   end
   if(AFTSP_foodconsistence(Xii,Distance)<AFTSP_foodconsistence(X(i,:),Distance))
       Xi=Xii;
       return
   end
end 
if(dis(Xibest,X(i,:),cityNum)<crossNum)          %���û����������̫�����򽻻�λ�ã����־���
    for i=1:crossNum
        t1=ceil(rand*(cityNum-1))+1;
        t2=ceil(rand*(cityNum-1))+1;
        temp=Xibest(t1);
        Xibest(t1)=Xibest(t2);
        Xibest(t2)=temp;
        if(dis(Xibest,X(i,:),cityNum)>=crossNum)
            Xi=Xibest; 
            return
        end
    end
else
    Xi=Xibest; 
end
       
   
        
        