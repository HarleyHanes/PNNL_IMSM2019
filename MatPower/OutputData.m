function OutputData(Network)
%OutputData Saves Network data to matlab file
%   Detailed explanation goes here
iter=size(Network);
ResultsCell={'Results Structure','Case Structure'};
j=2;
for i=1:iter(1)
    if Network{i,end}==1
        ResultsCell(j,1:2)=Network(i,1:2);
        j=j+1;
    end
end
save('NormTest.mat', 'ResultsCell');

