function DX=reaction_direction(j)

if j == 1 
    DX=[1; -1; 0; -1]; %DX=[1; -1; 0; 0];
end

if j == 2
    DX=[-1; 1; 0; 1];  %DX=[-1; 1; 0; 0];
end

if j==3
    DX=[0;0;1;0];
end

if j==4
    DX=[0;0;-1;0];
end

if j==5
    DX=[0;0;0;1];
end

if j==6
    DX=[0;0;0;-1]; 
end