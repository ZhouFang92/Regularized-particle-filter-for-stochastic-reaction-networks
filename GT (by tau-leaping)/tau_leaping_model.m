function [K,X,TV]=tau_leaping_model(K,X0,FT)

%Here, we use the tau-leaping algorithm with postleap chekcs provided by
%Anderson. (see "Incorporating postleap checks in tau-leaping")

%initialization
N=50;
default_tau=0.2;
number_of_reactions=4;
p=0.5; %Discount factor for tau 
q=0.4;   %raising tau
X=X0; %state
%X(3)=X(3)*N; %go to the original coordinates.
TV=0; %time vector
tau=default_tau;

T=zeros(number_of_reactions,1); % the current internal time of Poisson process
C=zeros(number_of_reactions,1); % the unmber of firing events up to that time
for k=1:number_of_reactions
   S{k}=[0,0]; 
end

%calculate the propensity function

for k=1:number_of_reactions
    a(k)=propensity(X(:,1),k,K);
    if k>=3
       a(k)=a(k)*N; 
    end
end

while TV(size(TV,2))<FT 
    
    %preparation for the leap 
    for k=1:number_of_reactions
        B(k)=size(S{k},1); 
        if a(k)*tau+T(k)+10^(-10)>=S{k}(B(k),1)
            NJ(k)=PoissonSamp(T(k)+a(k)*tau-S{k}(B(k),1))+S{k}(B(k),2)-C(k);
            row(k)=B(k);
        else
            I= find( S{k}(:,1) > a(k)*tau+T(k)+10^(-10), 1, 'first');
            r=(T(k)+a(k)*tau-S{k}(I-1,1))/(S{k}(I,1)-S{k}(I-1,1));
            if r<0
               r=0;
            end
            NJ(k)=binornd(S{k}(I,2)-S{k}(I-1,2),r)+S{k}(I-1,2)-C(k);
            row(k)=I-1;
        end
    end
    
    % postleap checks
    DX=zeros(size(X,1),1);
    for k=1:number_of_reactions
        DX=DX+reaction_direction(k)*NJ(k);
    end
    DX(3)=DX(3)/N;
    if all( X(:,size(X,2))+DX>=-10^(-10)) ==1 % accept the leap
        TV=[TV,TV(size(TV,2))+tau]; %update time
        for k=1:number_of_reactions 
            if row(k)==B(k) % update Sk
               S{k}=[a(k)*tau+T(k),C(k)+NJ(k)];
            else
               S{k}=[a(k)*tau+T(k),C(k)+NJ(k); S{k}(row(k)+1:B(k),:)]; 
            end
            T(k)=T(k)+a(k)*tau;  %update current time
            C(k)=C(k)+NJ(k);
        end
            tau=min(tau^q,FT-TV(size(TV,2)));%default_tau;    %update tau
            step=size(X,2);
            X(:,step+1)=X(:,step)+DX;
        for k=1:number_of_reactions  %update propensity
             a(k)=propensity(X(:,step+1),k,K);
             if k>=3
                 a(k)=a(k)*N; 
             end
         end
    else     % reject the leap
        for k=1:number_of_reactions 
            if row(k)==B(k)
               S{k}=[S{k}(1:row(k),:);a(k)*tau+T(k),C(k)+NJ(k)];
            else
               S{k}=[S{k}(1:row(k),:);a(k)*tau+T(k),C(k)+NJ(k); S{k}(row(k)+1:B(k),:)]; 
            end
        end
        tau=p*tau;
    end
    
end

% express in the normalized coordinate

%X(3,:)=X(3,:)/N;

    
    
