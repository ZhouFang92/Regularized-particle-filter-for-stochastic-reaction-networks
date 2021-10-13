function [Y,TY]=observation_discrete_time(TVF,XF,sampling_time_observation) 

TY=[sampling_time_observation:sampling_time_observation:TVF(size(TVF,2))];

for i=1:size(TY,2)
    tmax=find(TVF <= sampling_time_observation*i,1,'last');       % Find the last update before the end of interval
    Y(i)=h_function(XF(:,tmax))+normrnd(0,1);
end