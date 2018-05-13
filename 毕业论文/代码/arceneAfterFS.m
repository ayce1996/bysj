load('resultOfarcene_PO.mat');
train_data = [];
test_data = [];
label_predict = [];
correct = zeros(length(selectedfeature),1);
disp('Start classfying')
tic
for i = 1:length(selectedfeature)
    train_data = [train_data data(1:100,selectedfeature(i))];
    test_data = [test_data data_test_data(1:100,selectedfeature(i))];
    model = libsvmtrain(label, train_data, '-s 0 -t 0');
    [predictlabel, ~]  = libsvmpredict(data_test_label, test_data, model);
    label_predict = [label_predict predictlabel];
    correct(i) = length(find(data_test_label(:)==label_predict(:,i)))/length(data_test_label);
end
classifyruningtime = toc
save('resultOfarcene_PO.mat','label_predict','correct','classifyruningtime','-append')
figure(1)
plot(1:length(correct),correct);
xlabel('������')
ylabel('��ȷ��')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])