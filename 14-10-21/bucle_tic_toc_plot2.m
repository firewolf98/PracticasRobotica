clear all
clc

delay=2;
periodo=6;
amplitud=2;

k=1;
for s=0:0.01:4*pi
    t(k)=s;
    y(k)=signal_vf(t(k),delay, periodo, amplitud);
    k=k+1
end

% plot(t,y)

tstart=tic;
k=1;
tiempo(k)=0;
while tiempo(k)<4*pi
    y2(k)=signal_vf(tiempo(k),delay, periodo, amplitud);
    
    cla
    plot(t,y)
    hold on 
    
    plot(tiempo(k), y2(k), 'Or')
    
    k=k+1;
    
    tiempo(k)=toc(tstart);
    
    axis([0 12 -amplitud amplitud])
    
    drawnow
    
end


