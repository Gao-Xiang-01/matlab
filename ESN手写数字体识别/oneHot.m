function trainLabel10Dim=oneHot(originalLabels,Dim)
%%����һ������ı�ǩ������oneHot���룬
%%trainLabel10Dim ÿһ��Ϊһ����ǩ
%%originalLabels ��ʾԭʼ�ı�ǩ��Dim��ʾ�����
%%������д���ַ��࣬����ʮά����������ʾ��
%%�� 1 ,[1,0,0,0,0,0,0,0,0,0]
%%��10, [0,0,0,0,0,0,0,0,0,1]
originalLabels(originalLabels==0)=10;              %�� 0 �ű�ǩ��Ϊ 10
trainLabel10Dim=zeros(length(originalLabels),Dim); %��ǰ���þ��󣬼�������ʱ��
for k=1:length(originalLabels)
    trainLabel10Dim(k,originalLabels(k))=1;         %����Ӧλ ��1
end
end


