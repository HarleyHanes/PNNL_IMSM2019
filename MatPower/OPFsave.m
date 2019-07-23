function OPFsave(Results,folderpath, TestID,Trim,delete,i)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
SuccessFolder=strcat(folderpath,'\\','Success');
FailureFolder=strcat(folderpath,'\\','Failure');
SuccessFolderT=strcat(folderpath,'\\','SuccessTrimmed');
FailureFolderT=strcat(folderpath,'\\','FailureTrimmed');

Testname=strcat(TestID,sprintf('%d',i));


if Trim==1 
    delete=delete(isfield(Results,delete));
    ResultsTrimmed=rmfield(Results,delete);
end

if Results.success==1
    if Trim==1
        filetrim=strcat(SuccessFolderT,'\\',Testname);
    end
    file=strcat(SuccessFolder,'\\',Testname);
elseif Results.success==0
    if Trim==1
        filetrim=strcat(FailureFolderT,'\\',Testname);
    end
    file=strcat(FailureFolder,'\\',Testname);
end

save(file,'Results');
if Trim==1
    save(filetrim,'ResultsTrimmed');
end

end

