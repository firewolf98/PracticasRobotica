function pinta_robot_v2(x, y, theta, alfa, SR_robot, SR_cabeza,distancia,mapa)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %--Describe el cuerpo del robot y establece el tamaño de los ejes
    R=rectangle('Position',[-1.5 -1.5 3 3],'Parent', SR_robot);
    axis([-10 10 -10 10]);

    %--Desplaza y gira el robot
    M = makehgtform('translate',[x y 0],'zrotate',theta);
    SR_robot.Matrix=M;

    %Definicion de las ruedas
    rueda_size=[-0.5 -0.1 1 0.2];
    
    SR_rueda_derecha=hgtransform('Parent',SR_robot);
    rueda_derecha=rectangle('Position', rueda_size,'Parent',SR_rueda_derecha);

    M = makehgtform('translate', [0 -1 0]);
    SR_rueda_derecha.Matrix=M;
    
    
    SR_rueda_izquierda=hgtransform('Parent',SR_robot);
    rueda_izquierda=rectangle('Position', rueda_size,'Parent',SR_rueda_izquierda);

    M = makehgtform('translate', [0 1 0]);
    SR_rueda_izquierda.Matrix=M;
    
    %------------------------------------------
    %Definicion de la cabeza
    cabeza_size= [-0.25 -0.5 0.5 1];
    
    cabeza=rectangle ('Position' , cabeza_size, 'Parent' , SR_cabeza);

    M = makehgtform('translate' , [1 0 0] , 'zrotate',alfa);
    SR_cabeza.Matrix=M;
    
    Mt=SR_robot.Matrix*SR_cabeza.Matrix;

    punto=Mt.*[distancia 0 0 1];
    
    axis([-10 10 -10 10]);
    
    mapa_out=[mapa; punto(1) punto(2)];

    animatedline(mapa_out(:,1),mapa_out(:,2),'Marker','*','LineStyle','none');

end