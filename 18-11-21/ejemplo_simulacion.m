clear all
clc
tstart=tic;
 i=1;
 t(i)=toc(tstart);
 
 %condiciones inciales
 encoder1(i)=0;
 encoder2(i)=0;
 x(i)=0;
 y(i)=0;
 theta(i)=0;
 mapa=[];
 SR_robot = hgtransform;
 SR_cabeza = hgtransform('Parent',SR_robot);
 
global radio_rueda
global l %distancia entre centro y rueda

radio_rueda=3;
l=1;

 
 while t(i)<5
 i=i+1;
 
  t(i)=toc(tstart);

  %velocidades de las ruedas.
    w1=0;
    w2=1;

 %simulamos la evolución de los encoders   
 encoder1(i)=w1*t(i);
 encoder2(i)=w2*t(i);
 
 %simulamos la odometría

 [x(i) y(i) theta(i)]=calculo_odometria(encoder1,encoder2,x,y,theta,i);
 
 %Dibujamos la simulación
 
 mapa=pinta_robot_v2(x(i), y(i), theta(i), 0, SR_robot, SR_cabeza,0,mapa);
 drawnow;
 
 end
 
 plot(t,encoder1,t,encoder2)
 
   