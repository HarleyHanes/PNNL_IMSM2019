function NetworkInvestigate
%UNTITLED3 Main function file for perturbing MatPower Cases to investigate
%impacts on cost
%   Determines settings for network perturbation and iteration

c=loadcase('case30');
m=loadcase(c);
iter=5000;
sd=.5;
mean=1;
perturb=[mean,sd];



[Networks]=NewNetwork(m,iter,perturb);

OutputData(Networks);

%PlotOpf(Networks);

end

