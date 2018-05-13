clear all;
%Result of iris
load('resultOfiris_sfl.mat');
figure(1)
subplot(211);plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])
load('resultOfiris_dfl.mat')
subplot(212);plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])


%Result of semeion
load('resultOfsemeion_sfl.mat');
figure(2)
subplot(211);plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])
load('resultOfsemeion_dfl.mat')
subplot(212);plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])

%Result of arcene
load('resultOfarcene.mat');
figure(3)
plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])

%Result of gisette
load('resultOfgisette.mat');
figure(4)
plot(1:length(correct),correct);
xlabel('特征数')
ylabel('正确率')
axis([1 length(correct) 0.98*min(correct) 1.02*max(correct)])