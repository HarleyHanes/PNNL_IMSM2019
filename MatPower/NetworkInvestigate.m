function NetworkInvestigate(c)
%UNTITLED3 Main function file for perturbing MatPower Cases to investigate
%impacts on cost
%   Determines settings for network perturbation and iteration

m=loadcase(c);
iter=100;
var=.1;
mean=1;
perturb=[mean,var];



[Cost,Networks]=NewNetwork(m,iter,perturb);

DisplayNetwork(Cost,Networks);

end

