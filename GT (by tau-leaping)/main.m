%% initialization
%clear;
M=2000; %number of particles
N=100;
sampling_time_observation=0.5; % resampling frequnecy
X0=[1;0;0];   %True initial conditions
K(1)=0.06;
K(2)=0.15;
K(3)=0.8;
K(4)=1;
K=K';
FT=240;      %Total time length

%% Generate a reference process and observation
%delete XF
%delete TXF
tic
    [K,XF,TXF]=modified_next_reaction_method_full_model(K,X0,FT);
toc

[Y,TY]=observation_discrete_time(TXF,XF,sampling_time_observation);
stairs(TXF,XF(3,:));
hold on
stairs(TXF,XF(2,:));
hold on
plot(TY,Y/20,'o--');

%% filter
tic
 [T_RF,R_filter_tau, R_filterSD_tau, R_filter_tau_div, R_filter_tau_final_distribution, R_filter_tau_particles]=particle_filter(TY, Y, M, 'Tau', 'RPF_NS', 0.9, 1);
toc
tic
 [T_RF,SIR_filter_tau, SIR_filterSD_tau, SIR_filter_tau_div, SIR_filter_tau_final_distribution, SIR_filter_tau_particles]=particle_filter(TY, Y, M, 'Tau', 'SIR', 0, 1);
toc



%% Figures

plot_trajectory_result(TXF,XF,K,TY,Y,SIR_filter_tau, SIR_filterSD_tau,R_filter_tau, R_filterSD_tau)
plot_parameter_result(K,T_RF,SIR_filter_tau_particles, R_filter_tau_particles)
plot_particle_evolution(K,T_RF,SIR_filter_tau_particles, R_filter_tau_particles)