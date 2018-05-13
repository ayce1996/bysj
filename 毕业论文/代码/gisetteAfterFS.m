clear all;
load('resultOfgisette.mat','selectedfeature','data_train_data','data_train_label','data_test_data','data_test_label');
data_train_data = data_train_data(1:100,:);
data_train_label = data_train_label(1:100);
data_test_data = data_test_data(1:100,:);
data_test_label = data_test_label(1:100);
train_data = [];
test_data = [];
label_predict = [];
correct = zeros(length(selectedfeature),1);
disp('Start classfying')
for i = 1:length(selectedfeature)
    train_data = [train_data data_train_data(:,selectedfeature(i))];
    test_data = [test_data data_test_data(:,selectedfeature(i))];
    model = libsvmtrain(data_train_label, train_data, '-s 0 -t 0 ');
    [predictlabel, ~]  = libsvmpredict(data_test_label, test_data, model);
    label_predict = [label_predict predictlabel];
    correct(i) = length(find(data_test_label(:)==label_predict(:,i)))/length(data_test_label);
end
figure(1)
plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])