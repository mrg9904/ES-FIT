function p=p_reflection(e1,e2,sina)
cosa = sqrt(1*ones(size(e1)) - sina.^2);
sinb = sqrt(e1./e2).*sina;
cosb = sqrt(1*ones(size(e1)) - sinb.^2);
tana = sina./cosa;
tanb = sinb./cosb;
tan_a_plus_b = (tana + tanb)./(1*ones(size(e1)) - tana.*tanb);
tan_a_sub_b = (tana - tanb)./(1*ones(size(e1)) + tana.*tanb);
p = tan_a_sub_b./tan_a_plus_b;
end