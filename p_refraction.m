function p=p_refraction(e1,e2,sina)
cosa = sqrt(1*ones(size(e1)) - sina.^2);
sinb = sqrt(e1./e2).*sina;
cosb = sqrt(1*ones(size(e1)) - sinb.^2);
sin_a_plus_b = sina.*cosb + cosa.*sinb;
cos_a_sub_b = cosa.*cosb + sina.*sinb;
p = 2*cosa.*sinb./(sin_a_plus_b.*cos_a_sub_b);
end