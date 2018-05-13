% clear all;
dataset = xlsread('Dataset\semeion\semeion_dfl');
number = dataset(182,1:size(dataset,2)-1);
a = zeros(16,16);
for i = 1:sqrt(length(number))
    for j = 1:sqrt(length(number))
        a(i,j) = number((i-1)*sqrt(length(number))+j);
    end
end
imshow(a)