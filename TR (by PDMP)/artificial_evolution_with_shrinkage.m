function k_out=artificial_evolution_with_shrinkage(M,k_in,eta,alpha)

for i=1:size(k_in,1)
  theta(i)=mean(k_in(i,:));
end

h=eta;

epsilon=10^-16;

V=cov(k_in');

%alpha=sqrt(1-h^2/M);

for j=1:M
   mean1=k_in(:,j)+(1-alpha)*(theta'-k_in(:,j));
   variance=h^2*V/M+epsilon*eye(min(size(k_in)))/M;
   a=mvnrnd(mean1',variance);
   k_out(1,j)=min(a(1),0.3);
   k_out(1,j)=max(k_out(1,j),0.03);
   k_out(2,j)=min(a(2),0.3);
   k_out(2,j)=max(k_out(2,j),0.03);
   k_out(3,j)=min(a(3),2);
   k_out(3,j)=max(k_out(3,j),0.2);
   k_out(4,j)=min(a(4),2);
   k_out(4,j)=max(k_out(4,j),0.2);
end