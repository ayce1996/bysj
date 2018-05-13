clear all;
dataset = xlsread('Dataset\gisette\gisette_train.xlsx');
disp('gisette_train loading completed')
data = dataset(:,1:size(dataset,2)-1);
label = dataset(:,size(dataset,2));
disp('Start selecting features')
[selectedfeature] = feast('disr', size(data,2), data, label);
disp('Features selected')
% data_train = xlsread('Dataset\arcene\arcene_train.xlsx');
% data_train_data = data_train(:,1:size(data_train,2)-1);
% data_train_label = data_train(:,size(data_train,2));
data_train_data = data;
data_train_label = label;
data_test = xlsread('Dataset\gisette\gisette_valid.xlsx');
disp('gisette_valid loading completed')
data_test_data = data_test(:,1:size(data_test,2)-1);
data_test_label = data_test(:,size(data_test,2));
train_data = [];
test_data = [];
label_predict = [];
correct = zeros(length(selectedfeature),1);
disp('Start classfying')
for i = 1:length(selectedfeature)
    train_data = [train_data data_train_data(:,selectedfeature(i))];
    test_data = [test_data data_test_data(:,selectedfeature(i))];
    model = libsvmtrain(data_train_label, train_data, '-s 0 -t 2 -c 1 -g 0.1');
    [predictlabel, ~]  = libsvmpredict(data_test_label, test_data, model);
    label_predict = [label_predict predictlabel];
    correct(i) = length(find(data_test_label(:)==label_predict(:,i)))/length(data_test_label);
end
figure(1)
plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])