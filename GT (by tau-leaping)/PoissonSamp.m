% -------------------------------------------------------------
  function S = PoissonSamp(lambda)
% -------------------------------------------------------------
% Generate a random sample S of size ns from the (discrete)
% Poisson distribution with parameter lambda.
% Fixed error: 
%    CHANGED k = 1; produ = 1; produ = produ*rand 
%    TO      k = 0; produ = rand;
% Derek O'Connor, 24 July 2012.  derekroconnor@eircom.net
% Knuth's algorithm
% 

if lambda<700
      k = 0;
      produ = rand;
      while produ >= exp(-lambda)
          produ = produ*rand;
          k = k+1;
      end
      S = k;
else
    S=poissrnd(lambda);  
end