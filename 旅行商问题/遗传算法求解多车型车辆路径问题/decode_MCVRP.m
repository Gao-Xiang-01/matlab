function [Result]=decode_MCVRP(T,capacity_max_4,capacity_max_6,distance_max)
%distance_max=50;����Ҫ
%capacity_max=8;
load Demand %�ͻ�������
load coordinate %�ͻ�������
D=Distance(coordinate);%�ͻ���ľ���
load X
Result=[];
%����Ϊ6�� �������
ij=1;
WS=0;
while ij<=size(T,2)
WS=WS+1;
WT=1;
a1=0;b1=0;
Result1=[];
for i=ij:size(T,2)
    if WT==1
       a1=2*X(T(i));
       b1=Demand(T(i));
    elseif WT==2
        a1=X(T(i-1))+X(T(i))+D(T(i),T(i-1));
        b1=Demand(T(i-1))+Demand(T(i));
    else
        a1=0;b1=0;
        for j=i-WT+1:i-1
            a1=a1+D(T(j+1),T(j));
            b1=b1+Demand(T(j));
        end
        b1=b1+Demand(T(i));
        a1=a1+X(T(i-WT+1))+X(T(i));
    end
%%
    a2=(5*WT/60)+(a1/50);%%���㳵������ʱ��
%%
%     if  (a1>distance_max)|(b1>capacity_max)
%         a1=2*X(T(i));
%         b1=Demand(T(1));
%         WS=WS+1;
%         Result(i,:)=[T(i),WS,a1,b1];
%         WT=2;
%     else
%         Result(i,:)=[T(i),WS,a1,b1];
%         WT=WT+1;
%     end
%%
%Լ��������ÿ̨��ÿ�չ���4Сʱ
   if  (a2>distance_max)|(b1>capacity_max_6)
        %a1=2*X(T(i));
        %a2=(5/60)+(a1/50);
        %b1=Demand(T(i));
        %WS=WS+1;
        %Result(i,:)=[T(i),WS,a2,b1];
        %WT=2;
        break;
    else
        Result1(i-ij+1,:)=[T(i),WS,a2,b1,capacity_max_6];
        WT=WT+1;
   end
%%
end
%����Ϊ4�ֽ������
%=================================
WT=1;
a11=0;b11=0;
Result11=[];
for m=ij:size(T,2)
    if WT==1
       a11=2*X(T(m));
       b11=Demand(T(m));
    elseif WT==2
        a11=X(T(m-1))+X(T(m))+D(T(m),T(m-1));
        b11=Demand(T(m-1))+Demand(T(m));
    else
        a11=0;b11=0;
        for j=m-WT+1:m-1
            a11=a11+D(T(j+1),T(j));
            b11=b11+Demand(T(j));
        end
        b11=b11+Demand(T(m));
        a11=a11+X(T(m-WT+1))+X(T(m));
    end
%%
    a12=(5*WT/60)+(a11/50);%%���㳵������ʱ��
%%
%     mf  (a1>dmstance_max)|(b1>capacmty_max)
%         a1=2*X(T(m));
%         b1=Demand(T(1));
%         WS=WS+1;
%         Result(m,:)=[T(m),WS,a1,b1];
%         WT=2;
%     else
%         Result(m,:)=[T(m),WS,a1,b1];
%         WT=WT+1;
%     end
%%
%Լ��������ÿ̨��ÿ�չ���4Сʱ
   if  (a12>distance_max)|(b11>capacity_max_4)
        %a1=2*X(T(m));
        %a2=(5/60)+(a1/50);
        %b1=Demand(T(m));
        %WS=WS+1;
        %Result(m,:)=[T(m),WS,a2,b1];
        %WT=2;
        break;
    else
        Result11(m-ij+1,:)=[T(m),WS,a12,b11,capacity_max_4];
        WT=WT+1;
   end
%%
end
chazhi_6=capacity_max_6-max(Result1(:,4));
chazhi_4=capacity_max_4-max(Result11(:,4));
if chazhi_6>=chazhi_4
    Result=[Result;Result11];
else
    Result=[Result;Result1];
end
ij=size(Result,1)+1;
end
