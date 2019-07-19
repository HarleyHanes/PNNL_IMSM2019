function OutputData(Network,testtype,folderpath,TestID,Case)
%OutputData Saves Network data to matlab file
%   Detailed explanation goes here
iter=size(Network);
j=0;k=0;  %Setting Indexing
%SuccessStruct=Case;
%FailureStruct=Case;
SuccessFolder=strcat([folderpath,'\\',TestID,...  %File location for Successes
    '\\','Success']);
FailureFolder=strcat([folderpath,'\\',TestID,...  %File location for Failures
    '\\','Failure']);
f=waitbar(0,'Saving Results'); %Loads waitbar
netlocal=strcat(folderpath,'\\',TestID,'\\','Networks');
save(netlocal,'Network');
%%Uniform Distribution
if strcmpi(testtype,'Unif')==1
    for i=1:iter(1)
        if rem(i*iter(1)/10,iter(1))==0
            waitbar(i/iter(1),f,'Saving Results');%Update waitbar every 1%
        end
        if Network{i,end}==1
            c=sprintf('UnifTestSuccess%d.mat',j); %Create filename
            file=strcat(SuccessFolder,'\\',c);    %Combine file location and name
            Results=Network{i,1};                 %Extract Results Structure
            %UnifTestSuccessCell{j+1,1}=Results;   %Save Results Structure to CellArray
                                                  %For future matlab
                                                  %analysis
            save(file,'Results');
            %SuccessStruct(j+2)=Network{i,1};
            j=j+1;                                %Increase indexing for success
        elseif Network{i,end}==0
            c=sprintf('UnifTestFailure%d.mat',j); %Create filename
            file=strcat(FailureFolder,'\\',c);    %Combine file location and name
            Results=Network{i,1};                 %Extract Results Structure
            %UnifTestFailureCell{k+1,1}=Results;   %Save Results Structure to CellArray
                                                  %For future matlab
                                                  %analysis
            save(file,'Results');
            %FailureStruct(k+1)=Network{i,1};
            k=k+1;
        end
    end
    %Saving Cell Arrays
    file=strcat(SuccessFolder,'\\','UnifTestSuccessCell.mat');
    save(file,'UnifTestSuccessCell','-v7.3');
    %file=strcat(SuccessFolder,'\\','SuccessStruct.mat');
    %save(file,'SuccessStruct');
    file=strcat(FailureFolder,'\\','UnifTestFailureCell.mat');
    save(file,'UnifTestFailureCell','-v7.3');
    %file=strcat(FailureFolder,'\\','FailureStruct.mat');
    %save(file,'FailureStruct');
end
%% Normal Distribution
    %See Notes above for line-by-line notes
if strcmpi(testtype,'Norm')==1
    for i=1:iter(1)
        if rem(i*iter(1)/10,iter(1))==0
            waitbar(i/iter(1),f,'Saving Results');
        end
        if Network{i,end}==1
            c=sprintf('NormTestSuccess%d.mat',j);
            file=strcat(SuccessFolder,'\\',c);
            Results=Network{i,1};
            %NormTestSuccessCell{j+1,1}=Results;
            save(file,'Results');
            %SuccessStruct(j+2)=Network{i,1};
            j=j+1;
        elseif Network{i,end}==0
            c=sprintf('NormTestFail%d.mat',k);
            file=strcat(FailureFolder,'\\',c);
            Results=Network{i,1};
            %NormTestFailureCell{k+1,1}=Results;
            save(file,'Results');
            %FailureStruct(k+1)=Network{i,1};
            k=k+1;
        end
    end
    file=strcat(SuccessFolder,'\\','NormTestSuccessCell.mat');
    save(file,'NormTestSuccessCell','-v7.3');
%     file=strcat(SuccessFolder,'\\','SuccessStruct.mat');
%     save(file,'SuccessStruct');
    file=strcat(FailureFolder,'\\','NormTestFailureCell.mat');
    save(file,'NormTestFailureCell','-v7.3');
%     file=strcat(FailureFolder,'\\','FailureStruct.mat');
%     save(file,'FailureStruct');
end
