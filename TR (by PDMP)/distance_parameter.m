function d=distance_parameter(K1,K2)

d=0;

for i=1:size(K1,1)
    d=d+(K1(i)-K2(i))^2;
end

%d=sqrt(d);