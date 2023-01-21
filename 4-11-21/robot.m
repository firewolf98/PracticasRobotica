SR_robot = hgtransform;

R=rectangle('Position',[-1.5 -1.5 3 3],'Parent',SR_robot);

axis([-10 10 -10 10]);

%---------------------------
x=-5; y=-5;

M= makehgtform('translate',[x y 0]);

SR_robot.Matrix=M;
%------------------
x=4; y=-3;
theta=pi/4;

M=makehgtform('translate',[x y 0],'zrotate',theta);

SR_robot.Matrix=M;
%------------------
%Definicion de las ruedas
rueda_size=[-0.5 -0.1 1 0.2];

SR_rueda_derecha=hgtransform('Parent',SR_robot);
rueda_derecha=rectangle('Position',rueda_size,'Parent',SR_rueda_derecha);

M=makehgtform('translate',[0 -1 0]);
SR_rueda_derecha.Matrix=M;

%---------------------
%
SR_rueda_izquierda=hgtransform('Parent',SR_robot);
rueda_izquierda=rectangle('Position',rueda_size,'Parent',SR_rueda_izquierda);

M=makehgtform('translate',[0 1 0]);
SR_rueda_izquierda.Matrix=M;

%---------------------------

%SR_cabeza=hgtransform('Parent',SR_robot);
SR_cabeza=cabeza
cabeza_size=[-0.25 -0.5 0.5 1];
cabeza=rectangle('Position',cabeza_size,'Parent',SR_cabeza);

alfa=0;
M=makehgtform('translate',[1 0 0],'zrotate',alfa);
SR_cabeza.Matrix=M;