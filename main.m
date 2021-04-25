clc;
clear;
parameters;

global para_al err_bar_al;
para1 = para_al;
err_bar1 = err_bar_al;
low_b_al = para_al - err_bar_al;
up_b_al  = para_al + err_bar_al;

global para_SiO2 err_bar_SiO2;
para2 = para_SiO2;
err_bar2 = err_bar_SiO2;
low_b_SiO2 = para_SiO2 - err_bar_SiO2;
up_b_SiO2  = para_SiO2 + err_bar_SiO2;

global theta0 err_bar_theta;
para3 = theta0;
err_bar3 = err_bar_theta;
low_b_theta = theta0 - err_bar_theta;
up_b_theta = theta0 + err_bar_theta;

global Max_Running_Time;
fun = @error_func;
options = optimoptions(@simulannealbnd,'MaxTime',Max_Running_Time);
global para_final;
%[para_final,err] = simulannealbnd(fun, [para1,para2,para3], [low_b_al, low_b_SiO2, low_b_theta], [up_b_al, up_b_SiO2, up_b_theta], options);
[para_final,err] = simulannealbnd(fun, [para1,para3], [low_b_al, low_b_theta], [up_b_al, up_b_theta], options);

SE_plot_final;

disp(' ');
disp('*************Final parameters************');
disp('>>>Drude');
disp(para_final(1:3));
% disp('>>>Silica');
% disp(para_final(7:10));
disp('>>>Angle');
disp(para_final(4)*180/pi);
disp('****************************************');