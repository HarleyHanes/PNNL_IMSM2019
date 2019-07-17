function [NetworkO] = NewNetwork(m,iter,perturb)
%NewNetwork - making perturbations of the data in the power cases

% m = case number
% iter = how many different perturbations we want to test

% perturb = a two entry vector with the standard deviation and variation of
% a probability distribution for perturbing the values

NetworkO=cell(iter,4); % the cell array to hold the results for opf
NetworkC=cell(iter,4); % the cell array to hold the results for cpf

morig=m; % hold the original case file

[j,k]=size(m.bus); % find the size of the m.bus in the case file

pertval=randn(j,iter)*perturb(2)+perturb(1); % create the perturbation vector


for i=1:iter
    m=morig; %reset to the original m case
    m.bus(:,[3:4])=pertval(i)*m.bus(:,[3,4]); %perturb m.bus
    resultsO=runopf(m); %find the results for this iteration for opf
    resultsC=runcpf(m); %find the results for this iteration for cpf
    NetworkO{i,1}=pertval(i); %store perturbation value for this iteration
    NetworkO{i,2}=m.bus; %store m.bus for this iteration 
    NetworkO{i,3}=results.f; %store the total cost in cell array for opf
    NetworkO{i,4}=results.success; %record if runopf converged or not; 1=converge
    NetworkC{i,1}=pertval(i); %store perturbation value for this iteration
    NetworkC{i,2}=m.bus; %store m.bus for this iteration 
    NetworkC{i,3}=results.f; %store the total cost in cell array for opf
    NetworkC{i,4}=results.success; %record if runopf converged or not; 1=converge

end



end

