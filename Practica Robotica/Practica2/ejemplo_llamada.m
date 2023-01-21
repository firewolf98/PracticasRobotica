%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ejemplo de la llamada a la función 
% funcion_spline_cubica_varios_puntos.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
xc=[0 0 20 40 40];
yc=[0 5 20 35 40];



ds=3; %distancia entre puntos en cm.
camino=funcion_spline_cubica_varios_puntos(xc,yc,ds)';

 plot(camino(:,1),camino(:,2),'or','LineWidth',3)
 hold on
 plot(xc,yc,'*g')