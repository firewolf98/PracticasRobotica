clear;
clear t
%variables control movimiento cabeza
    clear giro_cabeza
    clear referencia_cabeza
    clear distancia;
    clear error_sonar;

%variables control angulo del robot
    clear ang_vel;
    clear yaw
    clear error_yaw
    clear referencia_yaw
    clear x y theta
    clear giro_derecho giro_izquierdo
    
    global radio_rueda
    global l %distancia entre ruedas

    l=6;
    radio_rueda=3;
    
mi_robot=legoev3('USB');

%Declaracion de sensores
Detecta_colision = touchSensor(mi_robot,1); %Switch conectado al puerto 1.
pulsador=touchSensor(mi_robot,2);
sonar=sonicSensor(mi_robot,3);

%Declaracion de motores
motor_cabeza = motor(mi_robot,'A');
motor_derecho=motor(mi_robot,'C');
motor_izquierdo=motor(mi_robot,'B');
%Activacion de los motores
    start(motor_cabeza);
    start(motor_izquierdo);
    start(motor_derecho);
%inicializa velocidad de motores
    Power1=0;
    Power2=0;
    Power_cabeza=0;
%reset del encoder de motores
    resetRotation(motor_cabeza);
    resetRotation(motor_izquierdo);
    resetRotation(motor_derecho);

%indice inicial
i=1;
%referencia tiempo inicial
tstart = tic;
%posiciÃ³n inicial cabeza
giro_cabeza(i)=readRotation(motor_cabeza);
%valores iniciales de los encoders
giro_derecho(i)=0;
giro_izquierdo(i)=0;
%medida incial
distancia(i) = readDistance(sonar)*100;
%--------------------
% Valores iniciales
%--------------------
%tiempo inicial
    t(i)=0;
    x(i)=0;
    y(i)=0;
    theta(i)=0*pi/4;
    yaw(i)=0*45;
    referencia_yaw=yaw(i);

    estado=1; %estado inicial
    
    stop_distance=23; %distancia de para ante obstÃ¡culo
    t_marcha_atras=1.5; %tiempo de marcha hacia atrÃ¡s.
    %t_giro=1.5;
    transicion=1;% inicializa la variable que marca el inicio el mov de la cabeza
    
%comienza el bucle
    disp('pulsa el bumper para comenzar')
    
SR_robot=hgtransform;
SR_cabeza=hgtransform('Parent',SR_robot);

while(readTouch(pulsador)==0)
    disp 'Esperando pulsaciÃ³n'
end

while(readTouch(pulsador)==1)
    disp('Comineza de bucle')
end

%i=1;///
%clc;
%tstart=tic;///
% t(i)=toc(tstart);
tiempo_final=10;
% d=[];
% angulo=[];
% k=0.4999;
mapa=[];

%resetRotation(motor_cabeza);/////
%resetRotation(motor_der);////
% angulo(1)=readRotation(motor_cabeza);
% referencia(1)=readRotation(motor_der);
%delay=1;

periodo=5.5;
amplitud=100;

% referencia(i)=senof(t(i),delay,periodo,amplitud);
% error(1)=referencia(1)-angulo(1);

