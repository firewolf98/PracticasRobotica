pulsador=touchSensor(mi_robot,2);
%sonar=sonicSensor(mi_robot,3);
motor_cabeza = motor(mi_robot,'D');

while(readTouch(touchSensor(mi_robot,2))==0)
    disp 'Esperando pulsación'
end

while(readTouch(touchSensor(mi_robot,2))==1)
end
i=1;
clc;
tstart=tic;
t(i)=toc(tstart);
tiempo_final=10;
d=[];
angulo=[];
angulo(i)=readRotation(motor_cabeza);
while((t(i)<tiempo_final)&&(readTouch(touchSensor(mi_robot,2))==0))
    i=i+1;
    t(i)=toc(tstart);
    
    start(motor_cabeza);
    motor_cabeza.Speed=15;
    angulo(i)=readRotation(motor_cabeza);
    %d(i)=readDistance(sonar);
   % disp 'Pulse para salir'
end

%plot(d);
stop(motor_cabeza)
an=angulo/t(i);
plot(an)
