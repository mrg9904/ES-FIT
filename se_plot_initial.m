clear;
parameters;

global para_al;
global theta0;
e_K = dielectric_model_metal_only_drude(para_al);
global lamda;
global substrate_nk
n_S = substrate_nk;
angle = fresnel(e_K, n_S, theta0);
psi = angle(:,1);
delta = angle(:,2);

global exp_loc;
exp = load(exp_loc);
psi_e = exp(start_point:end_point,2);
delta_e = exp(start_point:end_point,3);

subplot(1,2,1);
plot(lamda/1000,psi);
hold on;
plot(lamda/1000,psi_e);
hold off;
xlabel('Wavelength/um');
ylabel('psi/бу');
legend('2nd-theory','2nd-experiment');

subplot(1,2,2);
plot(lamda/1000,delta);
hold on;
plot(lamda/1000,delta_e);
hold off;
xlabel('Wavelength/um');
ylabel('delta/бу');
legend('2nd-theory','2nd-experiment');