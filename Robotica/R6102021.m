t=0:0.1:2*pi
y=sin(t)
plot(t,y)

%%bucle for
k=1;
for s=0:0.01:2*pi

    t(k)=s;
    y(k)=seno(t(k));
    k=k+1;
end

figure, plot(t,y)

%%bucle while
tstart=tic;
k=1;
tiempo(k)=0;
while tiempo(k)<10
    k=k+1;
    tiempo(k)=toc(tstart);
    y(k)=seno(tiempo(k));
end

figure, plot(tiempo,y)

%%R13102021
tstart=tic;
k=1;
tiempo(k)=0;
while tiempo(k)<4*pi
    
    cla
    
    k=k+1;
    tiempo(k)=toc(tstart);
    y(k)=seno(tiempo(k));
    axis([0 4*pi -1 1]);
    
    plot(tiempo,y)
    hold on
    plot(tiempo(k),y(k),'Or')
end

figure, plot(tiempo,y)