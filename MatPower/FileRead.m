%File to take individual .mat files and convert them into desired Format
%Supported Formats
%1)Structure of Structures
%2)3-dimensional array Structure
%3)Cell Array of Structures
%% Writing to structure of structures
c=20434;
m=loadcase('case300');
SuccessResults=runopf(m);
folderpath=['C:\\Users\\X1\\OneDrive\\'...      %Folder Location to store
    'Documents\\Student Research\\SAMSI ISSM']; %data
TestID='case300Norm25000Sample';
for i=ceil(c/5):floor(2*c/5)
    f=strcat(folderpath,'\\',TestID,...  %File location for Successes
    '\\','Success','\\',sprintf('NormTestSuccess%d',i));
    load(f);
    SuccessResults(i+1)=Results;
end
SuccessFolder=strcat([folderpath,'\\',TestID,...  %File location for Successes
    '\\','Success','\\','SuccessStruct2.mat']);
save(SuccessFolder,'SuccessResults','-v7.3');
%% Writing to structures of 3 dimensional arrays
c=20434;
m=loadcase('case300');
SuccessStruct=runopf(m);
folderpath=['C:\\Users\\X1\\OneDrive\\'...      %Folder Location to store
    'Documents\\Student Research\\SAMSI ISSM']; %data
TestID='case300Norm25000Sample';
loadlocation=strcat(folderpath,'\\',TestID,'\\','Success');
savelocation=strcat(folderpath,'\\',TestID,'\\','SuccessStruct.mat');
for i=0:c
    f=strcat(loadlocation,'\\',sprintf('NormTestSuccess%d',i));
    load(f);
    SuccessStruct.version(:,:,i+1)=Results.version;
    SuccessStruct.baseMVA(:,:,i+1)=Results.baseMVA;
    SuccessStruct.bus(:,:,i+1)=Results.bus;
    SuccessStruct.gen(:,:,i+1)=Results.gen;
    SuccessStruct.branch(:,:,i+1)=Results.branch;
    SuccessStruct.gencost(:,:,i+1)=Results.gencost;
    SuccessStruct.order(:,:,i+1)=Results.order;
    SuccessStruct.om(:,:,i+1)=Results.om;
    SuccessStruct.x(:,:,i+1)=Results.x;
    SuccessStruct.mu(:,:,i+1)=Results.mu;
    SuccessStruct.f(:,:,i+1)=Results.f;
    SuccessStruct.var(:,:,i+1)=Results.var;
    SuccessStruct.nle(:,:,i+1)=Results.nle;
    SuccessStruct.qdc(:,:,i+1)=Results.qdc;
    SuccessStruct.success(:,:,i+1)=Results.success;
    SuccessStruct.et(:,:,i+1)=Results.et;
    SuccessStruct.raw(:,:,i+1)=Results.raw;
end
save(savelocation,'SuccessStruct','-v7.3')
%% Writing Structures to Cell Arrays
c=4999;
ResultsCell300=cell(c+1,1);
ResultsCell300{1}=runopf('case300');
folderpath=['C:\\Users\\X1\\OneDrive\\'...      %Folder Location to store
    'Documents\\Student Research\\SAMSI ISSM']; %data
TestID='case300Norm25000Sample';
loadlocation=strcat(folderpath,'\\',TestID,'\\','Success');
for i=0:c
    f=strcat(loadlocation,'\\',sprintf('NormTestSuccess%d',i));
    load(f);
    ResultsCell300{i+2}=Results;
end
    