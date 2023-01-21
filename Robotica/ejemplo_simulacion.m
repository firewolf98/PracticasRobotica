clear all
clc
joy=vrjoystick(1);
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
    
    w1=-axis(joy,2);
    w2=-axis(joy,5);

    dt(i)=t(i)-t(i-1);
 %simulamos la evolución de los encoders   
 encoder1(i)=encoder1(i-1)+w1*t(i);
 encoder2(i)=encoder2(i-1)+w2*t(i);
 
 %simulamos la odometría

 [x(i) y(i) theta(i)]=calculo_odometria(encoder1,encoder2,x,y,theta,i);
 
 %Dibujamos la simulación
 
 pinta_robot(x(i),y(i),theta(i),0,SR_robot,SR_cabeza);
 drawnow
 
 end
 
 plot(t,encoder1,t,encoder2)
 
   