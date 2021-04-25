function n_S=sellmeier(para)
    global lamda;
    e0 = para(1)*ones(size(lamda));
    A = para(2);
    B = para(3)*ones(size(lamda));
    E = para(4);
    lamda0 = lamda*0.001;
    n_S = sqrt(e0 + A*lamda0.^2./(lamda0.^2 - B.^2) - E*lamda0.^2);
end