function M=Transfer_matrix(n)
    global R1_i_s R1_i_p T1_i_s T1_i_p R2_s R2_p T1_o_s T1_o_p R1_o_s R1_o_p
    if n == 0
        M(:,1) = R1_i_s;
        M(:,2) = R1_i_p;
    else
        M(:,1) = T1_i_s.*R2_s.*T1_o_s.*(R1_o_s.*R2_s).^(n-1);
%         M(:,1) = R2_s.*R1_o_s.^(n-1);
        M(:,2) = T1_i_p.*R2_p.*T1_o_p.*(R1_o_p.*R2_p).^(n-1);
%         M(:,2) = R2_p.*R1_o_p.^(n-1);
    end
end