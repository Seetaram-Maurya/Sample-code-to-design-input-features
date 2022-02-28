
% Created on Mon Feb 28 13:14:27 2022
% @author: Seetaram Maurya

% This code is written to design input features for a single state of the
% machine; similarly, the code can be modified/used to design the input
% features for other states of the machine.

clear all;
close all;
clc;

% load example data to design input features for a health state of the dataset.
load('Example_SensorData');

% use kowledge from histrogram theory and initialization
h = histogram(Example_SensorData);
nbins=h.NumBins;
NumberSamples=1000;
FeaturesSamples=cell(nbins,1);
X_min=min(Example_SensorData);
X_max=max(Example_SensorData);
P=X_min+h.BinWidth;
k=1;

% this loop outputs the designed input features of the shape:[number of
% samples * number of features]
for i=1:nbins
   
    FeaturesSamples{i,:}=Example_SensorData(Example_SensorData>=X_min & Example_SensorData<=P);
    X_min=P;
    P=X_min+h.BinWidth;
    
    LengthSamples=size(FeaturesSamples{i,:},1);
   
    if LengthSamples>=NumberSamples
        DesignedFeatures(:,k)=randsample(FeaturesSamples{i,:},NumberSamples);
        k=k+1;
    end
   
    if P==X_max
        break
    end

end


