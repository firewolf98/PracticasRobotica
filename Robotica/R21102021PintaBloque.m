%NOTA: todo esto es cierto para solidos rigidos y no para solidos deformables
% porque los puntos pueden cambiar de posicion en relacion al sistema de referencia local.

pinta_bloque(eye(4,4),'r'); %eye(4,4) matriz de transformacion que se pasa
%como argumento para dibujar el bloque es la matriz unidad

%Definimos las coordenadas de los puntos en el sistema de referencia local
p_central_L=[0 0 6 1]'; %el 1 del final es para definir el vector de posicion extendida
p1_L=[1.5 1.5 6 1]';    %que hace que el vector tenga 4 componentes para que se pueda
p2_L=[-1.5 1.5 6 1]';   %multiplicar por la matriz
p3_L=[-1.5 -1.5 6 1]';
p4_L=[1.5 -1.5 6 1]';

%Dibujamos los puntos en el local
plot3(p_central_L(1),p_central_L(2),p_central_L(3),'*b');
plot3(p1_L(1),p1_L(2),p1_L(3),'*b');
plot3(p2_L(1),p2_L(2),p2_L(3),'*b');
plot3(p3_L(1),p3_L(2),p3_L(3),'*b');
plot3(p4_L(1),p4_L(2),p4_L(3),'*b');

%Definimos una matriz de transformacion asociada a una serie de movimientos
%Movimiento a (5,5,5), Rotacion  alrededor del eje X, Rotacion alrededor
%del eje Z.
matriz_final=makehgtform('translate',5,5,5)*makehgtform('xrotate',pi/2)*makehgtform('zrotate',pi/4);
%Dibujamos la matriz transformada
pinta_bloque(matriz_final,'b');

%Transformamos los puntos del Sistema de Referencias Local al Sistema de
%Referencias Global
p_central_G=matriz_final*p_central_L;
p1_G=matriz_final*p1_L;
p2_G=matriz_final*p2_L;
p3_G=matriz_final*p3_L;
p4_G=matriz_final*p4_L;

%Dibujamos los puntos usando sus Coordenadas Globales
plot3(p_central_G(1),p_central_G(2),p_central_G(3),'*r');
plot3(p1_G(1),p1_G(2),p1_G(3),'*r');
plot3(p2_G(1),p2_G(2),p2_G(3),'*r');
plot3(p3_G(1),p3_G(2),p3_G(3),'*r');
plot3(p4_G(1),p4_G(2),p4_G(3),'*r');