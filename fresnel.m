function angles=fresnel(e_K, n_S, theta)
    % Parameters initialize
    e_air = ones(size(e_K));
    e1 = n_S.^2;
    e2 = e_K;
    sina1 = sin(theta)*ones(size(e_K));
    sina2 = sina1./sqrt(e1);
    angles = zeros(length(e_K),2);
    P = 0;
    Delta_c = pi/2;
    one = ones(size(e1));
    
    % Operators representation
    global R1_i_s R1_i_p T1_i_s T1_i_p R2_s R2_p T1_o_s T1_o_p R1_o_s R1_o_p
    R1_i_s = s_reflection(e_air,e1,sina1);
    R1_i_p = p_reflection(e_air,e1,sina1);
    T1_i_s = s_refraction(e_air,e1,sina1);
    T1_i_p = p_refraction(e_air,e1,sina1);
    R2_s   = s_reflection(e1,e2,sina2);
    R2_p   = p_reflection(e1,e2,sina2);
    T1_o_s = s_refraction(e1,e_air,sina2);
    T1_o_p = p_refraction(e1,e_air,sina2);
    R1_o_s = s_reflection(e1,e_air,sina2);
    R1_o_p = p_reflection(e1,e_air,sina2);
%     disp(R1_o_s.^0);
    
    M0 = Transfer_matrix(0);
    M1 = Transfer_matrix(1);
    M2 = Transfer_matrix(2);
    M3 = Transfer_matrix(3);
    M4 = Transfer_matrix(4);
    
%     disp((abs(M4(:,1)).^2 + abs(M4(:,2)).^2)/2);
    
    rho_1 = M0(:,2) ./ M0(:,1);
    rho_2 = M1(:,2) ./ M1(:,1);
    rho_3 = M2(:,2) ./ M2(:,1);
    rho_4 = M3(:,2) ./ M3(:,1);
    rho_5 = M4(:,2) ./ M4(:,1);
    
    psi_1 = atan(abs(rho_1));
    delta_1 = angle(rho_1) - (sign(angle(rho_1)) - ones(size(psi_1)))*pi;
    psi_2 = atan(abs(rho_2));
    delta_2 = angle(rho_2) - (sign(angle(rho_2)) - ones(size(psi_1)))*pi;
    psi_3 = atan(abs(rho_3));
    delta_3 = angle(rho_3) - (sign(angle(rho_3)) - ones(size(psi_1)))*pi;
    psi_4 = atan(abs(rho_4));
    delta_4 = angle(rho_4) - (sign(angle(rho_4)) - ones(size(psi_1)))*pi;
    psi_5 = atan(abs(rho_5));
    delta_5 = angle(rho_5) - (sign(angle(rho_5)) - ones(size(psi_1)))*pi;
    
    a1 = Intensity(psi_1, delta_1, P, Delta_c);
    a2 = Intensity(psi_2, delta_2, P, Delta_c);
    a3 = Intensity(psi_3, delta_3, P, Delta_c);
    a4 = Intensity(psi_4, delta_4, P, Delta_c);
    a5 = Intensity(psi_5, delta_5, P, Delta_c);
    
    global lamda
    load data/210310-guangzhou/TRA.mat KBr_A Si_A SiO2_A Wavelength
    Wavelength = Wavelength*1000;
    n_Arange = 1.52*ones(size(Wavelength));
    A = Absorption_interpolation_func(KBr_A, Wavelength, theta, n_Arange, lamda);
%     n_Arange = 3.38*ones(size(Wavelength));    
%     A = Absorption_interpolation_func(Si_A, Wavelength, theta, n_Arange, lamda);
%       n_Arange = 1.39*ones(size(Wavelength));
%         A = Absorption_interpolation_func(SiO2_A, Wavelength, theta, n_Arange, lamda);  
    ratio_1 = (abs(M0(:,1)).^2 + abs(M0(:,2)).^2)./(abs(M1(:,1)).^2 + abs(M1(:,2)).^2);
    ratio_2 = one.*A.^2;
    ratio_3 = (abs(M2(:,1)).^2 + abs(M2(:,2)).^2)./(abs(M1(:,1)).^2 + abs(M1(:,2)).^2).*A.^4*0;
    ratio_4 = (abs(M3(:,1)).^2 + abs(M3(:,2)).^2)./(abs(M1(:,1)).^2 + abs(M1(:,2)).^2).*A.^6*0;
    ratio_5 = (abs(M4(:,1)).^2 + abs(M4(:,2)).^2)./(abs(M1(:,1)).^2 + abs(M1(:,2)).^2).*A.^8*0;
    
    %From literature <Systematic errors in rotating-compensator ellipsometry>
%     alpha_0  = a1(:,1).*ratio_1 + a2(:,1).*ratio_2 + a3(:,1).*ratio_3;
    alpha_2c = a1(:,2).*ratio_1 + a2(:,2).*ratio_2 + a3(:,2).*ratio_3 + a4(:,2).*ratio_4 + a5(:,2).*ratio_5;
    alpha_2s = a1(:,3).*ratio_1 + a2(:,3).*ratio_2 + a3(:,3).*ratio_3 + a4(:,3).*ratio_4 + a5(:,3).*ratio_5;
    alpha_4c = a1(:,4).*ratio_1 + a2(:,4).*ratio_2 + a3(:,4).*ratio_3 + a4(:,4).*ratio_4 + a5(:,4).*ratio_5;
    alpha_4s = a1(:,5).*ratio_1 + a2(:,5).*ratio_2 + a3(:,5).*ratio_3 + a4(:,5).*ratio_4 + a5(:,5).*ratio_5;
    
    tan_2psi = - ((alpha_2s.^2 + alpha_2c.^2)*(1 - cos(Delta_c)^2)/(sin(Delta_c)^2) + 4*(alpha_4s*cos(2*P) - alpha_4c*sin(2*P)).^2).^(1/2) ./ (2*(alpha_4c*cos(2*P) + alpha_4s*sin(2*P)));
    tan_delta = ((1 - cos(Delta_c))/(2*sin(Delta_c)))*(alpha_2c*sin(2*P) - alpha_2s*cos(2*P))./(alpha_4c*sin(2*P) - alpha_4s*cos(2*P));
    psi2 = 0.5*atan(tan_2psi)*180/pi;
    for i = 1:length(psi2)
        if psi2(i) < 0
            psi2(i) = psi2(i) + 90;
        end
    end
    angles(:,1) = psi_4*180/pi;
    angles(:,2) = delta_4*180/pi;
%     angles(:,2) = atan(tan_delta)*180/pi + 180;
end