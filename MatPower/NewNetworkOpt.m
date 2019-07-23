function [time] = NewNetworkNormSave(m,iter,perturb,mpopt,folderpath, TestID, Trim,delete)
%NewNetwork - making perturbations of the data in the power cases

% m = case number
% iter = how many different perturbations we want to test

% perturb = a two entry vector with the standard deviation and variation of
% a probability distribution for perturbing the values

morig=m; % hold the original case file

[j,k]=size(m.bus); % find the size of the m.bus in the case file

MainFolderS=strcat([folderpath,'\\',TestID,...  %File location for Successes
    '\\','Success']);
TrimFolderS=strcat([folderpath,'\\',TestID,...  %File location for Successes
    '\\','SuccessTrimmed']);
MainFolderF=strcat([folderpath,'\\',TestID,...  %File location for Successes
    '\\','Failure']);
TrimFolderF=strcat([folderpath,'\\',TestID,...  %File location for Successes
    '\\','FailureTrimmed']);
f=waitbar(0,'Solving Bus Matrices');

x=0;y=0;
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
    Results=runopf(m,mpopt); %find the results for this iteration for opf
    averagetime=(averagetime*(i-1)+Results.et)/i;
    tottime=tottime+Results.et;
    if Results.success==1
        c=sprintf('NormTestSuccess%d.mat',x); %Create filename
        file=strcat(MainFolderS,'\\',c);
        save(file,'Results');
        if Trim==1
            filetrim=strcat(TrimFolderS,'\\',c);
            if i==1
                delete=delete(isfield(Results,delete));
            end
            Results=rmfield(Results,delete);
            save(filetrim,'Results');
        end
        x=x+1;
    elseif Results.success==0
        c=sprintf('NormTestFailure%d.mat',y); %Create filename
        file=strcat(MainFolderF,'\\',c);
        save(file,'Results');
        if Trim==1
            filetrim=strcat(TrimFolderF,'\\',c);
            if i==1
                delete=delete(isfield(Results,delete));
            end
            Results=rmfield(Results,delete);
            save(filetrim,'Results');
        end
        save(filetrim,'Results');
        y=y+1;
    end
    %Network{i,1}=results; %store m.bus for this iteration
    %Network{i,2}=m; %Stores optimal generator settings
    %Network{i,3}=results.f; %store the total cost in cell array for opf
    %Network{i,4}=results.success; %record if runopf converged or not; 1=converge

end
time=[tottime averagetime];

end

