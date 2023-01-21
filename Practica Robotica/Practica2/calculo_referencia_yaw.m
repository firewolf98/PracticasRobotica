%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calcula el �ngulo

function referencia=calculo_referencia_yaw(distancia,giro_cabeza,transicion)


m=length(distancia);
dist_derecha=[];
angulo_derecha=[];
dist_izquierda=[];
angulo_izquierda=[];

for i=transicion:m

    if giro_cabeza(i)>0
       dist_derecha=[dist_derecha distancia(i)];
       angulo_derecha=[angulo_derecha giro_cabeza(i)] ;
    else
       dist_izquierda=[dist_izquierda distancia(i)];
       angulo_izquierda=[angulo_izquierda giro_cabeza(i)];
    end
end

valor_derecho=mean(dist_derecha)
valor_izquierdo=mean(dist_izquierda)

if (valor_derecho>=valor_izquierdo)
    referencia=(sum(dist_derecha.*double(angulo_derecha)))/sum(dist_derecha);
else
    referencia=(sum(dist_izquierda.*double(angulo_izquierda)))/sum(dist_izquierda);
end
    