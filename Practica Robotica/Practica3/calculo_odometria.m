function [x_new y_new theta_new]=calculo_odometria(giro_A,giro_C,x,y,theta,i)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcula la odometria de un robot diferencial
% giro_A,giro_C,x,y,theta,son vectores, i es el índice altual del vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global radio_rueda
global l %distancia entre ruedas

%calculo del incremento del angulo de rodado
    dalfa1=giro_A(i)-giro_A(i-1);
    dalfa2=giro_C(i)-giro_C(i-1);
    
    %Cálculo del ángulo
     theta_new=theta(i-1)+radio_rueda*(dalfa1-dalfa2)/(2*l);
     x_new=x(i-1)+((radio_rueda*(dalfa1+dalfa2)/2)*cos((theta_new+theta(i-1))/2));
     y_new=y(i-1)+((radio_rueda*(dalfa1+dalfa2)/2)*sin((theta_new+theta(i-1))/2));
    