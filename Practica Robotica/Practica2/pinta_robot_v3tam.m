function mapa_rob=pinta_robot_v3tam(x,y,theta,alfa,SR_Robot,SR_cabeza,distancia,mapa)

R=rectangle('Position',[-5.5 -1.5 11 7],'Parent',SR_Robot);%Tamaño del Robot
axis([-30 30 -30 30]) %Establece el rango de los ejes globales

M=makehgtform('translate',[x y 0]);
SR_Robot.Matrix=M;
%Mueve el robot
M=makehgtform('translate',[x y 0],'zrotate',theta);
SR_Robot.Matrix=M;

%Definimos las ruedas
rueda_size=[-0.5 -0.1 5 3];%Defino el tamaño de la rueda
SR_rueda_der=hgtransform('Parent',SR_Robot);%Defino el SR asociado a la rueda
rueda_der=rectangle('Position',rueda_size,'Parent',SR_rueda_der);%Defino la rueda

M=makehgtform('translate',[2 -4.5 0]);
SR_rueda_der.Matrix=M;%Actualizo el valor de la Matriz asociada al SR de la rueda derecha

SR_rueda_izq=hgtransform('Parent',SR_Robot);%Defino el SR asociado a la rueda
rueda_izq=rectangle('Position',rueda_size,'Parent',SR_rueda_izq);%Defino la rueda

M=makehgtform('translate',[2 5.5 0]);
SR_rueda_izq.Matrix=M;%Actualizo el valor de la Matriz asociada al SR de la rueda izquierda

%Definimos la cabeza
cabeza_size=[-2 -2.25 4 5.5];
cabeza=rectangle('Position',cabeza_size,'Parent',SR_cabeza);

M=makehgtform('translate',[4 3 0],'zrotate',alfa);
SR_cabeza.Matrix=M;

Mt=SR_Robot.Matrix*SR_cabeza.Matrix;

%Pinta asteriscos del sonar
punto=Mt.*[distancia+5 0 0 1];
axis([-20 20 -20 20]);
d=animatedline(punto(1),punto(2),'Marker','*','LineStyle','none');

%Definimos ojos;
ojo_size=[0.1 0.01 0.5 1.7];
SR_ojo_der=hgtransform('Parent',SR_cabeza);
ojo_der=rectangle('Position',ojo_size,'Parent',SR_ojo_der);

M=makehgtform('translate',[2 -2 0]);
SR_ojo_der.Matrix=M;

SR_ojo_izq=hgtransform('Parent',SR_cabeza);
ojo_izq=rectangle('Position',ojo_size,'Parent',SR_ojo_izq);

M=makehgtform('translate',[2 1.4 0]);
SR_ojo_izq.Matrix=M;


MT = SR_Robot.Matrix * SR_cabeza.Matrix;
punto = MT*[distancia, 0, 0, 1]';
axis([x-30 x+30 y-30 y+30])
mapa_rob = [mapa; punto(1), punto(2)];
animatedline(mapa_rob(:, 1), mapa_rob(:, 2), 'Marker','*', 'LineStyle','none');

end