%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% controla el movimiento del robot mediante una máqunia de estado.
% Utiliza los script: 
% Traction_motro_control.m; Signal_reading_odo.m;
% Para_Cierra.m.
% 28/11/2020. FGB.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clc
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

% Declaración de sensores
    Detecta_colision = touchSensor(mi_Robot,1); %Switch conectado al puerto 1.
    Pulsador = touchSensor(mi_Robot,2); %Switch conectado al puerto 2.
    Sonar = sonicSensor(mi_Robot); %definición del sonar

% Declaración de los motores
    motor_cabeza = motor(mi_Robot,'A'); %motor de la cabeza
    motor_izquierdo = motor(mi_Robot,'B'); %Motor izquierdo
    motor_derecho = motor(mi_Robot,'C'); %Motor_derecho

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
    resetRotation(motor_cabeza);
    resetRotation(motor_derecho);

%indice inicial
    i=1;

%referencia tiempo inicial
    tstart = tic;

%posición inicial cabeza
    giro_cabeza(i)=readRotation(motor_cabeza);

%valores iniciales de los encoders
    giro_derecho(i)=0;
    giro_izquierdo(i)=0;

%medida incial
    distancia(i) = readDistance(Sonar)*100;

%--------------------
% Valores iniciales
%--------------------
%tiempo inicial
    t(i)=0;

    estado=1; %estado inicial


    stop_distance=35; %distancia de para ante obstáculo
    t_marcha_atras=1.5; %tiempo de marcha hacia atrás.
    transicion=1;% inicializa la variable que marca el inicio el mov de la cabeza


%comienza el bucle
    disp('pulsa el bumper para comenzar')

while(readTouch(Pulsador)==0) 
end

while(readTouch(Pulsador)==1)
end

    disp('comienza el bucle')

while  (readTouch(Pulsador)==0)
  
        i=i+1; %indice global
        t(i)= toc(tstart); %tiempo global del bucle
    
    
    %---------------------
    %lectura señales y calculo del heading
    %-------------------------------
        Signal_reading_odo;
    %calcular ondometria
        [x(i) y(i) theta(i)]=calculo_ondometria(giro_derecho,giro_izquierdo,x,y,theta,i);
    %para controlar el giro
        yaw(i)=theta(i)*180/pi;
    %Representa el robot
        mapa=pinta_robot_v3tam(x(i),y(i),theta(i),double(giro_cabeza(i))*pi/180,SR_robot,SR_cabeza,distancia(i),mapa);
    %muestra el estado del sistema
        estado
   
    
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
                 if (distancia(i)<stop_distance) %si la distancia es menor que 35 para
                    estado=2; %transición de estado de paro
                    transicion=i; %indice que marca el inicio del estado 2
                end
                
            
            case 2 %parando
                if (vel==0)
                    if distancia(i)>stop_distance
                        estado=1; %la transición a estado marcha hacia delante
                        transicion=i; %indice que marca el inicio del estado 1
                    else       
                        estado=3; %transición a estado girando cabeza
                        transicion=i; %indice que marca el inicio del estado 3

                    end
                end
             
            case 3 %girando cabeza    
                estado=4; %la transición a estado girando robot
                transicion=i; %indice que marca el inicio del estado 4
                
            case 4 %girando robot
                %error en la orientacion del robot
                error_yaw(i)=(referencia_yaw-yaw(i));
                %ganancia del controlador
                k_giro=15;
                %control proporcional
                vel=int8(k_giro*error_yaw(i));
                %vel=15;
                Power1=vel;
                Power2=-vel;
                
                estado=5; %la transición a estado marcha atrás
                transicion=i; %indice que marca el inicio del estado 5
                
           case 5 %marcha atrás
                if (t(i)-t(transicion)>t_marcha_atras)                  
                    estado=2; %transición a estado girando cabeza
                    transicion=i; %indice que marca el inicio del estado 2                 
                end
            
        end %del siwtch
    
   %-----------------------
          
    
    %-------------------------------------------------
    %SALIDAS ASOCIADAS A LOS ESTADOS
    
        switch estado
        
            case 1 %andando hacia delante
            %establece los valores de control 
                vel=20;
                Power1=vel;
                Power2=vel;
                
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

        
            case 4 %girando sobre si mismo
                    
            
               
            case 5 %andando hacia atrás
                %establece los valores de control 
               vel=-20;
               Power1=vel;
               Power2=vel;
                
              %---------------------
              %Manda los comandos de control a los motores
              %-------------
               %Traction_motor_control;      
          
        end %del siwtch
      %---------------------
        %Manda los comandos de control a los motores
      %-------------        
        Traction_motor_control;   
    
end %del while

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para motores y cierra sensores
%-------------------------------
 Para;
