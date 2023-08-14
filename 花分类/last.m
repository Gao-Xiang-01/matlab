%1.
files=xlsread('iris--�β������.xlsx'); %����excel���
figure; %����һ���µ�ͼ��
subplot(1,2,1); %subplot(1�У�2�У���һ��ͼ);
histogram(files(:,3)); %����3��
title('���곤��ֱ��ͼ')

subplot(1,2,2); %�ڶ���ͼ
histogram(files(:,4));%����4��
title('������ֱ��ͼ')

%2.
for i=1:4
    for j=i+1:4
        R=corrcoef(files(:,i),files(:,j));
        disp(R);
    end;
end;
%�Ⱥ��������1������2֮��������ϵ��������1������3֮��������ϵ����
%����1������4֮��������ϵ��������2������3֮��������ϵ����
%����2������4֮��������ϵ��������3������4֮��������ϵ��

%3.
for i=1:4
    for j=i+1:4
        figure;
        gplotmatrix(files(:,[i,j]),[],files(:,5));
        title(['��',num2str(i),'�����',num2str(j),'�еİ��黮�ֵ�ɢ��ͼ'])
    end;
end;
%num2str()ת�����ַ�����ʾ

%4.
figure;
boxplot(files(:,1:4)); %������ͼ
x=input('��Ϊ�ĸ���������ɢ�㣺');
avg=mean(files(:,x)); %��ֵ
disp(['��ֵΪ',num2str(avg)]); %�����ֵ

a=std(files(:,x)); %��׼��
disp(['��׼��Ϊ',num2str(a)]); %�����׼��

bianhao=[]; %����ֵ
for i=1:length(files(:,x))
    if(abs(files(i,2)-avg)>3*a)
        bianhao=[bianhao,i];
    end
end
disp(['��3��ԭ���ҵ���Ⱥ�����Ϊ:',num2str(length(bianhao))]);
liqun=files(bianhao,x);

%5.
[m,n]=size(files);
s=1:m;
label1=files(s,n); %���Լ���ǩ
b=zeros(1,length(files(:,5))); 
train=files(b==0,:);
test=files(bianhao,:);
Mdl = fitcecoc(train(:,1:4),train(:,5)); %ѵ��������

label = predict(Mdl,test(:,1:4));  %Ԥ���ǩ

prc=mean(label==test(:,5));
disp('��SVM������Ԥ����Ⱥ������׼ȷ��Ϊ:');
disp(prc);


yuc=test(:,5);


m0=length(label);
u=zeros(m0,3);   
v=zeros(m0,3);   
for i=1:m0
 if label(i)==0
    u(i,:)=[1 0 0];
 else if label(i)==1
    u(i,:)=[0 1 0];
     else
         u(i,:)=[0 0 1];
     end
  end
end
u=u';     %ȡת��


for i=1:m0
    if yuc(i)==0
        v(i,1)=1;
    elseif yuc(i)==1
        v(i,2)=1;
    elseif yuc(i)==2
        v(i,3)=1;
    end
end
        
        

v=v';     %ȡת��

plotconfusion(u,v);        %�����������