while(readTouch(pulsador)==0)
    i=i+1; %indice global
    t(i)=toc(tstart); %tiempo global del bucle
    
    %-----------------------------------------------------------
    Signal_reading_odo;%lectura de señales y calculo del heading
    [x(i),y(i),theta(i)]=calculo_odometria(giro_derecho,giro_izquierdo,x,y,theta,i);%calculo odometria
    yaw(i)=theta(i)*180/pi;%para controlar el giro
    mapa=pinta_robot_v3tam(x(i),y(i),theta(i),double(giro_cabeza(i))*pi/180,SR_robot,SR_cabeza,double(distancia(i)),mapa);%REPRESENTAR EL ROBOT
    drawnow;
    estado
    %start(motor_cabeza);////
    %start(motor_der);////
    %--------------------------------------------------------
    % TRANSICIONES DE ESTADO
    %1-> marchando para adelante
    %2-> parando
    %3-> girando cabeza con sonar
    %4-> girando sobre si mismo
    %5-> Marcha atrás
    

        switch estado
            
            case 1 %andando hacia delante
                %if (readDistance(Sonar)<stop_distance) %si la distancia es menor que 35 para
                 if (distancia(i)<stop_distance)||(readTouch(Detecta_colision)==1) %si la distancia es menor que 35 para
                    estado=2; %transición de estado de paro
                    transicion=i; %indice que marca el inicio del estado 2
                end
                
            
            case 2 %parando
                if (vel==0)
                    if (distancia(i)>stop_distance)&&(readTouch(Detecta_colision)==0)
                        estado=1; %la transición a estado marcha hacia delante
                        transicion=i; %indice que marca el inicio del estado 1
                    elseif(distancia(i)<stop_distance)     
                        estado=3; %transición a estado girando cabeza
                        transicion=i; %indice que marca el inicio del estado 3
                        desfase=t(transicion)+1;
                    else%Si hay choque
                        estado=5;
                        transicion=i;
                    end
                end
             
            case 3 %girando cabeza

                if(t(i) > (desfase + periodo + 1.5))
                    Power_cabeza = 0; %para cabeza
                    estado = 4;
                    angulo_a_girar = (calculo_referencia_yaw(distancia, giro_cabeza, transicion)) * 1.2;
                    %para que gire sobre el mismo
                    referencia_yaw = (angulo_a_girar + yaw(i));
                    transicion = i; %indice que marca el inicio del estado 4
                end
            case 4 %girando robot
                if(abs(error_yaw(i - 1)) < 8.1)
                estado=2; %la transición a estado parando
                transicion=i; %indice que marca el inicio del estado 5
                end
           case 5 %marcha atrás
                if (t(i)-t(transicion)>t_marcha_atras)                  
                    estado=3; %transición a estado girando cabeza
                    Power1=0;
                    Power2=0;
                    transicion=i; %indice que marca el inicio del estado 2 
                    desfase=t(transicion)+1;
                end
            
        end %del siwtch
    
   %-----------------------
          
    
    %-------------------------------------------------
    %SALIDAS ASOCIADAS A LOS ESTADOS
    
        switch estado
        
            case 1 %andando hacia delante
            %establece los valores de control
                error_yaw(i)=referencia_yaw-yaw(i);%error en la orientacion
                ky = 0.6;
                control = ky * error_yaw(i);
                vel=20;
                Power1=vel+control;
                Power2=vel-control;
                
              %---------------------
              %Manda los comandos de control a los motores
              %-------------
                %Traction_motor_control;

            case 2 %parando
              %establece los valores de control 
                vel=0;
                Power1=vel;
                Power2=vel;
                
              %---------------------
              %Manda los comandos de control a los motores
              %-------------
               %Traction_motor_control;
        
            case 3 %girando cabeza
                
                %calculo de referencia
                    referencia(i)=senof(t(i), desfase, periodo, amplitud);
                %Calculo de error
                    error_cabeza(i)=(referencia(i)-giro_cabeza(i));
                %ganancia del controlador proporcional
                    kc=0.35;
                %definicion del controlador
                    control_cabeza=kc*error_cabeza(i);
                %actuacion sobre el motor
                    Power_cabeza=int8(control_cabeza);
                    
            case 4 %girando sobre si mismo
                error_yaw(i)=referencia_yaw-yaw(i); %error de orientacion del robot
                k_giro=1.5;%ganancia controlador del giro del robot con angulos variables
                vel=int8(k_giro*error_yaw(i));
                Power1=vel;
                Power2=-vel;
                Power_cabeza=0;
            
               
            case 5 %andando hacia atrás
                %establece los valores de control 
               vel=-20;
               Power1=vel;
               Power2=vel;
               Power_cabeza=0;
                
              %---------------------
              %Manda los comandos de control a los motores
              %-------------
               %Traction_motor_control;      
          
        end %del siwtch
        
        
        %drawnow;
      %---------------------
        %Manda los comandos de control a los motores
      %-------------        
        Traction_motor_control;   
        
    %disp 'Pulse para salir'
    readTouch(pulsador);
end

Para;
%plot(d);
%stop(motor_cabeza)
%stop(motor_der)
%stop(motor_izq)
%stop(motor_der)
%an=angulo/t(i);
%plot(an)
% figure
% plot(t,referencia);
%plot(angulo,referencia);
% hold on
% plot(t,angulo);