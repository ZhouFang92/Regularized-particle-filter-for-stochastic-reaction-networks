function plot_parameter_result(K,T_filter,SIRPF_particles, RPF_particles)

f = figure;
f.Units='centimeters';
f.OuterPosition=[10 10 11 11];


M=size(SIRPF_particles,3);

for i=1:2
    for j=1:i-1
    
y1=SIRPF_particles(size(T_filter,2),i,:);
x1=SIRPF_particles(size(T_filter,2),j,:);
y2=RPF_particles(size(T_filter,2),i,:);
x2=RPF_particles(size(T_filter,2),j,:);

subplot(2,2, (i-1)*2+j);
scatter1 = scatter(x2,y2,10,'MarkerFaceColor','r','MarkerEdgeColor','r');
scatter1.MarkerFaceAlpha = 0.1;
scatter1.MarkerEdgeAlpha = 0.1;
%h1=plot(x2,y2,'r.');
hold on
%scatter2 = scatter(x3,y3,1,'MarkerFaceColor','c','MarkerEdgeColor','c');
hold on
scatter2 = scatter(x1,y1,10,'MarkerFaceColor','b','MarkerEdgeColor','b');
scatter2.MarkerFaceAlpha = 0.1;
scatter2.MarkerEdgeAlpha = 0.1;
hold on
true_value=plot(K(j),K(i),'black.','Markersize',20);

    ymax=1;
    dy=0.5;

    xmax=1;
    dx=0.5;

axis([0 xmax 0 ymax])
yticks([0:dy:ymax]);
xticks([0:dx:xmax]);

if j==1
   if i==2 
      ylabel('$k''_2$','Interpreter','latex','FontSize',10)
   elseif i==3
      ylabel('$k''_3$','Interpreter','latex','FontSize',10)
   elseif i==4
      ylabel('$k''_4$','Interpreter','latex','FontSize',10)
   else
      ylabel('$k''_5$','Interpreter','latex','FontSize',10)
   end
end

if i==2
   if j==1 
      xlabel('$k''_1$','Interpreter','latex','FontSize',10)
   elseif j==2
      xlabel('$k''_2$','Interpreter','latex','FontSize',10)
   elseif j==3
      xlabel('$k''_3$','Interpreter','latex','FontSize',10)
   else 
      xlabel('$k''_4$','Interpreter','latex','FontSize',10)
   end
end

if i==2 && j==1
    legend([true_value,scatter1,scatter2],{'True value','RPF','SIRPF'},'Location','northeast','FontSize',7,'Orientation','vertical');
end

    end 
end

%plot diagonal panels

for i=1:2
   subplot(2,2, (i-1)*2+i);
   x1=SIRPF_particles(size(T_filter,2),i,:);
   x2=RPF_particles(size(T_filter,2),i,:);
     xmax=1;
     dx=0.01;
     
   index=1;
   clear SIR_distribution;
   clear RPF_distribution;
   for j=0:dx:xmax
      RPF_distribution(index)=size(find(x2>=j & x2<j+dx),1)/dx;
      index=index+1;
   end
   index=1;
   for j=0:dx/10:xmax
      SIR_distribution(index)=size(find(x1>=j & x1<j+dx/10),1)/(dx/10);
      index=index+1;
   end
   true_value=plot(K(i)*ones(11,1),[0:10:100],'black','LineWidth',1.1);
   hold on
   scatter2=plot([0:dx/10:xmax],SIR_distribution/M,'b');
   hold on 
   scatter1=plot([0:dx:xmax],RPF_distribution/M,'r');
   axis([0 xmax 0 max(RPF_distribution)/M+0.2])
   xticks([0:xmax/2:xmax]);
   if i==2
        xlabel('$k''_2$','Interpreter','latex','FontSize',10)
        legend([true_value,scatter1,scatter2],{'True value','RPF','SIRPF'},'Location','northeast','FontSize',7,'Orientation','vertical');
   end
end

% plot particles

%{
for i=1:4
    subplot(4,5, (i-1)*5+1);
    for t=1:size(T_filter,2)
        y2=RPF_particles(t,i,:);
        scatter2 = scatter(T_filter(t)*ones(M,1),y2,1,'MarkerFaceColor','r','MarkerEdgeColor','r');
        hold on
    end
    
    for t=1:size(T_filter,2)
        y1=SIRPF_particles(t,i,:);
        scatter1 = scatter(T_filter(t)*ones(M,1),y1,1,'MarkerFaceColor','r','MarkerEdgeColor','b');
        hold on
    end
    plot(T_filter,K(i)*ones(size(T_filter,2)),'black','LineWidth',1.1);
    hold on;
    
    
   if i==1 
      ylabel('$k''_1$','Interpreter','latex','FontSize',16)
      ymax=0.3;
   elseif i==2
      ylabel('$k''_2$','Interpreter','latex','FontSize',16)
      ymax=0.3;
   elseif i==3
      ylabel('$k''_3$','Interpreter','latex','FontSize',16)
      ymax=2;
   else
      ylabel('$k''_4$','Interpreter','latex','FontSize',16)
      xlabel('time (minute)','FontSize',16)
      ymax=2;
   end
   
   axis([0 T_filter(size(T_filter,2)) 0 ymax]);
    
    
end
%}