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

end
