clear all
clc
%Crea el robot utilizando la conexión wiFi
%Connect the Host Computer to an EV3 Brick Over a Wireless Network
IPaddress='192.168.80.150';
%IPaddress='172.16.183.222';
Robot_ID='00165814f48';
mi_Robot  = legoev3('wifi',IPaddress,Robot_ID)
%---------------------------------------