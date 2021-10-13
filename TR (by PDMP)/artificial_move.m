function k_out=artificial_move(M,k_in,eta)



for i=1:size(k_in,2)
    for j=1:size(k_in,1)
      if j<=2
         k_min=0.03;
         k_max=0.3;
      elseif j<=4
         k_min=0.1;
         k_max=1;
      else
         k_min=0.1;
         k_max=1;
      end
      a(j)=0;
      V=(k_max-k_min)/sqrt(12);
      while a(j)<k_min || a(j)>k_max
         a(j)=k_in(j,i)+eta*V*sqrt(1/M)*randn;
      end
      k_out(j,i)=a(j);
    end
    %a(1)=k_in(1,i)+0.1*eta*sqrt(1/M)*randn;
    %a(2)=k_in(2,i)+0.1*eta*sqrt(1/M)*randn;
    %a(3)=k_in(3,i)+eta*sqrt(1/M)*randn;
    %a(4)=k_in(4,i)+eta*sqrt(1/M)*randn;
    %k_out(1,i)=min(a(1),0.3);
    %k_out(1,i)=max(a(1),0.03);
    %k_out(2,i)=min(a(2),0.3);
    %k_out(2,i)=max(a(2),0.03);
    %k_out(3,i)=min(a(3),2);
    %k_out(3,i)=max(a(3),0.2);
    %k_out(4,i)=min(a(4),2);
    %k_out(4,i)=max(a(4),0.2);
    %k_out(7,i)=0.8;
    %k_out(1,i)=0.15;%0.15;
    %k_out(2,i)=0.06;
    %k_out(3,i)=0.8;%1.6;
    %k_out(4,i)=0.4;%0.8;
    %k_out(5,i)=0.5;
    %k_out(6,i)=0.7;
end