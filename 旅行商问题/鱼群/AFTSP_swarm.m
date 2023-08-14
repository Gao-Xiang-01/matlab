function [Xi,flag]=AFTSP_swarm(X,afNum,cityNum,visual,crowd,i,Distance,crossNum)
label=NBlabel(X,afNum,cityNum,i,visual);%�����ڻ����
nf=length(label);
Xi=[];                                  %Ĭ�Ͼ�Ⱥʧ��
flag=0;
if(nf==0)                               %������û�л��
    return
elseif(nf==1)
    Xc=X(label(1),:);
    if(AFTSP_foodconsistence(X(i,:),Distance)>AFTSP_foodconsistence(Xc,Distance));
         flag=1;
         Xi=Xc;
         return
     elseif(dis(Xc,X(i,:),cityNum)<crossNum)          %���û����������̫�����򽻻�λ�ã����־���
         for i=1:crossNum
             for i=1:ceil(crossNum/2)
                t1=ceil(rand*(cityNum-1))+1;
                t2=ceil(rand*(cityNum-1))+1;
                temp=Xc(t1);
                Xc(t1)=Xc(t2);
                Xc(t2)=temp;
            end
            if(dis(Xc,X(i,:),cityNum)>=crossNum)
                break
            end
         end
     else
         return
     end
     if(AFTSP_foodconsistence(X(i,:),Distance)>AFTSP_foodconsistence(Xc,Distance))
         flag=1;
         Xi=Xc;
         return
     end
elseif(nf/afNum<crowd)
    neigbor=X(label,:);
    Xc=[];
    Xc(1)=1;
    for j=2:cityNum
        tJ=neigbor(:,j);                %�ҳ��������ĳ��У��Ӷ�ȷ����������
        temp=[];
        for k=1:nf
            temp(k)=sum(tJ==tJ(k));
        end
        [p q]=max(temp);
        %p�ǳ������ĳ��д��� q�ǳ������ĳ���λ��    
        %���Կ��ǰ���ǰ�е�λ�����㣬Ȼ������û�е�ֵ����Щλ
        %��������У���û�е�ֵ���������Ȼ��˳��ŵ��÷ŵ�λ���ϣ�
        if(sum(Xc==tJ(q))~=0) %���Xc֮ǰ�����ֵ
            while(1)
                a=ceil(rand*cityNum);
                if(sum(Xc==a)==0)
                    Xc(j)=a;
                    break
                end
            end
        else
            Xc(j)=tJ(q);
        end
    end
    if(AFTSP_foodconsistence(X(i,:),Distance)>AFTSP_foodconsistence(Xc,Distance));
        flag=1;
        Xi=Xc;
        return
    elseif(dis(Xc,X(i,:),cityNum)<crossNum)          %���û����������̫�����򽻻�λ�ã����־���
        for i=1:crossNum         
            for i=1:crossNum
                t1=ceil(rand*(cityNum-1))+1;
                t2=ceil(rand*(cityNum-1))+1;
                temp=Xc(t1);
                Xc(t1)=Xc(t2);
                Xc(t2)=temp;
            end
            if(dis(Xc,X(i,:),cityNum)>=crossNum)
                break
            end
        end
        if(AFTSP_foodconsistence(X(i,:),Distance)>AFTSP_foodconsistence(Xc,Distance))
            flag=1;
            Xi=Xc;
        end
    end
end





