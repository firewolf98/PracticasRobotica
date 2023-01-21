function pinta_robot(x,y,theta,alfa,SR_Robot,SR_cabeza)

R=rectangle('Position',[-1.5 -1.5 3 3],'Parent',SR_Robot);%Tamaño del Robot
axis([-10 10 -10 10]) %Establece el rango de los ejes globales

%Mueve el robot
M=makehgtform('translate',[x y 0],'zrotate',theta);
SR_Robot.Matrix=M;

%Definimos las ruedas
rueda_size=[-0.5 -0.1 1 0.2];%Defino el tamaño de la rueda
SR_rueda_der=hgtransform('Parent',SR_Robot);%Defino el SR asociado a la rueda
rueda_der=rectangle('Position',rueda_size,'Parent',SR_rueda_der);%Defino la rueda

M=makehgtform('translate',[0.5 -1 0]);
SR_rueda_der.Matrix=M;%Actualizo el valor de la Matriz asociada al SR de la rueda derecha

SR_rueda_izq=hgtransform('Parent',SR_Robot);%Defino el SR asociado a la rueda
rueda_izq=rectangle('Position',rueda_size,'Parent',SR_rueda_izq);%Defino la rueda

M=makehgtform('translate',[0.5 1 0]);
SR_rueda_izq.Matrix=M;%Actualizo el valor de la Matriz asociada al SR de la rueda izquierda

%Definimos la cabeza
cabeza_size=[-0.25 -0.5 0.5 1];
cabeza=rectangle('Position',cabeza_size,'Parent',SR_cabeza);

M=makehgtform('translate',[1 0 0],'zrotate',alfa);
SR_cabeza.Matrix=M;
end