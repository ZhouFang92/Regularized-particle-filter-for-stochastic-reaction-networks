%A general particle filter where system models, artificial_moves, and some
%corresponding coefficients can tuned freely. 

% system_model={'Full','PDMP','DA'}, full model, piece-wise deterministic
% model, and diffusion approximation

% filter_type={'SIR_PF', 'RPF'}

% eta is represents the wideness of the artificial moving kernel, alpha is
% the shrinkage parameter.

function [T_filter,filter, filterSD, diversity, distribution_final, particles]=particle_filter(TY, Y, M, system_model, filter_type, eta, alpha)

TY=[0,TY];
Y=[0,Y];
T_filter=TY;

% initialize particles

for j=1:M
    [k(:,j),v(:,j)]=system_parameters;
    w(j)=1/M;
end

 diversity(1)=numel(unique(k(1,:)));
 particles(1,:,:)=[k;v];
 
filter=zeros(size(k,1)+size(v,1),size(TY,2));
filterSD=zeros(size(k,1)+size(v,1),size(TY,2));

    % calculate filter at the initial time
    i=1;
    for j=1:M 
       filter(:,i)=filter(:,i)+[k(:,j);v(:,j)]/M;
       filterSD(:,i)=filterSD(:,i)+[k(:,j);v(:,j)].^2/M;
    end
    filterSD(:,i)=filterSD(:,i)-(filter(:,i)).^2;


for i=2:size(TY,2)
   
    %sampling set
      for j=1:M
        if strcmp(system_model,'Full')==1
          [K,XF1,TXF1]=modified_next_reaction_method_full_model(k(:,j),v(:,j),TY(i)-TY(i-1));
        elseif strcmp(system_model,'PDMP')==1
          [K,XF1,TXF1]=PDMP(k(:,j),v(:,j),TY(i)-TY(i-1));
        elseif strcmp(system_model,'Tau')==1
          [K,XF1,TXF1]=tau_leaping_model(k(:,j),v(:,j),TY(i)-TY(i-1));
        else
          [K,XF1,TXF1]=diffusion_approximation_model(k(:,j),v(:,j),TY(i)-TY(i-1));    
        end
        v(:,j)=XF1(:,size(XF1,2));
        k(:,j)=K;
      end
 
      
    %update weights
    %find the particle that is most close to the observation ....
    for j=1:M
      estimate_log_weights(j)=-(Y(i)-h_function(v(:,j)))^2/2;
    end
    max_log_weight=max(estimate_log_weights);
    %
    for j=1:M
        w(j)=weights_calculation_discrete_time(w(j),v(:,j),Y(i),max_log_weight);
    end
    
  
    
    %compute filter
    for j=1:M 
       filter(:,i)=filter(:,i)+w(j)*[k(:,j);v(:,j)]/sum(w);
       filterSD(:,i)=filterSD(:,i)+w(j)*[k(:,j);v(:,j)].^2/sum(w);
    end
    filterSD(:,i)=filterSD(:,i)-(filter(:,i)).^2;
    
    %resampling
    [kv,w]=resampling_step([k;v],w);
    %[kv,w]=multinomial_resampling([k;v],w);
    k=kv(1:size(k,1),:);
    v=kv(size(k,1)+1:size(v,1)+size(k,1),:);
    if strcmp(filter_type,'RPF_S')==1
       k=artificial_evolution_with_shrinkage(M,k,eta,alpha);
    elseif strcmp(filter_type,'RPF_NS')==1
       k=artificial_move(M,k,eta);
    end
    
    %TY(i)
    
    diversity(i)=numel(unique(k(1,:)));
    particles(i,:,:)=[k;v];
    
    
end

distribution_final=[k;v];