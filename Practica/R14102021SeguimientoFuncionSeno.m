t=0:0.1:4*pi
delay=2;
periodo=6;
amplitud=1;
%%y=sin(t)
%%plot(t,y)

%%bucle for
k=1;
for s=0:0.01:4*pi

    t(k)=s;
    y(k)=senof(t(k),delay,periodo,amplitud);
    k=k+1;
end

figure, plot(t,y)

%%bucle while
%tstart=tic;
%k=1;
%tiempo(k)=0;
%while tiempo(k)<10
%    k=k+1;
%    tiempo(k)=toc(tstart);
%    y(k)=seno(tiempo(k));
%end

%figure, plot(tiempo,y)

%%R13102021//////////////////////////////////
%%R14102021//////////////////////////////////
tstart=tic;
k=1;
tiempo(k)=0;
while tiempo(k)<4*pi
    y2(k)=senof(tiempo(k),delay,periodo,amplitud);
    
    cla
    plot(t,y)
    hold on
    plot(tiempo(k),y2(k),'Or')
    
    k=k+1;
    tiempo(k)=toc(tstart);
    axis([0 4*pi -amplitud amplitud]); %%Dibuja los ejes correctamente
    drawnow
end

%figure, plot(tiempo,y)