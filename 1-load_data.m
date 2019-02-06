%% 10/08/2016
%% Initialize
num_data = 5; %number of data
div = 10; %number of segment, the data divided into
data_suara = cell(num_data,1); %to store speech data
data_mfcc = cell(num_data,1); %to store mfcc from original speech data
datDiv = cell(num_data,div); %to store divided data (dibagi 10 - skenario 2)
dat = cell(num_data*div,1); %vector version of datDiv
coef = 13; %MFCC coeficien
%% Load data
for j=1:num_data
    cd('../Data/Recording/Edited/CleanData');
    sound = wavread(strcat(num2str(j),'.wav'));
    data_suara{j,1} = sound;
    cd('../../../../Code');
%     data_mfcc{j,1} = mfcc(sound,44100,17.27,0.39,13);
    sound = 0;
end
%% Pembagian data latih dan uji => dibagi menjadi 10 segment
%% (skenario 2)
for i=1:num_data
    x = length(data_suara{i,1});
    n = round(x/div);
    for k=1:div-1
        datDiv{i,k} = data_suara{i,1}(n*(k-1)+1:n*k);
    end
    datDiv{i,k+1} = data_suara{i,1}(n*k+1:end);
end
dat = reshape(datDiv',num_data*div,1);
%define class
x = 1;
y = div;
for i=1:num_data
    kelas(x:y,1) = i;
    x = y+1;
    y = y+div;
end