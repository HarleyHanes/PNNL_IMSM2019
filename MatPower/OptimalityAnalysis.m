function [CasesCheaper] = OptimalityAnalysis(ResultsCell)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Finding Per Cost
[iter,j]=size(ResultsCell);
Optimality=zeros(iter,3);
for i=1:iter
    R=ResultsCell{i};
    Optimality(i,1)=R.f/sum(R.gen(:,2));
    Optimality(i,2)=R.f/sum(R.gen(:,3));
    Optimality(i,3)=R.f/sum(sqrt(R.gen(:,2).^2+R.gen(:,3).^2));
    %TotalPower(i,:)=[sum(R.gen(:,2)),sum(R.gen(:,3)),sum(sqrt(R.gen(:,2).^2+R.gen(:,3).^2))];
end
%sum(TotalPower)
%% Histograms
close all
BusNodes=300;
PowerType={'Real','Reactive','Apparant'};
CasesCheaper=sum(Optimality<Optimality(1,:))/iter;
for i=1:3
    figure
    histogram(Optimality(:,i))
    title(sprintf('Cost per Megawatt Hour of %s Power Produced in %d Node System',PowerType{i},BusNodes))
    legend(sprintf('Base System Cost= %.2f $/(MW*hr) \n%% Cases Cheaper than Base System= %.2f %%',Optimality(1,i),CasesCheaper(i)*100))
    xlabel('$/(MW*hr)')
    ylabel(sprintf('Cases (out of %d)',iter))
end
end

