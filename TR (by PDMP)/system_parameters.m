function [K,X0]=system_parameters

K(1)=0.03+(0.3-0.03)*rand;
K(2)=0.03+(0.3-0.03)*rand;
K(3)=0.1+(1-0.1)*rand;
K(4)=0.1+(1-0.1)*rand;
K(5)=0.1+(1-0.1)*rand;
K(6)=0.1+(1-0.1)*rand;
K(7)=0.1+(1-0.1)*rand;

if rand<1/2
    X0(1)=0;
else
    X0(1)=1;
end
X0(2)=1-X0(1);
X0(3)= X0(2)*poissrnd(10);
X0(4)= X0(3)*poissrnd(10^4)/10^4;

