function [bad,kk] = cnntest(net, x, y)  
    %  feedforward  
    net = cnnff2(net, x); % ǰ�򴫲��õ���� 
    % [Y,I] = max(X) returns the indices of the maximum values in vector I  
    [~, h] = max(net.o); % �ҵ�ÿ�У�һ�б�ʾһ���������������������Ӧ�ı�ǩ  
    [~, a] = max(y);     % �ҵ��������������Ӧ������  
    bad = find(h ~= a);  % �ҵ����ǲ���ͬ�ĸ�����Ҳ���Ǵ���Ĵ���  
   % er = numel(bad) / size(y, 2); % ���������,size(y, 2)�ǲ�������������  
%      disp(['ʵ�������' num2str(h-1)]);
%      disp(['���������' num2str(a-1)]);
%      fprintf('���������%d ',a-1);
%      fprintf('ʵ�������%d\n', h-1);
    kk=h-1;
%    if((h-1)>25)
%     disp(['ʵ�������' num2str(h-1-26)]);
%     disp(['���������' num2str(a-1)]);
%    else
%     disp(['ʵ�������' num2str(h-1)]);
%     disp(['���������' num2str(a-1)]);
%    end
   % disp(['���������' num2str(numel(bad))]);
%     if numel(bad)>0
%         disp(['����ʶ���������' num2str(bad)]);
%     end
  
    %��ӡ����������
%     [m,n]=size(net.o);
%     % disp(['m=' num2str(m)  ' n=' num2str(n)]);
%     for i=1:m
%         for j=1:n
%             fprintf('%6.2f ',net.o(i,j));
%         end
%         fprintf('\n');
%     end
    
end   