function [K,X0]=system_parameters

%K(1)=0.8;
%K(2)=0.3;
%K(3)=0.2;

K(1)=0.1+(1-0.1)*rand;
K(2)=0.1+(1-0.1)*rand;
K(3)=0.2;
K(4)=0.5;
K(5)=0.7;%0.6;
K(6)=0.3;%0.7;

X0(1)=randi([0,10]);
X0(2)=randi([0,10]);
X0(3)=randi([0,20]);
X0(4)=randi([0,20]);
