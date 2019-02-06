%% Routine to call MFCC, concatenate the data - 26/05/2016
%% Initialization
trMFCC = cell(fold,num_data);
tsMFCC = cell(fold,1); %10 test data => fold = 5
cdbooks = cell(fold,num_data); %to store codeword
clus = 5; %3 5 9
%% Loop to call MFCC function -> concatenate 8 data train & for each
%% testing data
%training data
for z=1:fold
    buff = [datTrain{z,1}{1,1};datTrain{z,1}{2,1};datTrain{z,1}{3,1};datTrain{z,1}{4,1};datTrain{z,1}{5,1};datTrain{z,1}{6,1};datTrain{z,1}{7,1};datTrain{z,1}{8,1}];
    trMFCC{z,1} = mfcc(buff,44100,18.27,0.39,13);
    buff = 0;

    buff = [datTrain{z,1}{9,1};datTrain{z,1}{10,1};datTrain{z,1}{11,1};datTrain{z,1}{12,1};datTrain{z,1}{13,1};datTrain{z,1}{14,1};datTrain{z,1}{15,1};datTrain{z,1}{16,1}];
    trMFCC{z,2} = mfcc(buff,44100,17.27,0.39,13);
    buff = 0;

    buff = [datTrain{z,1}{17,1};datTrain{z,1}{18,1};datTrain{z,1}{19,1};datTrain{z,1}{20,1};datTrain{z,1}{21,1};datTrain{z,1}{22,1};datTrain{z,1}{23,1};datTrain{z,1}{24,1}];
    trMFCC{z,3} = mfcc(buff,44100,17.27,0.39,13);
    buff = 0;

    buff = [datTrain{z,1}{25,1};datTrain{z,1}{26,1};datTrain{z,1}{27,1};datTrain{z,1}{28,1};datTrain{z,1}{29,1};datTrain{z,1}{30,1};datTrain{z,1}{31,1};datTrain{z,1}{32,1}];
    trMFCC{z,4} = mfcc(buff,44100,17.27,0.39,13);
    buff = 0;

    buff = [datTrain{z,1}{33,1};datTrain{z,1}{34,1};datTrain{z,1}{35,1};datTrain{z,1}{36,1};datTrain{z,1}{37,1};datTrain{z,1}{38,1};datTrain{z,1}{39,1};datTrain{z,1}{40,1}];
    trMFCC{z,5} = mfcc(buff,44100,17.27,0.39,13);
    buff = 0;
end
%testing data
for u=1:fold
    for j=1:10
        tsMFCC{u,1}{j,1} = mfcc(datTest{u,1}{j,1},44100,17.27,0.39,13);
%         tsMFCC{u,1}{j,1} = mfcc(datTest_30{u,1}{j,1},44100,17.27,0.39,13); %datTest_xx is noisy data
%         tsMFCC{u,1}{j,1} = mfcc(datTest_20{u,1}{j,1},44100,17.27,0.39,13);
%         tsMFCC{u,1}{j,1} = mfcc(datTest_10{u,1}{j,1},44100,17.27,0.39,13);
%         tsMFCC{u,1}{j,1} = mfcc(datTest_8{u,1}{j,1},44100,17.27,0.39,13);
%         tsMFCC{u,1}{j,1} = mfcc(datTest_5{u,1}{j,1},44100,17.27,0.39,13);
%         tsMFCC{u,1}{j,1} = mfcc(datTest_0{u,1}{j,1},44100,17.27,0.39,13);
    end
end
%% Get codebook
opts = statset('MaxIter',300); %set maximum iteration for kmeans
for j=1:fold
    for k=1:num_data
        [id,p] = kmeans(trMFCC{j,k}',clus,'Options',opts);
        cdbooks{j,k} = p;
    end
end