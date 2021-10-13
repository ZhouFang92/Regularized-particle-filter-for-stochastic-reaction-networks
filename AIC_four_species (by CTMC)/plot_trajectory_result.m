function plot_trajectory_result(TXF,XF,K,TY,Y,SIR_filter,SIR_filter_SD,SIR_particles,RPF,RPF_SD,RPF_particles)

f = figure;
f.Units='centimeters';
f.OuterPosition=[10 10 22 10];
Yaxis_min=120;


N=100;

SIR_filter_SD=SIR_filter_SD.^(1/2);
RPF_SD=RPF_SD.^(1/2);

if size(K,1)==1
    K=K';
end

%T(1)=TXF(1);
%X(:,1)=XF(:,1);
%for i=2:size(TXF,2)
%   T(2*i-3)=TXF(i);
%   X(:,2*i-3)=XF(:,i-1);
%   T(2*i-2)=TXF(i);
%   X(:,2*i-2)=XF(:,i);
%end
%TXF=T;
%XF=X;

subplot(2,2,1);

plot(TY,Y,'blacko--')

xlabel('Time (minutes)','FontSize',10)
ylabel('Observations','FontSize',10)
axis([Yaxis_min TY(size(TY,2)) -5 300]);
%title('(A)','FontSize',16)

TY=[0,TY];


subplot(2,2,2);
X=[1:2];
K_error=[abs(SIR_filter(1:2,size(SIR_filter,2))-K(1:2)), abs(RPF(1:2,size(RPF,2))-K(1:2))];
%SD_error=[abs(filter_true2(1:6,size(filter_true,2))), abs(filter_approximate2(1:6,size(filter_true,2)))];
b=bar(X,K_error,0.9);
%axis([0.5 6.5 0 0.25]);
set(gca,'TickLabelInterpreter','latex');
%set(gca,'xticklabel',{'$k''_1$','$k''_2$','$k''_3$','$k''_4$','$k''_5$'},'FontSize',10);
set(gca,'xticklabel',{'$k''_1$','$k''_2$'},'FontSize',10);
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','r');
legend(b,{'SIRPF','RPF'},'Location','northwest','FontSize',7,'Orientation','horizontal');
ylabel({'Error in parameter'; 'inference (final time)'},'FontSize',10)
xlabel('Reaction constants','FontSize',10)

subplot(2,2,3)
yneg = SIR_filter_SD(9,:);
ypos = SIR_filter_SD(9,:);
for i=1:size(yneg,2)
    yneg(i)=min(yneg(i),SIR_filter(9,i)-0);
    %ypos(i)=min(ypos(i),1-SIR_filter(6,i));
end
SIR_plot=errorbar(TY,SIR_filter(9,:),yneg,ypos,'b.','LineWidth',0.5);
hold on;
yneg = RPF_SD(9,:);
ypos = RPF_SD(9,:);
for i=1:size(yneg,2)
    yneg(i)=min(yneg(i),RPF(9,i)-0);
    %ypos(i)=min(ypos(i),1-RPF(6,i));
end
RPF_plot=errorbar(TY,RPF(9,:),yneg,ypos,'r.','LineWidth',0.5);
%SIR_plot=plot(TY, SIR_filter(6,:),'r--*','LineWidth',1);
hold on
true_value=stairs(TXF,XF(3,:),'black','LineWidth',1.2);
hold on
axis([Yaxis_min TY(size(TY,2)) 0 25])
yticks([0:5:20])
set(gca,'FontSize',10);
%box off; 
xlabel('Time (minutes)','FontSize',10)
ylabel('Regulated species (S_3)','FontSize',10)
%title('(B)','position',[25 -0.25],'FontSize',16);
legend([true_value,SIR_plot,RPF_plot],{'True value','SIRPF','RPF'},'Location','northwest','FontSize',7,'Orientation','horizontal');

subplot(2,2,4)

for i=1:size(TY,2)
SIR_set_points(i,:)=SIR_particles(i,1,:)./SIR_particles(i,2,:);
SIR_set_point_mean(i)=mean(SIR_set_points(i,:));
SIR_set_point_SD(i)=sqrt(var(SIR_set_points(i,:)));
RPF_set_points(i,:)=RPF_particles(i,1,:)./RPF_particles(i,2,:);
RPF_set_point_mean(i)=mean(RPF_set_points(i,:));
RPF_set_point_SD(i)=sqrt(var(RPF_set_points(i,:)));
end

for i=1:size(yneg,2)
    yneg(i)=RPF_set_point_SD(i);
    ypos(i)=yneg(i);
    yneg(i)=min(yneg(i),RPF_set_point_mean(i)-0);
end
RPF_plot=errorbar(TY,RPF_set_point_mean,yneg,ypos,'r.','LineWidth',0.5);
hold on;
for i=1:size(yneg,2)
    yneg(i)=SIR_set_point_SD(i);
    ypos(i)=yneg(i);
    yneg(i)=min(yneg(i),SIR_set_point_mean(i)-0);
end
SIR_plot=errorbar(TY,SIR_set_point_mean,yneg,ypos,'b.','LineWidth',0.5);
hold on;
true_value=stairs(TXF,K(1)/K(2)*ones(1,size(TXF,2)),'black','LineWidth',1.2);
hold on
axis([Yaxis_min TY(size(TY,2)) 0 10])
%axis([0 TY(size(TY,2)) 0 10])
yticks([0:2:10])
set(gca,'FontSize',10);
%box off; 
xlabel('Time (minutes)','FontSize',10)
ylabel('Set point (k_1/k_2)','FontSize',10)
%title('(B)','position',[25 -0.25],'FontSize',16);
legend([true_value,SIR_plot,RPF_plot],{'True value','SIRPF','RPF'},'Location','northeast','FontSize',7,'Orientation','horizontal');