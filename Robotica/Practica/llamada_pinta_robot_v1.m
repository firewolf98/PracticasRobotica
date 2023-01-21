clear all
clc
robot=hgtransform;
cabeza=hgtransform('Parent',robot);

distancia=5;

%pinta_robot(3,3,0,0,robot,cabeza,distancia);

for alfa=0:0.01:pi/2
    pinta_robot_v3tam(0,0,0,alfa,robot,cabeza,distancia);
    drawnow;
end