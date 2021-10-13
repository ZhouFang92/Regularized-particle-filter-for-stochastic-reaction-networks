%% initialization
%clear;
M=2000;%5000; %number of particles
N=100;
sampling_time_observation=2; % resampling frequnecy
X0=[1;1;0;0];   %True initial conditions
K(1)=0.8; 
K(2)=0.2;
K(3)=0.2;
K(4)=0.5;
K(5)=0.7;
K(6)=0.3;
K=K';
FT=240;   %Total time length

%% Generate a reference process and observation
%delete XF
tic
[K,XF,TXF]=modified_next_reaction_method_full_model(K,X0,FT);
toc

 [Y,TY]=observation_discrete_time(TXF,XF,sampling_time_observation);
 subplot(2,2,1)
 stairs(TXF,XF(1,:));
 hold on
 subplot(2,2,2)
 stairs(TXF,XF(2,:));
 hold on
 subplot(2,2,3)
 stairs(TXF,XF(3,:));
 hold on
 subplot(2,2,4)
 stairs(TXF,XF(4,:));
 hold on
 plot(TY,Y/10,'r');

%% filter
tic
 [T_filter,R_filter_FM, R_filterSD_FM, R_filter_FM_div, R_filter_FM_final_distribution, R_filter_FM_particles]=particle_filter(TY, Y, M, 'Full', 'RPF_NS', 1.8, 1);
toc
tic
 [T_filter,SIR_filter_FM, SIR_filterSD_FM, SIR_filter_FM_div, SIR_filter_FM_final_distribution, SIR_filter_FM_particles]=particle_filter(TY, Y, M, 'Full', 'SIR_PF', 1, 0);
toc

%% Figures

plot_trajectory_result(TXF,XF,K,TY,Y,SIR_filter_FM, SIR_filterSD_FM,SIR_filter_FM_particles, R_filter_FM, R_filterSD_FM,R_filter_FM_particles)
plot_parameter_result(K,T_filter,SIR_filter_FM_particles, R_filter_FM_particles)
plot_particle_evolution(K,T_filter,SIR_filter_FM_particles, R_filter_FM_particles)

