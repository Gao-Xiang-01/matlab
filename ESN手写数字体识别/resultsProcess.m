function [accuary,precious,value]=resultsProcess(results10Dim,expectResults)
    %Ԥ���������Ϊ ����*10ά��
    %�����Ľ��Ϊ 1ά����3��5��8��0 ��
    %ÿһ���е��������ݣ���Ϊ���Ԥ��Ľ��
    %��[0.2,0.1,0.88,0.1,-0.02,...,0.2],��Ԥ��Ľ��Ϊ 3
    %ע�⣬����ʮλΪ���ֵ����ôԤ����Ϊ0
    [~,value]=max(results10Dim);
    value(value==10)=0;                  %Ԥ����
    precious = sum(value==expectResults);%��ȷ����
    accuary = precious/length(expectResults);%����
end