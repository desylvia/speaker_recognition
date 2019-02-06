%% Vector Quantization - 26/05/2016
function hasil = vq(uj,cluster,cdbooks,tsData)
    %% inisialisasi
    dist = cell(1,uj); %cell array untuk menyimpan hasil euclid
    mindist = cell(1,uj); %cell array untuk menyimpan hasil minimum
    cd = 5; %banyaknya codebook sesuai data latih
    hasil = zeros(uj,1); %menampung hasil vq
    %% loop utama
    for x=1:uj %loop sebanyak instance data uji
       for a=1:cd %jumlah codebook
           %% ambil data codebook
            codebook = (cdbooks{1,a})'; %codebook data training
            test = (tsData{x,1})'; %data uji
            n = size(test,1); %ambil ukuran baris dari matrix
            %% menghitung jarak (euclid)
            for i=1:n %baris
                for j=1:cluster %kolom
                    dist{1,a}(i,j) = sqrt( (test(i,1)-codebook(1,j))^2 + (test(i,2)-codebook(2,j))^2 + (test(i,3)-codebook(3,j))^2 + (test(i,4)-codebook(4,j))^2 + (test(i,5)-codebook(5,j))^2 + (test(i,6)-codebook(6,j))^2 + (test(i,7)-codebook(7,j))^2 + (test(i,8)-codebook(8,j))^2 + (test(i,9)-codebook(9,j))^2 + (test(i,10)-codebook(10,j))^2 + (test(i,11)-codebook(11,j))^2 + (test(i,12)-codebook(12,j))^2 + (test(i,13)-codebook(13,j))^2 );
                end
            mindist{1,a}(i,1) = min(dist{1,a}(i,:));
            end 
       end
       %% cek jarak terdekat kemudian menentukan kelasnya 
       for k=1:cd
            res(k,1) = sum(mindist{1,k});
       end
       [val,ind] = min(res);
       hasil(x,1) = ind;
    end
end