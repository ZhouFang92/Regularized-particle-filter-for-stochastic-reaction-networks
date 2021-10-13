% This function use modified next reaction method to simulate the full
% model. It returns state vector X and time vector TV, given final time FT,
% initial conditions X0.

% The reaction network: Gene<===>Gene*-->mRNA-->0

function [K,X,TV]=modified_next_reaction_method_full_model(K,X0,FT)

%initialization (k is the scaled reaction constant)
N=100;
X(:,1)=X0;
TV(1)=0;
for j=1:6
  T(j)=0;
  r(j)=rand;
  P(j)=log(1/r(j));
  a(j)=propensity(X(:,1),j,K); 
  DeltaT(j)=(P(j)-T(j))/a(j);
end
[deltaT,mu] = min(DeltaT);
num_step=1;


while TV(num_step)+deltaT < FT % update while the final time is not reached.
     TV(num_step+1)=TV(num_step)+deltaT; %update time
     DX=reaction_direction(mu);
     X(:,num_step+1)=X(:,num_step)+DX; %update the state
     num_step=num_step+1;
     for j=1:6
         T(j)=T(j)+deltaT*a(j);       %update the used time for each reaction
     end
     r(mu)=rand;
     P(mu)=P(mu)+log(1/r(mu));         %update the next reaction time for mu
     for j=1:6                  %recalculate the propensity
           a(j)=propensity(X(:,num_step),j,K);
           DeltaT(j)=(P(j)-T(j))/a(j);
     end
     [deltaT,mu] = min(DeltaT);  %update the next time to fire a reaction
end


TV(num_step+1)=FT; %update the final time
X(:,num_step+1)=X(:,num_step);


