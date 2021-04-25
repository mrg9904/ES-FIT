function e=dielectric_model_metal_only_drude(para)
    global lamda;
    En = 1240./lamda;
    A1 = para(1); %Drude
    B1 = para(2); %Drude
    Einf = para(3)*ones(size(En));
    e_drude = -A1./(En.^2-(1i)*B1*En) + Einf;
%     e = conj(e_drude);
    e = e_drude;
%     disp(imag(e_drude));
end