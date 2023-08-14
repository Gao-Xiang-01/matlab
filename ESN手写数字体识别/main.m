%����·���ͼ�������
initTAO
%�������ݺͱ�ǩ������һ��ѵ������������
normal_trainData=trainData/255;
normal_testData =testData/255;
%��ѵ����ǩչ��
trainResult10 = oneHot(train_labels1,10);

%% �����������
Nr=200;                 %�����صĴ�С
spectralRadius=0.85;    %Ȩ�װ뾶��С��1
regularization=1e-3;    %��ع������ϵ��
washOut=100;
inputScaling=0.5;
esn=ESN(Nr,'spectralRadius',spectralRadius,'regularization',regularization,'inputScaling',inputScaling);

%ѵ��
trainLen=9000;
esn.train(normal_trainData(1:trainLen,:),trainResult10(1:trainLen,:),washOut)
%Ԥ��
train_predict=esn.predict(normal_trainData(1:trainLen,:));
%ѵ������
[accuracy,precious,predictValue]= resultsProcess(train_predict.',train_labels1(1:trainLen));
fprintf('ѵ������ȷ�ʣ�%d / %d \n',precious,trainLen)
fprintf('ѵ������: %f\n', accuracy)

%���Ծ���
testLen=1000;
test_predict=esn.predict(normal_testData(1:testLen,:));
[accuracy,precious,predictValue]= resultsProcess(test_predict',test_labels1(1:testLen));
fprintf('���Լ���ȷ�ʣ�%d / %d \n',precious,testLen)
fprintf('ѵ������: %f\n', accuracy)

