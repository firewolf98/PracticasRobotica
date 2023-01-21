function salida = signal_vf(t, delay, periodo, amplitud)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
salida=amplitud*sin((2*pi/periodo)*(t-delay));

if t<delay
    salida=0;
elseif t>delay+periodo
    salida=0;
end

end

