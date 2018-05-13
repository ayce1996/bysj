clear all;
load('resultOfsemeion_sfl.mat','cmd')
dataset = xlsread('Dataset\semeion\semeion_0.xlsx');
data = dataset(:,1:size(dataset,2)-1);
label = dataset(:,size(dataset,2));
data_train = xlsread('Dataset\semeion\semeion_0_train.xlsx');
data_train_data = data_train(:,1:size(data_train,2)-1);
data_train_label = data_train(:,size(data_train,2));
data_test = xlsread('Dataset\semeion\semeion_0_test.xlsx');
data_test_data = data_test(:,1:size(data_test,2)-1);
data_test_label = data_test(:,size(data_test,2));
train_data = [];
test_data = [];
label_predict = [];
% label_predict = zeros(length(data_test_label),size(data_test_data,2));
tic
[selectedfeature] = feast('disr', size(data,2), data, label);
correct = zeros(length(selectedfeature),1);
for i = 1:length(selectedfeature)
    train_data = [train_data data_train_data(:,selectedfeature(i))];
    test_data = [test_data data_test_data(:,selectedfeature(i))];
    model = libsvmtrain(data_train_label, train_data, cmd);
    [predictlabel, ~]  = libsvmpredict(data_test_label, test_data, model);
    label_predict = [label_predict predictlabel];
    correct(i) = length(find(data_test_label(:)==label_predict(:,i)))/length(data_test_label);
end
runningtime = toc
save('resultOfsemeion_sfl','selectedfeature','label_predict','correct','runningtime','-append')
figure(1)
plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])