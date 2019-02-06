%% 22/03/2016
function y = normalisasi(x) 
    [m,n] = size(x);
    y = zeros(m,n);

    minA = min(x);
    maxA = max(x);
    new_minA = -1;
    new_maxA = 1;

    for i=1:m
        y(i,1) = ((x(i,1) - minA)/(maxA - minA))*(new_maxA - new_minA) + new_minA;
    end
end