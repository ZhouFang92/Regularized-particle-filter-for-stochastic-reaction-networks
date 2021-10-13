function k_out=artificial_move(M,k_in,eta)



for i=1:size(k_in,2)
    for j=1:2
        a(j)=0;
        while a(j)<0.1 || a(j)>1
           a(j)=k_in(j,i)+eta*sqrt(1/M)*randn*0.9/sqrt(12);
        end
        k_out(j,i)=a(j);
    end
    
    for j=3:size(k_in,1)
        k_out(j,i)=k_in(j,i);
    end
    %a(1)=k_in(1,i)+eta*sqrt(1/M)*randn;
    %a(2)=k_in(2,i)+eta*sqrt(1/M)*randn;
    %a(3)=k_in(3,i)+eta*sqrt(1/M)*randn;
    %a(4)=k_in(4,i)+eta*sqrt(1/M)*randn;
    %a(5)=k_in(5,i)+eta*sqrt(1/M)*randn;
   %a(1)=min(a(1),1);
   %k_out(1,i)=max(a(1),0.1);
   %a(2)=min(a(2),1);
   %k_out(2,i)=max(a(2),0.1);
   %a(3)=min(a(3),1);
   %k_out(3,i)=max(a(3),0.1);
   %a(4)=min(a(4),1);
   %k_out(4,i)=max(a(4),0.1);
   %a(5)=min(a(5),1);
   %k_out(5,i)=max(a(5),0.1);
end