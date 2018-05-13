data = xlsread('Dataset\iris\iris_data_dfl.xlsx');
data = data(1:100,:);
data_train = [data(1:25,1:4);data(51:75,1:4)];
data_train_label = [data(1:25,5);data(51:75,5)];
data_test = [data(26:50,1:4); data(76:100,1:4)];
data_test_label =  [data(26:50,5); data(76:100,5)];
model = libsvmtrain(data_train_label, data_train, '-s 0 -t 0');
[predictlable, accuracy] = libsvmpredict(data_test_label, data_test, model);