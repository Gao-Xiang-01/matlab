classdef myMinheap < handle
% ��С����
% ���ֲο��ԣ�matlab������С���㷨ʵ��
% https://blog.csdn.net/YDY5659150/article/details/102928564 
    properties
        size=0;
    end
    
    properties
        name;
    end
    
    properties
        data;
    end
    
methods (Access = public)
    
    function this = myMinheap(varargin)
            this.size=0;
            this.name.x=0;
            this.name.y=0;
            this.data=[];
    end

    function min_heap_create(this,name,data)
      N=length(name);
      for n=1:N
          this.name(n)=name(n);
          this.data(n)=data(n);
          this.size=this.size +1;
      end
    end
    
    function heap_swap_node(this,lchild,self)
        data_temp = this.data(lchild);
        this.data(lchild)=this.data(self);
        this.data(self)=data_temp;
        
        name_temp = this.name(lchild);
        this.name(lchild)=this.name(self);
        this.name(self)=name_temp;
    end
    
    function heap_down_sink(this,self)  
       lchild =self*2;
       rchild =self*2+1;
       if(lchild <= this.size && rchild <= this.size) 
          if(this.data(self) > this.data(lchild) || this.data(self) > this.data(rchild))                   
              if(this.data(lchild) <= this.data(rchild))%����������ȵ�����£��������������³�           
                   heap_swap_node(this,lchild,self);
                   heap_down_sink(this,lchild);
              else     
                   heap_swap_node(this,rchild,self);
                   heap_down_sink(this,rchild);
              end
          end
       elseif(lchild <= this.size)%����ֻ������Ҷ����
          if(this.data(self) > this.data(lchild))                    
               heap_swap_node(this,lchild,self);    
          end
       end
    end

    function  min_heap_adjust(heap)                   
        n=heap.size;
        while(n>=1)
            heap_down_sink(heap,n)
            n=n-1;
        end                
    end

    function min_heap_insert(heap,name_in,data_in)
          %�����Ľڵ���ӵ�β��
          heap.size=heap.size +1;
          heap.name(heap.size)=name_in;
          heap.data(heap.size)=data_in;
          %�����Ľڵ����ϸ��Ķ������ﵽ�����Ч�� 
          heap_up_float(heap,heap.size);
    end
      
     function heap_up_float(heap,self)
         while(self >=2)
             parent=floor(self/2);
             if(heap.data(self) < heap.data(parent))
                heap_swap_node(heap,parent,self); 
             end
             self =parent;
         end            
     end
     
     function [name,data]=min_heap_popup(heap)
       heap_swap_node(heap,1,heap.size);%�������ڵ��β���
       name=heap.name(heap.size);
       data=heap.data(heap.size);
       
       heap.size =heap.size -1;
       heap.data=heap.data(1:heap.size);
       heap.name=heap.name(1:heap.size);
       heap_down_sink(heap,1);%���ڵ��³�
        
     end
end
end