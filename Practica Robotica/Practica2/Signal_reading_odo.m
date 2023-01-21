    %---------------------
    %lectura señales y calculo del heading
    %-------------------------------
    % Para evitar oscilaciones en los procesos de control del giro del
    % de la cabeza, las consultas al estado de los  motores de tracción,
    %  solo se hacen en los estados necesarios.
    %----------------------------------------------------------------------
    
    %lectura del sonar
    distancia(i) = readDistance(sonar)*100; %Lectura sonar
    
    %lectura de encoders de los motores de las ruedas y de la cabeza
    
    if (estado==3) %cuando giro la cabeza no leo encoders de las ruedas
        
        giro_cabeza(i)=double(readRotation(motor_cabeza));  
        giro_derecho(i)=giro_derecho(i-1);
        giro_izquierdo(i)=giro_izquierdo(i-1);
        
        
        
    else %cuando leo encoders de las ruedas no leo el giro de la cabeza       
        giro_cabeza(i)=giro_cabeza(i-1);
        giro_derecho(i)=double(readRotation(motor_derecho))*pi/180;
        giro_izquierdo(i)=double(readRotation(motor_izquierdo))*pi/180;
    end


        