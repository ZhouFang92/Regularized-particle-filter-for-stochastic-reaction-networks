function plot_particle_evolution(K,T_filter,SIRPF_particles, RPF_particles)

f = figure;
f.Units='centimeters';
f.OuterPosition=[10 10 12 11];

for k=1:24:121
for i=1:2
    for j=1:i-1
    
y1=SIRPF_particles(k,2,:);
x1=SIRPF_particles(k,1,:);
y2=RPF_particles(k,2,:);
x2=RPF_particles(k,1,:);

subplot(2,3, (k-1)/24+1);
scatter2 = scatter(x2,y2,10,'MarkerFaceColor','r','MarkerEdgeColor','r');
scatter2.MarkerFaceAlpha = 0.1;
scatter2.MarkerEdgeAlpha = 0.1;
%scatter1.MarkerFaceAlpha = 0.2;
%scatter1.MarkerEdgeAlpha = 0.2;
%h1=plot(x2,y2,'r.');
hold on
scatter1 = scatter(x1,y1,10,'MarkerFaceColor','b','MarkerEdgeColor','b');
scatter1.MarkerFaceAlpha = 0.1;
scatter1.MarkerEdgeAlpha = 0.1;
hold on
plot(K(1),K(2),'black.','Markersize',20);

axis([0 1 0 1])
yticks([0:0.5:1]);
xticks([0:0.5:1]);
xlabel('$k''_1$','Interpreter','latex','FontSize',10)
ylabel('$k''_2$','Interpreter','latex','FontSize',10)

title_string=sprintf('Time: %d mins',(k-1)*2);

title(title_string,'FontSize',10);





    end 
end
end