% update weights where w is the previous weights, x is 
% the simulated state and y is observation. 

function w=weights_calculation_discrete_time(w,x,y,max_log_weight) 

w=w* exp(-(y-h_function(x))^2/2-max_log_weight);