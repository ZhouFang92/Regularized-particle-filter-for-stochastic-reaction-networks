%resampling according to z0
%It applies the branching algorithm in Bain&Crisan's text book page 225

function [V1,z1]=resampling_step(V0,z0) 

z0=z0/sum(z0);
N=size(z0,2); % the size of total particles

g=N; % probability left
h=N; %off springs to generate
% O(j) the offsprings to generate

for j=1:N-1
    g_integer=fix(g);
    g_fraction=g-g_integer;
    nz_integer=fix(N*z0(j));
    nz_fraction=N*z0(j)-nz_integer;
    r=rand;
    if nz_fraction + (g-N*z0(j)-fix(g-N*z0(j)))<1
           if r<1-nz_fraction/g_fraction 
              O(j)=nz_integer;
           else
              O(j)=nz_integer+(h-g_integer);
           end
    else
           if r< 1-(1-nz_fraction)/(1-g_fraction)
              O(j)=nz_integer+1;
           else
              O(j)=nz_integer+(h-g_integer);
           end
    end    
    g=g-N*z0(j);
    h=h-O(j);
end

j=j+1;
O(j)=h;

%update 
i=1;
for j=1:N
    for k=1:O(j)
        V1(:,i)=V0(:,j);
        i=i+1;
    end
end

z1=ones(1,N)/N;