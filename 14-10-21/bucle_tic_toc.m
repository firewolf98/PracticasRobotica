clear all
clc

k=1;
for s=0:0.01:2*pi
    t(k)=s;
    y(k)=signal_v0(t(k));
    k=k+1
end

tstart=tic
k=1;
tiempo(k)=0;
while tiempo(k)<10
    k=k+1;
    tiempo(k)=toc(tstart);
    y(k)=signal_v0(tiempo(k));
end

