%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controla la convergencia del robot EV3 a un punto mediante una estrategia de control geométrico.
% utiliza los encoders de los motores para  calcular la odometría
% utiliza un  switch, para comenzar y terminar  la rutina
%
% Utiliza los script: 
% Traction_motor_control_laboratorio.m; Signal_reading_odo_path_following.m;  Para.m.
%
% Utiliza las funciones: calculo_calculo_odometria.m; 
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 15/01/2021. FGB.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc

%---------------------------------------------
%comentar cuando la conexión sea WiFi 
clear all
 mi_Robot = legoev3('USB')

%variables control angulo del robot
    clear yaw
    clear x y theta
    clear giro_derecho giro_izquierdo

    global radio_rueda
    global l %distancia entre ruedas
    global camino


%----------------------------------------
% Variables para la representación gráfica
%------------------------------------------

% %Crea los sistemas de referencia del robot y de la cabeza para la
% %representación utilizando la función pinta_robot_v2
%     SR_robot = hgtransform;
%     SR_cabeza = hgtransform('Parent',SR_robot);
%-----------------------------------------

%------------------------------
%Valores para la odometría
      l=5.9;
      radio_rueda=2.7
      conversion_potencia=7.2;
%----------------------------


% Declaración de sensores
    Detecta_colision = touchSensor(mi_Robot,1); %Switch conectado al puerto 1.
    Pulsador = touchSensor(mi_Robot,2); %Switch conectado al puerto 2.
    Sonar = sonicSensor(mi_Robot); %definición del sonar

% Declaración de los motores
    motor_cabeza = motor(mi_Robot,'D') %motor de la cabeza
    motor_izquierdo = motor(mi_Robot,'A') %Motor izquierdo
    motor_derecho = motor(mi_Robot,'B') %Motor_derecho

%Activacion de los motores
    start(motor_cabeza);
    start(motor_izquierdo);
    start(motor_derecho);

%inicializa velocidad de motores
    Power1=0;
    Power2=0;

%reset del encoder de motores
    resetRotation(motor_izquierdo);
    resetRotation(motor_derecho);

%indice inicial
    i=1;

%valores iniciales de los encoders
    giro_derecho(i)=0;
    giro_izquierdo(i)=0;


%--------------------
% Valores iniciales
%--------------------
%tiempo inicial
    t(i)=0;
    x(i)=0;
    y(i)=0;
    theta(i)=pi/2;
    yaw(i)=90;
    

%comienza el bucle
disp('pulsa el bumper para comenzar')

%camino=load('camino.dat');

yr=0:1:40;
xr=0*yr;
camino=[xr' yr'];

while(readTouch(Pulsador)==0) 
end

while(readTouch(Pulsador)==1)
end


disp('comienza el bucle')
tf=60;
%referencia tiempo inicial
    tstart = tic;

while  (readTouch(Pulsador)==0) & (t(i)<tf)
  
        i=i+1; %indice global
        t(i)= toc(tstart); %tiempo global del bucle
    %---------------------
    %lectura señales y calculo del heading
    %-------------------------------
    
        Signal_reading_odo_path_following;
      
      %-----------------------------
       %Calcula Odometría
      %--------------------------  
    %calculo odometria
        [x(i) y(i) theta(i)]=calculo_odometria(giro_derecho,giro_izquierdo,x,y,theta,i);
    %para controlar el giro
        yaw(i)=theta(i)*180/pi;
   
    
%----------------------------
% Control Geométrico

%Punto mas cercano
 orden_minimo=minima_distancia(camino,[x(i) y(i)]);
 
 Look_ahead=10;
 
 if(orden_minimo+Look_ahead<length(camino))
     punto=[camino(orden_minimo+Look_ahead,1),camino(orden_minimo+Look_ahead,2)];
 else
     punto=[camino(end,1),camino(end,2)];
 end
 %punto=[0 40];    


 delta= (x(i)-punto(1))*sin(theta(i))-(y(i)-punto(2))*cos(theta(i));
 
 LH=sqrt((x(i)-punto(1))^2+(y(i)-punto(2))^2);
 
 rho=2*delta/LH^2;
 
 

%Control proporcional de la velocidad
 Kp=1.1;
 %final=[camino(end,1) camino(end,2)]; %para converger al final del camino
 final=punto; %para converger a un punto
 Distance_to_end=sqrt((x(i)-final(1))^2+(y(i)-final(2))^2);
 velocidad=Kp*Distance_to_end;
 
 
 if velocidad>15
     velocidad=15;
 end
 
 if Distance_to_end<3
     break
 end

 
 %-------------------------------------
 % modelo Inverso
 %-------------------------------------
 
    velocidad_derecha=velocidad*(1+l*rho)/radio_rueda;
 
    velocidad_izquierda=velocidad*(1-l*rho)/radio_rueda;
    
%---------------------------------------------------
% Cversión de velocidad a potencia
    

    Power1_a(i)=velocidad_derecha*conversion_potencia;
    Power2_a(i)=velocidad_izquierda*conversion_potencia;

    Power1=Power1_a(i);
    Power2=Power2_a(i);
    
    

      %---------------------
        %Manda los comandos de control a los motores
      %-------------        
        Traction_motor_control_laboratorio;
        
  
    
end %del while

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para motores y cierra sensores
%-------------------------------
 Para;


figure

plot(x,y)

axis equal


