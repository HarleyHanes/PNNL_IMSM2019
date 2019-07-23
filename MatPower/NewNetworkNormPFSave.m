function [time] = NewNetworkNormPFSave(m,iter,perturb,mpopt,folderpath, TestID, Trim,delete)
%NewNetwork - making perturbations of the data in the power cases

% m = case number
% iter = how many different perturbations we want to test

% perturb = a two entry vector with the standard deviation and variation of
% a probability distribution for perturbing the values

morig=m; % hold the original case file

[j,k]=size(m.bus); % find the size of the m.bus in the case file

OPFFolder=strcat([folderpath,'\\','OPF']);

PFFolder=strcat([folderpath,'\\','PF']);

f=waitbar(0,'Solving Bus Matrices');

x=3979;y=582;
averagetime=0;
tottime=0;
for i=1:iter
    m=morig; %reset to the original m case
    for n=1:j
        pertval3=randn()*perturb(2)+perturb(1); % create the perturbation vector
        pertval4=randn()*perturb(2)+perturb(1); % create the perturbation vector
        m.bus(n,3)=pertval3*m.bus(n,3); % perturb m.bus column 3
        m.bus(n,4)=pertval4*m.bus(n,4); % perturb m.bus column 4
    end
    if rem(i*iter/10,iter)==0
        waitbar(i/iter,f,'Solving Bus Matrices');
    end
    ResultsOpf=runopf(m,mpopt); %find the results for this iteration for opf
    ResultsPf=runpf(m,mpopt);
    averagetime=(averagetime*(i-1)+ResultsOpf.et)/i;
    tottime=tottime+ResultsOpf.et;
    if ResultsOpf.success==1 && ResultsPf.success==1
        OPFsave(ResultsOpf,OPFFolder, TestID,Trim,delete,x)
        OPFsave(ResultsPf,PFFolder, TestID,Trim,{'order'},x)
        x=x+1;
    elseif ResultsOpf.success==0 && ResultsPf.success==0
        OPFsave(ResultsOpf,OPFFolder, TestID,Trim,delete,y)
        OPFsave(ResultsPf,PFFolder, TestID,Trim,{'order'},y)
        y=y+1;
    else
        warning('Opf and Pf lack same success')
    end
end
time=[tottime averagetime];

end

