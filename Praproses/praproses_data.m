%% nomalization code using Min-Max Normalization - 22/03/2016
%kelas = 10;
num_data = 5;
fs = 44100;
ind = 1;

for j=1:num_data
    cd('../Data/Recording/Edited');
    sound = wavread(strcat(num2str(j),'.wav'));
    cd('../../../Code');
    sound = normalisasi(sound);
    cd('../Data/Recording/Edited/NormalData');
    wavwrite(sound,fs,strcat(num2str(ind),'.wav'));
    ind = ind + 1;
    cd('../../../../Code');
end