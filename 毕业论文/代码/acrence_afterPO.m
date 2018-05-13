load('resultOfarcene_PO.mat');
train_data = [];
% train_data = gpuArray(train_data);
test_data = [];
% test_data = gpuArray(test_data);
label_predict = [];
% label_predict = gpuArray(label_predict);
% data = gpuArray(data);
% label = gpuArray(label);
% data_test_data = gpuArray(data_test_data);
% data_test_label = gpuArray(data_test_label);
disp('Start selecting features and classifying')
tic
[selectedfeature] = feast('disr', size(data,2), data, label);
correct = zeros(length(selectedfeature),1);
% correct = gpuArray(correct);
for i = 1:length(selectedfeature)
    train_data = [train_data data(:,selectedfeature(i))];
    test_data = [test_data data_test_data(:,selectedfeature(i))];
    model = libsvmtrain(label,train_data, cmd);
    [predictlabel, ~]  = libsvmpredict(data_test_label, test_data, model);
    label_predict = [label_predict predictlabel];
    correct(i) = length(find(data_test_label(:)==label_predict(:,i)))/length(data_test_label);
end
runningtime = toc
save('resultOfarcene_PO.mat','correct','selectedfeature','label_predict','runningtime','-append');
figure(1)
plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])