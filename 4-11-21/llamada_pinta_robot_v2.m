clear all
clc
robot=hgtransform;
cabeza=hgtransform('Parent',robot);

distancia=5;
mapa=load('mapa2.dat');
%pinta_robot(3,3,0,0,robot,cabeza,distancia);

for alfa=0:0.01:pi/2
    mapa=pinta_robot_v2(0,0,0,alfa,robot,cabeza,distancia,mapa);
    drawnow;
end