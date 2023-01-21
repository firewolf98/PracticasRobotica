clear all;
clc
SR_robot=hgtransform;
SR_cabeza=hgtransform('Parent',SR_robot);

pinta_robot(3,3,0,0,SR_robot,SR_cabeza)

for alfa=0:0.01:pi/2
    pinta_robot(3,3,alfa,alfa,SR_robot,SR_cabeza);
    drawnow;
end