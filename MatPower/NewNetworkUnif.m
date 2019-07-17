function [results,Network] = NewNetwork(m,iter)
%NewNetwork - making perturbations of the data in the power cases

% m = case number
% iter = how many different perturbations we want to test

% perturb = a two entry vector with the standard deviation and variation of
% a probability distribution for perturbing the values

Network=cell(iter,5); % the cell array to hold results for opf

morig=m; % hold the original case file

[j,k]=size(m.bus); % find the size of the m.bus in the case file

for i=1:iter
    m=morig; %reset to the original m case
    for n=1:j
        pertval3=(rand()+.5)*morig(n,3); % create the perturbation vector
        pertval4=(rand()+.5)*morig(n,4); % create the perturbation vector
        m.bus(n,3)=pertval3*m.bus(n,3); % perturb m.bus column 3
        m.bus(n,4)=pertval4*m.bus(n,4); % perturb m.bus column 4
    end
    
    results=runopf(m); %find the results for this iteration for opf
    Network{i,1}=results; %store perturbation value for this iteration
    Network{i,2}=m; %store m for this iteration 
    Network{i,3}={results.gen(:,2),results.gen(:,6)}; % record changes in P and V 
    Network{i,4}=results.f; %store the total cost in cell array for opf
    Network{i,5}=results.success; %record if runopf converged or not; 1=converge

end



end
