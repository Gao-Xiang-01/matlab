classdef ESN < handle
    % Echo State Network
    %���ȴ���ESN�����������޸ĵ���������
    %�ڶ�������train��Ա����
    %����������Ԥ���Ա����
    properties
        Nr             %�����ص���Ԫ����
        alpha          %�Ƿ���©����
        rho            %������Ȩ�װ뾶
        inputScaling   %�������������
        biasScaling    %ƫ�õ���������
        lambda         %����ϵ��
        connectivity   %ϵ���̶�
        readout_training %���Ȩֵ��ѵ������
        Win            %��������Ȩֵ����
        Wb             %ƫ�þ���
        Wr             %�ڲ�����Ȩֵ����
        Wout           %�������ȥȨֵ����
        internalState  %�����ص�״̬����
        outDim         %�����ά��/�������
        inputDim       %����ά��
    end
    methods
       function esn = ESN(Nr,varargin)
            esn.Nr = Nr;
            esn.alpha = 1;
            esn.rho = 0.9;
            esn.inputScaling = 1;
            esn.biasScaling = 1;
            esn.lambda = 2;
            esn.connectivity = 1;
            esn.readout_training = 'ridgeregression';
            
            numvarargs = length(varargin);
            for i = 1:2:numvarargs
                switch varargin{i}
                    case 'leakRate', esn.alpha = varargin{i+1};
                    case 'spectralRadius', esn.rho = varargin{i+1};
                    case 'inputScaling', esn.inputScaling = varargin{i+1};
                    case 'biasScaling', esn.biasScaling = varargin{i+1};
                    case 'regularization', esn.lambda = varargin{i+1};
                    case 'connectivity', esn.connectivity = varargin{i+1};
                    case 'readoutTraining', esn.readout_training = varargin{i+1};
                    
                    otherwise, error('the option does not exist');
                end
            end
       end
        
        function train(esn, trX, target, washout)
            %trX��ʾѵ��������
            %target��ʾĿ��
            %�޸� trXΪN*dimData�ľ���
            %�޸� trYΪN*dimTaret�ľ���
            %��Ҫ��[-a,a]֮�����ɣ���ΪR = a - 2*a*rand(m,n)
            
            [inputQuantity,esn.inputDim]=size(trX);
            [~,esn.outDim] = size(target);
            esn.Win=esn.inputScaling *(rand(esn.Nr, esn.inputDim) *2 - 1);   %��������[-inputScaling,inputScaling]�ľ��ȷֲ�
            esn.Wb = esn.biasScaling * (rand(esn.Nr, 1) * 2 - 1);
            esn.Wr = full(sprand(esn.Nr,esn.Nr, esn.connectivity));      %����һ��m��n�ķ��Ӿ��ȷֲ������ϡ����󣬷���Ԫ�صķֲ��ܶ���density
            esn.Wr(esn.Wr ~= 0) = esn.Wr(esn.Wr ~= 0) * 2 - 1;           
            esn.Wr = esn.Wr * (esn.rho / max(abs(eig(esn.Wr))));         %����ȨֵȨ�װ뾶
 
            X = zeros(1+esn.inputDim+esn.Nr, inputQuantity-washout);        %״̬����ÿһ�д����ˣ�ƫ��״̬+����״̬+�ڲ�״̬
            x=zeros(esn.Nr,1);                                  %�ڲ�״̬����
      
            for s = 1:inputQuantity
                u = trX(s,:).';                                 %ȡ��һ�У���һ����Ƭ
                x_ = tanh(esn.Win*u + esn.Wr*x + esn.Wb);
                x = (1-esn.alpha)*x + esn.alpha*x_;
                if (s > washout)
                    X(:,s - washout) = [1;u;x]; 
                end
            end
            esn.internalState = X(1+esn.inputDim+1:end,:);
            esn.Wout = feval(esn.readout_training,X ,target(washout+1:end,:), esn);
        end
        
        function y = predict(esn, data)
            [N,~] = size(data);
            Y_out10 = zeros(esn.outDim,N);
            x=zeros(esn.Nr,1);
            for k =1 : N
                u = data(k, :).';
                x_ = tanh(esn.Win*u + esn.Wr*x + esn.Wb);
                x = (1-esn.alpha)*x + esn.alpha*x_;
                Y_out10( : ,k) = esn.Wout*[1;u;x];        %Ԥ��ֵyt
            end
            y = Y_out10';
        end
    end
end