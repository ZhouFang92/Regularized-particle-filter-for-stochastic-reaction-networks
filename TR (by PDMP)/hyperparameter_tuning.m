M=2000;
FT=240; 
sampling_time_observation=1; % resampling frequnecy
try_number=300;%400;
max_entropy=log2(M);

% set eta

eta_choice=[0:0.2:2];
%alpha_choice=sqrt(1-[0:1:15].^2/2000);%1-[0:0.02:0.3];
error_matrix=zeros(size(eta_choice,2),1);
SD_particles=zeros(size(eta_choice,2),try_number);
error_of_particles=zeros(size(eta_choice,2),try_number);
error_of_particle_mean=zeros(size(eta_choice,2),try_number);
entropy_of_particles=zeros(size(eta_choice,2),try_number);

% Generate synthetic data
parfor l=1:try_number
        [K{l},X0]=system_parameters;
        if size(K{l},1)==1
           K{l}=K{l}';
        end
        [K{l},XF{l},TXF{l}]=modified_next_reaction_method_full_model(K{l},X0,FT);
        [Y{l},TY{l}]=observation_discrete_time(TXF{l},XF{l},sampling_time_observation);
end


% caculate filter

for i=1:size(eta_choice,2)
  eta=eta_choice(i);
  alpha=sqrt(1-0^2/M);
  
  %for j=1:size(alpha_choice,2)
  %alpha=alpha_choice(j);

    %for a given pair of eta and alpha calculate the error
    
    error=0;
    parfor trials=1:try_number
        tic
        K_temp=K{trials};
        TY_temp=TY{trials};
        Y_temp=Y{trials};
        [T_RF,R_filter_RM, R_filterSD_RM, R_filter_RM_div, R_filter_RM_final_distribution, R_filter_RM_particles]=particle_filter(TY_temp, Y_temp, M, 'PDMP', 'RPF_NS', eta, alpha);
        add_error=0;
        for particle_index=1:M
        add_error=add_error+distance_parameter(R_filter_RM_final_distribution(1:size(K_temp,1),particle_index),K_temp);
        end
        %error=error+add_error/(norm(K_temp))^2/M;
        SD_particles(i,trials)=sqrt(sum(var(R_filter_RM_final_distribution(1:size(K_temp,1),:)')));
        error_of_particles(i,trials)=add_error/M;
        error_of_particle_mean(i,trials)=distance_parameter(R_filter_RM(1:size(K_temp,1),size(TY_temp,2)),K_temp);
        entropy_temp=zeros(size(K_temp,1),1);
        for index=1:size(K_temp,1)
            entropy_temp(index)= entropy(R_filter_RM_final_distribution(index,:));
        end
        entropy_of_particles(i,trials) = max(entropy_temp);
        toc
    end
    
    %error_matrix(i)=error;
        
 
end

%% evaluate the filter

for i=1:size(eta_choice,2)
    error_of_MSE(i)=mean(error_of_particles(i,:));
    for j=1:try_number
       K_norm(j)=norm(K{j}); 
    end
    error_of_RMSE(i)=mean(error_of_particles(i,:)./K_norm);
    exp_entropy_inverse(i)=mean(1./exp(entropy_of_particles(i,:)));
    error_matrix=error_of_RMSE+exp_entropy_inverse;
end


min_error=min(error_matrix);
[i_opt]=find(error_matrix==min_error,1);
eta_opt=eta_choice(i_opt);
alpha_opt=1;

fname = sprintf('hyperparameter_tuning_M%d_FT%d_period_%.1f.mat', M, FT, sampling_time_observation);
save(fname)