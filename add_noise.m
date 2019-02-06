%% Add noise code - 09/06/2016
%% Add additive white gaussian noise (only for test data)
% snr1 = 30; %signal to noise ratio
% snr2 = 20;
% snr3 = 10;
% snr4 = 8;
% snr5 = 5;
snr6 = 0;
% datTest_30 = cell(fold,1);
% datTest_20 = cell(fold,1);
% datTest_10 = cell(fold,1);
% datTest_8 = cell(fold,1);
% datTest_5 = cell(fold,1);
datTest_0 = cell(fold,1);

%noise 8 snr
for k=1:fold
    for j=1:10 %the data were divided into 10 segments
%         datTest_30{k,1}{j,1} = awgn(datTest{k,1}{j,1},snr1,'measured');
%         datTest_20{k,1}{j,1} = awgn(datTest{k,1}{j,1},snr2,'measured');
%         datTest_10{k,1}{j,1} = awgn(datTest{k,1}{j,1},snr3,'measured');
%         datTest_8{k,1}{j,1} = awgn(datTest{k,1}{j,1},snr4,'measured');
%         datTest_5{k,1}{j,1} = awgn(datTest{k,1}{j,1},snr5,'measured');
        datTest_0{k,1}{j,1} = awgn(datTest{k,1}{j,1},snr6,'measured');
    end
end