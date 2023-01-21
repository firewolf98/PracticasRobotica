clear;
mi_robot=legoev3('USB');
pulsador=touchSensor(mi_robot,2);
sonar=sonicSensor(mi_robot,3);
motor_cabeza = motor(mi_robot,'D');
%motor_der=motor(mi_robot,'B');
SR_robot=hgtransform;
SR_cabeza=hgtransform('Parent',SR_robot);

while(readTouch(pulsador)==0)
    disp 'Esperando pulsación'
end

while(readTouch(pulsador)==1)
end
i=1;
clc;
tstart=tic;
t(i)=toc(tstart);
tiempo_final=10;
d=[];
angulo=[];
k=0.4999;
%mapa=[];

resetRotation(motor_cabeza);
%resetRotation(motor_der);
angulo(1)=readRotation(motor_cabeza);
% referencia(1)=readRotation(motor_der);
delay=1;
periodo=8;
amplitud=90;
referencia(i)=senof(t(i),delay,periodo,amplitud);
error(1)=referencia(1)-angulo(1);

while((t(i)<tiempo_final)&&(readTouch(pulsador)==0))
    i=i+1;
    t(i)=toc(tstart);
    
    start(motor_cabeza);
    %start(motor_der);
    
    angulo(i)=readRotation(motor_cabeza);
    giro_cabeza=deg2rad(double(angulo(i)));
    
    distancia=double(sonar.readDistance()*10);
    %referencia(i)=readRotation(motor_der);
    referencia(i)=senof(t(i),delay,periodo,amplitud);
    error(i)=referencia(i)-angulo(i);
    controlador(i)=k*error(i);
    Potencia(i)=controlador(i);
    if(Potencia>100)
        Potencia=100;
    elseif(Potencia<-100)
        Potencia=-100;
    end
    motor_cabeza.Speed=Potencia(i);
    pinta_robot_v3(1,1,0,giro_cabeza,SR_robot,SR_cabeza,distancia);
    drawnow;
    %disp 'Pulse para salir'
    readTouch(pulsador);
end

%plot(d);
stop(motor_cabeza)
%stop(motor_der)
%an=angulo/t(i);
%plot(an)
plot(t,referencia);
%plot(angulo,referencia);
hold on
plot(t,angulo);