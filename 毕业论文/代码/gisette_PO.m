% clear all;
% dataset = xlsread('Dataset\gisette\gisette_train.xlsx');
% data = dataset(1:1000,1:size(dataset,2)-1);
% label = dataset(1:1000,size(dataset,2));
% data_test = xlsread('Dataset\gisette\gisette_valid.xlsx');
% data_test_data = data_test(:,1:size(data_test,2)-1);
% data_test_label = data_test(:,size(data_test,2));
disp('Start PO')
tic
[bestacc, bestc, bestg] = SVMcgForClass(label, data);
OPruningtime = toc
cmd = ['-c ',num2str(bestc),'-g ',num2str(bestg)];
save('resultOfgisette_PO.mat','bestc','bestg','cmd','dataset','data','label','data_test','data_test_data','data_test_label');
disp('Start training model and valid');
model = libsvmtrain(label,data,cmd);
[predictlabel, accuracy] = libsvmpredict(data_test_label,data_test_data,model);