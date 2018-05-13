function selectedFeatures = DISR(k, featureMatrix, classColumn)
%function selectedFeatures = DISR(k, featureMatrix, classColumn)
%
%Computers optimal features according to DISR algorithm from 
%On the Use of variable "complementarity for feature selection" 
%by P Meyer, G Bontempi (2006)
%
%Computes the top k features from
%a dataset featureMatrix with n training examples and m features
%with the classes held in classColumn.
%
%DISR - arg(Xi) max(sum(Xj mem XS)(SimRel(Xij,Y)))
%where SimRel = MI(Xij,Y) / H(Xij,Y)

totalFeatures = size(featureMatrix,2);
classMI = zeros(totalFeatures,1);
unselectedFeatures = ones(totalFeatures,1);
score = 0;
currentScore = 0;
innerScore = 0;
iMinus = 0;
answerFeatures = zeros(k,1);
highestMI = 0;
highestMICounter = 0;
currentHighestFeature = 0;

%create a matrix to hold the SRs of a feature pair. 
%initialised to -1 as you can't get a negative SR.
featureSRMatrix = -(ones(k,totalFeatures));

for n = 1 : totalFeatures
	classMI(n) = mi(featureMatrix(:,n),classColumn);%计算特征与类之间的互信息
	if classMI(n) > highestMI
		highestMI = classMI(n);
		highestMICounter = n;
	end
end
%选出的第一个特征是与类互信息最大的特征
answerFeatures(1) = highestMICounter;
unselectedFeatures(highestMICounter) = 0;


for i = 2 : k
	score = 0;
	currentHighestFeature = 0;
	iMinus = i-1;
  for j = 1 : totalFeatures
		if unselectedFeatures(j) == 1 %对未选择的特征进行处理
			%DISR - arg(Xi) max(sum(Xj mem XS)(SimRel(Xij,Y)))
			%where SimRel = MI(Xij,Y) / H(Xij,Y)
			currentScore = 0;
			for m = 1 : iMinus
        if featureSRMatrix(m,j) == -1 %若对称相关性未被计算
          unionedFeatures = joint([featureMatrix(:,answerFeatures(m)),featureMatrix(:,j)]);%待选特征与已选特征形成联合的特征
				  tempUnionMI = mi(unionedFeatures,classColumn);%计算联合特征与类的互信息
				  tempTripEntropy = h([unionedFeatures,classColumn]);%计算联合特征与类的熵
				  featureSRMatrix(m,j) = tempUnionMI/tempTripEntropy;%SR=I/H
        end
        
				currentScore =  currentScore + featureSRMatrix(m,j);%计算当前分数
			end
			if (currentScore > score) %当前分数与最大分数相比
				score = currentScore;%如果当前的分数大于最大分数，则最大分数等于当前分数
				currentHighestFeature = j;%当前最显著的特征为j
			end
		end
	end
	%now highest feature is selected in currentHighestFeature
	%store it
	unselectedFeatures(currentHighestFeature) = 0;
	answerFeatures(i) = currentHighestFeature;
end

selectedFeatures = answerFeatures;
