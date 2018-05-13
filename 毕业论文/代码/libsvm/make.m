% This make.m is used under Windows

mex -largeArrayDims -O -c svm.cpp
mex -largeArrayDims -O -c svm_model_matlab.c
mex -largeArrayDims -O libsvmtrain.c svm.obj svm_model_matlab.obj
mex -largeArrayDims -O libsvmpredict.c svm.obj svm_model_matlab.obj
mex -largeArrayDims -O libsvmread.c
mex -largeArrayDims -O libsvmwrite.c
