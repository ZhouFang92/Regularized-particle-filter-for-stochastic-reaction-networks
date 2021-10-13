%% initialization
%clear;
M=2000;%4000; %number of particles
N=10000;
sampling_time_observation=2; % resampling frequnecy
X0=[0;1;5;1];   %True initial conditions
K(7)=0.8; % a redundant parameter
K(1)=0.2;
K(2)=0.1;
K(3)=0.8;
K(4)=0.4;
K(5)=0.5;
K(6)=0.7;
K=K';
FT=240;      %Total time length

%% Generate a reference process and observation
%delete XF
%delete TXF
tic
    [K,XF,TXF]=modified_next_reaction_method_full_model(K,X0,FT);
toc

[Y,TY]=observation_discrete_time(TXF,XF,sampling_time_observation);
stairs(TXF,XF(2,:));
hold on
stairs(TXF,XF(3,:));
hold on
stairs(TXF,XF(4,:));
hold on
plot(TY,Y/20,'o--');

%% filter
tic
 [T_RF,R_filter_PDMP, R_filterSD_PDMP, R_filter_PDMP_div, R_filter_PDMP_final_distribution, R_filter_PDMP_particles]=particle_filter(TY, Y, M, 'PDMP', 'RPF_NS', 1.8, 1);
toc
tic
 [T_RF,SIR_filter_PDMP, SIR_filterSD_PDMP, SIR_filter_PDMP_div, SIR_filter_PDMP_final_distribution, SIR_filter_PDMP_particles]=particle_filter(TY, Y, M, 'PDMP', 'SIR', 0, 1);
toc

%% Figures

plot_trajectory_result(TXF,XF,K,TY,Y,SIR_filter_PDMP, SIR_filterSD_PDMP,R_filter_PDMP, R_filterSD_PDMP)
plot_parameter_result(K,T_RF,SIR_filter_PDMP_particles, R_filter_PDMP_particles)
plot_particle_evolution(K,T_RF,SIR_filter_PDMP_particles, R_filter_PDMP_particles)

