function output = normalization(input)
%用于行向量的归一化
    output = zeros(size(input,1),size(input,2));
    for i = 1:size(input,1)
        output(i,:) = input(i,:)/sum(input(i,:));
    end
end