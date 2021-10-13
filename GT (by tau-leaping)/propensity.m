% return the value of propensity given the state X, the number of
% reaction j, and reaction constants kj.

function a=propensity(X,j,K) 

if j == 1 
    a=K(1)*X(1);
end

if j == 2
    a=K(2)*X(2);
end

if j == 3
    a=K(3)*X(2);
end

if j==4
    a=K(4)*X(3);
end

