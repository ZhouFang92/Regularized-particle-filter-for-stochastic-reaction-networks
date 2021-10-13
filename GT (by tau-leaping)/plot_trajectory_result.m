function plot_trajectory_result(TXF,XF,K,TY,Y,SIR_filter,SIR_filter_SD,RPF,RPF_SD)

f = figure;
f.Units='centimeters';
f.OuterPosition=[10 10 22 10];
Yaxis_left=200;

N=50;

SIR_filter_SD=SIR_filter_SD.^(1/2);
RPF_SD=RPF_SD.^(1/2);

if size(K,1)==1
    K=K';
end

T(1)=TXF(1);
X(:,1)=XF(:,1);
for i=2:size(TXF,2)
   T(2*i-3)=TXF(i);
   X(:,2*i-3)=XF(:,i-1);
   T(2*i-2)=TXF(i);
   X(:,2*i-2)=XF(:,i);
end
TXF=T;
XF=X;

subplot(2,2,1);

plot(TY,Y,'blacko--')

xlabel('Time (minutes)','FontSize',10)
ylabel('Observations','FontSize',10)
axis([Yaxis_left TY(size(TY,2)) -5 30]);
%title('(A)','FontSize',16)

TY=[0,TY];


subplot(2,2,2);
X=[1:4];
K_error=[abs(SIR_filter(1:4,size(SIR_filter,2))-K), abs(RPF(1:4,size(RPF,2))-K)];
%SD_error=[abs(filter_true2(1:6,size(filter_true,2))), abs(filter_approximate2(1:6,size(filter_true,2)))];
b=bar(X,K_error,0.9);
%axis([0.5 6.5 0 0.25]);
set(gca,'TickLabelInterpreter','latex');
set(gca,'xticklabel',{'$k''_1$','$k''_2$','$k''_3$','$k''_4$'},'FontSize',10);
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','r');
legend(b,{'SIRPF','RPF'},'Location','northwest','FontSize',7,'Orientation','horizontal');
ylabel({'Error in parameter'; 'inference (final time)'},'FontSize',10)
xlabel('Reaction constants','FontSize',10)

subplot(2,2,3)
yneg = RPF_SD(6,:);
ypos = RPF_SD(6,:);
for i=1:size(yneg,2)
    yneg(i)=min(yneg(i),RPF(6,i)-0);
    ypos(i)=min(ypos(i),1-RPF(6,i));
end
RPF_plot=errorbar(TY+0.1,RPF(6,:),yneg,ypos,'r.','LineWidth',1.2);
hold on;
yneg = SIR_filter_SD(6,:);
ypos = SIR_filter_SD(6,:);
for i=1:size(yneg,2)
    yneg(i)=min(yneg(i),SIR_filter(6,i)-0);
    ypos(i)=min(ypos(i),1-SIR_filter(6,i));
end
SIR_plot=errorbar(TY,SIR_filter(6,:),yneg,ypos,'b.','LineWidth',1.2);
%SIR_plot=plot(TY, SIR_filter(6,:),'r--*','LineWidth',1);
hold on
true_value=stairs(TXF,XF(2,:),'black','LineWidth',1.2);
hold on;
axis([Yaxis_left TY(size(TY,2)) 0 1+0.5])
yticks([0:1:1])
set(gca,'FontSize',10);
%box off; 
xlabel('Time (minutes)','FontSize',10)
ylabel('Activated DNA','FontSize',10)
%title('(B)','position',[25 -0.25],'FontSize',16);
legend([true_value,SIR_plot,RPF_plot],{'True value','SIRPF','RPF'},'Location','northwest','FontSize',7,'Orientation','horizontal');

subplot(2,2,4)
true_value=stairs(TXF,N*XF(3,:),'black','LineWidth',1.2);
hold on;
yneg = RPF_SD(7,:);
ypos = RPF_SD(7,:);
for i=1:size(yneg,2)
    yneg(i)=min(yneg(i),RPF(7,i)-0);
    %ypos(i)=min(ypos(i),1-RPF(7,i));
end
RPF_plot=errorbar(TY,N*RPF(7,:),N*yneg,N*ypos,'r.','LineWidth',1.2);
hold on
yneg = SIR_filter_SD(7,:);
ypos = SIR_filter_SD(7,:);
for i=1:size(yneg,2)
    yneg(i)=min(yneg(i),SIR_filter(7,i)-0);
    %ypos(i)=min(ypos(i),1-SIR_filter(6,i));
end
SIR_plot=errorbar(TY,N*SIR_filter(7,:),N*yneg,N*ypos,'b.','LineWidth',1.2);
%SIR_plot=plot(TY, SIR_filter(6,:),'r--*','LineWidth',1);
axis([Yaxis_left TY(size(TY,2)) 0 80])
yticks([0:20:100])
set(gca,'FontSize',10);
%box off; 
xlabel('Time (minutes)','FontSize',10)
ylabel('RNA','FontSize',10)
%title('(B)','position',[25 -0.25],'FontSize',16);
legend([true_value,SIR_plot,RPF_plot],{'True value','SIRPF','RPF'},'Location','northeast','FontSize',7,'Orientation','horizontal');