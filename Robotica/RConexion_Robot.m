%Comunicacion con el robot
mi_Robot=legoev3('USB');
%Elementos sensoriales y de actuacion
%Inicializamos los motores
motor_izq=motor(mi_Robot,'A');
motor_der=motor(mi_Robot,'B');
motor_cab=motor(mi_Robot,'D');
%Activamos los motores
start(motor_izq);
start(motor_der);
start(motor_cab);
%Establecemos la velocidad de los motores
motor_cab.speed=50; %velocidad al 50% de su capacidad
%se puede dar valores del -100 al 100
%si la velocidad proviene de un atributo distinto de int hay que hacer un
%cambio de tipo  motor_cab.speed=int8(variable);
%Finalizar el uso de los motores
stop(motor_cab);

giro_cab=readRotation(mi_Robot);%para ver los grados girados por el motor

%Sensores
Pulsador=touchSensor(mi_Robot,2);
readTouch(Pulsador);%para conocer la lectura del sensor
Sonar=sonicSensor(mi_Robot,3);
readDistance(Sonar);%para conocer la lectura del sensor