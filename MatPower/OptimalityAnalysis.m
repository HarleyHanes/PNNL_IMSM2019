function [CasesCheaper] = OptimalityAnalysis(ResultsCell)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Finding Per Cost
[iter,j]=size(ResultsCell);
Optimality=zeros(iter,3);
BusRequirements=zeros(iter,3);
OptimalCost=zeros(iter,1);
for i=1:iter
    R=ResultsCell{i};
    Optimality(i,1)=R.f/sum(R.gen(:,2));
    Optimality(i,2)=R.f/sum(R.gen(:,3));
    Optimality(i,3)=R.f/sum(sqrt(R.gen(:,2).^2+R.gen(:,3).^2));
    BusRequirements(i,1)=sum(R.bus(:,3));
    BusRequirements(i,2)=sum(R.bus(:,4));
    BusRequirements(i,3)=sum(sqrt(R.bus(:,3).^2+R.bus(:,4).^2));
    OptimalCost(i,1)=R.f;
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
%% Correlation Plots\
for i=1:3
    figure
    scatter(Optimality(:,i),OptimalCost)
    title(sprintf('Optimality and Total Cost Correlation for %s Power in %d Node System',PowerType{i},BusNodes))
    xlabel('Optimality $/(MW*hr)')
    ylabel('Total Cost ($/hr)')
end
for i=1:3
    figure
    scatter(Optimality(:,i),BusRequirements(:,i))
    title(sprintf('Optimality and System Demand Correlation for %s Power in %d Node System',PowerType{i},BusNodes))
    xlabel('Optimality $/(MW*hr)')
    ylabel('Total Bus Requirements (MW*hr)')
end
% for i=1:3
%     figure
%     scatter(OptimalCost,BusRequirements(:,i))
%     title(sprintf('Optimality and System Demand Correlation for %s Power in %d Node System',PowerType{i},BusNodes))
%     xlabel('Optimality $/(MW*hr)')
%     ylabel('Total Bus Requirements (MW*hr)')
% end
end


