%% Gaussian Mixture Model Code - 22/03/2016
function p = gmm(test,model,k,d,n)
    %% GMM computation
    test_sz = size(test,1);
    buff = zeros(1,k);
    b = zeros(test_sz,1);
    
    for m=1:n %number of models
        for i=1:test_sz %number of frame (testing data) 
            for j=1:k %number of k cluster (mixture)
                x = test(i,:) - model{2,m}(j,:);
                z = -0.5*x*inv(model{3,m}{j})*x';
                buff(1,j) = ( 1/ ( ((2*pi)^(d/2))*sqrt(det(model{3,m}{j})) ) )*exp(z);
                z = 0;
                x = 0;
            end
            b(i,1) = max(buff);
            buff = 0;
        end
        p(1,m) = sum(b);
    end
end