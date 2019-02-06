%% K-Fold code - 06/06/2016
%% Initialization
fold = 5;
datTrain = cell(fold,1);
datTest = cell(fold,1);
clsTrain = zeros(40,fold); %(10*5) - 10 = 40 => div = 10, 5 class, k = 5
clsTest = zeros(10,fold); %10 for 10 testing data => k = 5
%% K-Fold
indices = crossvalind('kfold',kelas,fold);
for i=1:fold
    ts = (indices==i); tr = ~ts;
    datTest{i,1} = dat(ts,1);
    datTrain{i,1} = dat(tr,1);
    clsTrain(:,i) = kelas(tr,1);
    clsTest(:,i) = kelas(ts,1);
end