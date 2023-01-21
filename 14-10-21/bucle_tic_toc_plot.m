clear all
clc

k=1;
for s=0:0.01:4*pi
    t(k)=s;
    y(k)=signal_v0(t(k));
    k=k+1
end

% plot(t,y)

tstart=tic;
k=1;
tiempo(k)=0;
while tiempo(k)<4*pi
    y2(k)=signal_v0(tiempo(k));
    
    cla
    plot(t,y)
    hold on 
    
    plot(tiempo(k), y2(k), 'Or')
    
    k=k+1;
    
    tiempo(k)=toc(tstart);
    
    axis([0 4*pi -1 1])
    
    drawnow
    
end


