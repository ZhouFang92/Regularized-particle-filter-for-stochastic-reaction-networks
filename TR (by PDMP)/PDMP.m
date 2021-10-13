% This function use modified next reaction method to simulate the full
% model. It returns state vector X and time vector TV, given final time FT,
% initial conditions X0.

% The reaction network: DNA<==>DNA*—>mRNA-->0

function [K,X,TV]=PDMP(K,X0,FT)

%initialization (k is the scaled reaction constant)
N=10000;
delta=0.01;

X(:,1)=X0;
TV(1)=0;
for j=1:4
  T(j)=0;
  r(j)=rand;
  P(j)=log(1/r(j));
  a(j)=propensity(X(:,1),j,K); 
  DeltaT(j)=(P(j)-T(j))/a(j);
end
[deltaT,mu] = min(DeltaT);
num_step=1;


while TV(num_step)+deltaT < FT % update while the final time is not reached.
     TV(num_step+1)=TV(num_step)+delta;
     num_step=num_step+1;
     i=num_step;
     X(1,i)=X(1,i-1);
     X(2,i)=X(2,i-1);
     X(3,i)=X(3,i-1);
     dx4=(K(5)*X(3,i-1)-K(6)*X(4,i-1))*delta;
     X(4,i)=X(4,i-1)+dx4;
     
     %update discrete process
     
     for j=1:4
         T(j)=T(j)+delta*propensity(X(:,num_step-1),j,K);
         if T(j)>P(j)
            DX=reaction_direction(j);
            %if X(2,num_step)+DX(2)>1.5 || X(1,num_step)+DX(1)>1.5 % avoid negative DNA copies
            %else
                X(:,num_step)=X(:,num_step)+[DX(1:3);0];
            %end
            r(j)=rand;
            P(j)=P(j)+log(1/r(j)); 
            if j<=2 && T(j)>P(j)
               T(j)=P(j)-10^(-10); %avoid negative DNA copies in the next step. 
            end
         end
     end 
     
     for j=1:4
     if X(j,num_step)<0   % avoid negative mRNA
        X(j,num_step)=0;
     end
     end
     
     
end



