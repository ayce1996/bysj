close all;clear all;
currentpath = cd;
cd MIToolbox
CompileMIToolbox;
cd(currentpath);
cd FSToolbox
CompileFEAST;
cd ../