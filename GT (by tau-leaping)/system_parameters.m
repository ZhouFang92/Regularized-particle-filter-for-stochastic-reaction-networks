function [K,X0]=system_parameters

K(1)=0.03+(0.3-0.03)*rand;
K(2)=0.03+(0.3-0.03)*rand;
K(3)=0.2+(2-0.2)*rand;
K(4)=0.2+(2-0.2)*rand;

if rand<1/2
    X0(1)=0;
else
    X0(1)=1;
end
X0(2)=1-X0(1);
if X0(2)==1
   X0(3)= poissrnd(50)/50;
else
   X0(3)= 0;
end

