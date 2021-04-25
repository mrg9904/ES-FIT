function s=s_reflection(e1,e2,sina)
cosa = sqrt(1*ones(size(e1)) - sina.^2);
sinb = sqrt(e1./e2).*sina;
cosb = sqrt(1*ones(size(e1)) - sinb.^2);
s = (sqrt(e1).*cosa-sqrt(e2).*cosb)./(sqrt(e1).*cosa+sqrt(e2).*cosb);
end