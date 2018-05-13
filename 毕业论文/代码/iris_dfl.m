clear all;
load('resultOfiris_dfl','cmd');
dataset = xlsread('Dataset\iris\iris_data_dfl.xlsx');
data = dataset(:, 1:size(dataset,2)-1);
label = dataset(:, size(dataset,2));
data_train = xlsread('Dataset\iris\iris_data_dfl_train.xlsx');
data_train_data = data_train(:,1:size(data_train,2)-1);
data_train_label = data_train(:,size(data_train,2));
data_test  = xlsread('Dataset\iris\iris_data_dfl_test.xlsx');
data_test_data = data_test(:,1:size(data_test,2)-1);
data_test_label = data_test(:,size(data_test,2));
train_data = [];
test_data = [];
label_predict = [];
disp('Start seleting features and classify')
tic
[selectedfeature] = feast('disr', size(data,2), data, label);
correct = zeros(length(selectedfeature),1);
for i = 1:length(selectedfeature)
    train_data = [train_data data_train_data(:,selectedfeature(i))];
    test_data = [test_data data_test_data(:,selectedfeature(i))];
    model = libsvmtrain( data_test_label, train_data, cmd);
    [predictlabel, ~] = libsvmpredict( data_test_label, test_data, model);
    label_predict = [label_predict predictlabel];
    correct(i) = length(find(label_predict(:,i) == data_test_label(:)))/length(data_test_label);
end
runningtime = toc
save('resultOfiris_dfl','selectedfeature','label_predict','correct','runningtime','-append');
figure(1)
plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])