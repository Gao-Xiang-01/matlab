function X=AFTSP_init(cityNum)          %���ش�1��cityNum��������� 
X=1:cityNum;
for i=2:cityNum
    t=ceil(rand*(cityNum-1))+1;
    temp=X(i);
    X(i)=X(t);
    X(t)=temp;
end                                     %�������cityNum-1��