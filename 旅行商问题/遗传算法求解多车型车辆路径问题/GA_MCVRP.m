clc
clear
close all;
tic;
%%
%�㷨����
population_num=100;%��Ⱥ��ģ
Max_gen=200;%��������
Pc=0.9;%�������
Pm=0.09;%�������
%%
%�������
%��������Car_num=2
%�ͻ�����Customer_num=8
%��������capacity_max=8
%��ʻ����distance_max=50
%Car_num=2;
Customer_num=19;%����19���ͻ�
capacity_max_6=6;%����Ϊ6�ֳ���
%%
capacity_max_4=4;%����Ϊ6�ֳ���
price_k_4=0.2;%4�ֳ����صķ���Ϊ0.2Ԫ/����
price_k_6=0.4;%6�ֳ����صķ���Ϊ0.4Ԫ/����
%�Խ������������Ŀ��ֵ���������޸�
%%
distance_max=4;%ÿ̨��ÿ�չ���4Сʱ
load Demand %�ͻ�������
load coordinate %�ͻ��������
D=Distance(coordinate);%�ͻ���ľ���
load X %�������ĵ��ͻ���ľ���
%%
%��Ⱥ��ʼ��
population=zeros(population_num,Customer_num);
for i=1:population_num
     population(i,:)=randperm(Customer_num);
end
%%
y=1;%ѭ��������
 while y<Max_gen
     %����
     [new_pop_intercross]=Mating_pool(population_num,population,Pc);
     %����
     [new_pop_mutation]=Mutation(new_pop_intercross,Pm);
     %����Ŀ�꺯��
     mutation_num=size(new_pop_mutation,1);
     Total_Dis=[];
     for k=1:mutation_num
     [Result]=decode_MCVRP(new_pop_mutation(k,:),capacity_max_4,capacity_max_6,distance_max);
     [Total_Dis(k,1)]=parameter_MCVRP(Result,Customer_num,price_k_4,price_k_6,capacity_max_4,capacity_max_6);
     end
     %������Ⱥ
     new_pop_new=zeros(population_num,Customer_num);
     [Total_Dissort, index] = sort(Total_Dis);
     for k=1:population_num
         new_pop_new(k,:)=new_pop_mutation(index(k),:);
     end
     population=new_pop_new;
     %����������һ
     y=y+1
 end
 Dis_min1=min(Total_Dis);
for k=1:mutation_num
    if Total_Dis(k,1)==Dis_min1
       position1= k;
       break
    end
end
X_Best=new_pop_mutation(position1,:)
Y_Obj=Total_Dis(position1,1)
t=toc;