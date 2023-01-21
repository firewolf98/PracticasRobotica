 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Manda las señales de control a los motores de tracción:
 % motor_derecho y motro izquierdo
 %------------------------------------
 
 %Limita el valor de velocidad que se manda a los motores
        
       if Power1>25
                Power1=25;
        else
           if  Power1<-25
                    Power1=-25;
           end
        end
    
        if Power2>25
                Power2=25;
        else
            if  Power2<-25
                    Power2=-25;
            end
        end
        
        if Power_cabeza>100
                Power2=100;
        else
            if  Power_cabeza<-100
                    Power2=-100;
            end
        end
        
        
       
     % Actualiza el valor de la estructura vinculada a cada motor   
            motor_derecho.Speed =Power1;
            motor_izquierdo.Speed =Power2;
            motor_cabeza.Speed =Power_cabeza;
            
          
    