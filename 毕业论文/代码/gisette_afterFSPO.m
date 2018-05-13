load('resultOfgisette_PO.mat')
data = data(1:200,:);
label = label(1:200);
data_test_data = data_test_data(1:200,:);
data_test_label = data_test_label(1:200);
train_data = [];
test_data = [];
label_predict = [];
correct = zeros(length(selectedfeature),1);
disp('Start classfying')
datestr(now)
tic
for i = 1:length(selectedfeature)
    train_data = [train_data data(:,selectedfeature(i))];
    test_data = [test_data data_test_data(:,selectedfeature(i))];
    model = libsvmtrain(label, train_data, '-s 0 -t 0');
    [predictlabel, ~]  = libsvmpredict(data_test_label, test_data, model);
    label_predict = [label_predict predictlabel];
    correct(i) = length(find(data_test_label(:)==label_predict(:,i)))/length(data_test_label);
end
classifyrunningtime = toc
datestr(now)
save('resultOfgisette_PO.mat','label_predict','correct','classifyrunningtime','-append')
figure(1)
plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])