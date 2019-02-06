%% Training VQ & GMM - 27/05/2016
%% Initialization
clus = 3; %3 5 9
fold = 5;
%-------------- VQ -----------------------------------
hslVQ = zeros(10,fold); %2*5 = 10 testing data
uj = 10; %jumlah instance data uji
%--------------- GMM --------------------------------------
n = 5; %number of speaker
m = 2; %number of testing data (2 per each speaker => kfold = 5)
d = 13; %dimension => mfcc
hslGMM = cell(fold,1); %store the result
model = cell(fold,1); %model{,}{1,}: clustered data, model{,}{2,}: mean, model{,}{3,}: sigma, model{,}{4,}: prob. dist.
opts = statset('MaxIter',300); %set maximum iteration for kmeans
%% VQ
%call vq function
for z=1:fold
    hslVQ(:,z) = vq(uj,clus,cdbooks(z,:),tsMFCC{z,1});
end
%% GMM
%build GMM model
for x=1:fold %number of fold
    for j=1:n %number of speakers
        f = trMFCC{x,j}';
        [idx,miu] = kmeans(f,clus,'Options',opts);
        %get the model
        model{x,1}{2,j} = miu;
        for i=1:clus %number of cluster
            model{x,1}{1,j}{i} = f(idx == i,:);
            model{x,1}{3,j}{i} = cov(model{x,1}{1,j}{i});
            %model{x,1}{3,j}{i} = diag(cov(model{x,1}{1,j}{i}))'; %get only main diagonal
        end
        model{x,1}{4,j} = 1/clus;
    end
end
%testing process (to call gmm function)
for k=1:fold %number of fold
    testing = (reshape(tsMFCC{k,1},2,5))';
    for i = 1:n %number of speaker
        for j=1:m %number of testing data
            p = gmm((testing{i,j})',model{k,1},clus,d,n);
            hslGMM{k,1}{1,j}(i,:) = p;
        end
    end
end
%% Clear some variables
%clearvars -except clsTest clsTrain dat datDiv datTest datTrain data_suara hslGMM hslVQ indices kelas model trMFCC tsMFCC 