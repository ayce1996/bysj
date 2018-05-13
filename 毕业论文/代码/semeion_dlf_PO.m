clear all;
dataset = xlsread('Dataset\semeion\semeion_dfl.xlsx');
data = dataset(:,1:size(dataset,2)-1);
label = dataset(:,size(dataset,2));
data_train = xlsread('Dataset\semeion\semeion_dfl_train.xlsx');
data_train_data = data_train(:,1:size(data_train,2)-1);
data_train_label = data_train(:,size(data_train,2));
data_test = xlsread('Dataset\semeion\semeion_dfl_test.xlsx');
data_test_data = data_test(:,1:size(data_test,2)-1);
data_test_label = data_test(:,size(data_test,2));
disp('Start PO')
[bestacc, bestc, bestg] = SVMcgForClass(data_train_label, data_train_data);
cmd = ['-c ',num2str(bestc),'-g ',num2str(bestg)];
save('resultOfsemeion_dfl.mat','bestc','bestg','cmd','-append');
model = libsvmtrain(data_train_label,data_train_data,cmd);
[predictlabel, accuracy] = libsvmpredict(data_test_label,data_test_data,model);