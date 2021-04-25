function MSE=error_func(para0)
    global exp_loc;
    data = load(exp_loc);
    global start_point end_point;
    psi_e = data(start_point:end_point,2);
    delta_e = data(start_point:end_point,3);
    
    Ne = cos(2*psi_e);
    Ce = sin(2*psi_e).*cos(delta_e);
    Se = sin(2*psi_e).*sin(delta_e);

    e_K = dielectric_model_metal_only_drude(para0(1:3));
    %n_S = dielectric_model_silica(para0(4:7));
%     n_S = 1.527*ones(size(psi_e));
    global substrate_nk
    angle = fresnel(e_K, substrate_nk, para0(end));
    psi = angle(:,1);
    delta = angle(:,2);
    N = cos(2*psi);
    C = sin(2*psi).*cos(delta);
    S = sin(2*psi).*sin(delta);
  
    n = length(psi);
    global fp_num;
    MSE = sqrt(1/(3*n-fp_num)*sum((Ne-N).^2 + (Ce-C).^2 + (Se-S).^2))*1000;
%     MSE = sqrt(1/(2*n-fp_num)*sum((psi_e - psi).^2));
    %disp(para0);
    disp(MSE);
end